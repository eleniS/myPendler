//
//  RouteSettingsVC.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/27/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "RouteSettingsVC.h"
#import "DirectionService.h"
#import "CellWithTextField.h"


@interface RouteSettingsVC ()

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation RouteSettingsVC

@synthesize table;

@synthesize requestType;
@synthesize route;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.route = [[Route alloc] init];
    }
    return self;
}

-(void) loadView{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
    // Once configured, the location manager must be "started".
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    NSString  *btnTitle = @"";
    if([self.requestType isEqualToString:@"offer"])
        btnTitle = NSLocalizedString(@"OFFER_RIDE", nil);
    else if([self.requestType isEqualToString:@"search"])
       btnTitle = NSLocalizedString(@"SEARCH_RIDE", nil);
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:btnTitle style:  UIBarButtonItemStyleDone target:self action:@selector(closeWithRoute:)];
    
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [self.view bounds].size.width, [self.view bounds].size.height) style: UITableViewStyleGrouped];
    self.table.delegate = self;
    //self.table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self.view bounds].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    bgview.opaque = YES;
    bgview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.table.backgroundView = bgview;
    
    [self.table setDataSource:self];
    [self.view addSubview:self.table];

    self.title = NSLocalizedString(@"RIDE_DETAILS", nil);
        
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.a
}

#pragma button functions

-(void) cancel:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void) closeWithRoute:(id) btn{
    
    NSString *fromAddress = ((CellWithTextField *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).cellValue;
    if(![fromAddress isEqualToString:self.route.fromAddress]){
        self.route.fromAddress = fromAddress;
        self.route.fromLocation = CLLocationCoordinate2DMake(0,0);
    }
    self.route.toAddress = ((CellWithTextField *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).cellValue;
    route.type = self.requestType;
    [self.delegate addRoute:self.route];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma UITableView delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *theIdentifier = @"theIdentifier";
	CellWithTextField *cell = [tableView dequeueReusableCellWithIdentifier:theIdentifier];
    
	// If no cell is available, create a new one using the given identifier
	if (cell == nil) {
		cell = [[CellWithTextField alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:theIdentifier];
	}
    
    switch (indexPath.row)
    
    {
        case 0:{
            cell.textLabel.text = NSLocalizedString(@"FROM", nil);

            break;
        }
        case 1:{
            cell.textLabel.text = NSLocalizedString(@"TO", nil);
            break;
        }
    }

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
    
}



#pragma mark - Table view data source
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20.0;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@ ", newLocation);
    
    CellWithTextField *fromCell = (CellWithTextField *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if([fromCell.cellValue isEqualToString:@""]){
        self.route.fromLocation = [newLocation coordinate];
        DirectionService *mds = [[DirectionService alloc] init];
        SEL selector = @selector(setFromField:);
        [mds retrieveAddressFromLat:[NSString stringWithFormat:@"%f", self.route.fromLocation.latitude] andLon:[NSString stringWithFormat:@"%f", self.route.fromLocation.longitude] andSelector:selector withDelegate:self];
    }else{
        [manager stopUpdatingLocation];
    }  
}

-(void) setFromField:(NSDictionary *) res{
    CellWithTextField *fromCell = (CellWithTextField *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSArray *results = [res objectForKey:@"results"];
    if([results count] > 0){
        [fromCell setCellValue:[((NSDictionary *)[results objectAtIndex:0]) objectForKey: @"formatted_address"] ];
        self.route.fromAddress = [((NSDictionary *)[results objectAtIndex:0]) objectForKey: @"formatted_address"];
    }
    
}

@end
