//
//  ProfileVC.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/30/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "ProfileVC.h"
#import "User.h"
#import "NSUserDefaults+AccessMethods.h"
#import "AppDelegate.h"
#import "UIButton+CustomStyle.h"
#import "ProfileView.h"
#import "MapViewVC.h"
#import "DirectionService.h"

@interface ProfileVC ()

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) ProfileView *userProfileView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UITableView *routesView;
@property (nonatomic, strong) NSMutableArray *rides;


@end

@implementation ProfileVC

@synthesize user;
@synthesize userProfileView;
@synthesize imagePickerController;
@synthesize routesView;
@synthesize rides;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        LFDebug(@"Data %@",[NSUserDefaults userData] );
        self.user = [[User alloc] initWithData:[NSUserDefaults userData]];
        self.rides = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(void) loadView{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.title = NSLocalizedString(@"MY_PROFILE", nil);
    self.userProfileView = [[ProfileView alloc] initWithFrame:CGRectMake(0, 0 , [self.view bounds].size.width, 120) andUser:self.user];
    [self.view addSubview:self.userProfileView];
    [self addChangeIconBtn];
    [self addOfferRideBtnAtHeight:135];
    [self addSearchRideBtnAtHeight:135];
    [self addRoutesTableView];
    
}

-(void) addRoutesTableView{
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 180,  [self.view bounds].size.width, 30)];
    label.text = @"  My Rides";
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    self.routesView = [[UITableView alloc]initWithFrame:CGRectMake(0, 210 , [self.view bounds].size.width, [self.view bounds].size.height - 210) style:UITableViewStylePlain];
    [self.routesView setBackgroundView:nil];
    [self.routesView  setBackgroundColor:[UIColor clearColor]];
    self.routesView.delegate = self;
    [self.routesView setAllowsSelection:YES];
    self.routesView.dataSource = self;
    [self.view addSubview:self.routesView];
}

-(void) addChangeIconBtn{
    UIButton *changeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 90 , 30, 30)];
    [changeImgBtn setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [changeImgBtn setBackgroundColor:[UIColor whiteColor]];
    [changeImgBtn addTarget:self action:@selector(changeImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:changeImgBtn];
    
}

-(void) addSearchRideBtnAtHeight:(CGFloat ) topPadding{
    
    UIButton *myButton = [[UIButton alloc] init];
    myButton.frame = CGRectMake(10, topPadding , 140, 34);
    [myButton setTitle:NSLocalizedString(@"SEARCH_RIDE", nil) forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton addOrangeFont];
    [myButton makeGlossy];
    [myButton addStrokeBorderWidth:0.4f];
    [self.view addSubview:myButton];
}

-(void) addOfferRideBtnAtHeight:(CGFloat ) topPadding{
    
    UIButton *myButton = [[UIButton alloc] init];
    myButton.frame = CGRectMake(170, topPadding , 140, 34);
    [myButton setTitle:NSLocalizedString(@"OFFER_RIDE", nil) forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(offerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton makeGlossy];
    [myButton addOrangeFont];
    [myButton addStrokeBorderWidth:0.4f];
    [self.view addSubview:myButton];
}

-(void) changeImgBtnClicked:(id) btn{
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate  = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void) searchBtnClicked: (id) btn{
    RouteSettingsVC *routeSettings = [[RouteSettingsVC alloc] init];
    [routeSettings setRequestType:@"search"];
    routeSettings.delegate = self;
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:routeSettings];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void) offerBtnClicked: (id) btn{
    RouteSettingsVC *routeSettings = [[RouteSettingsVC alloc] init];
    [routeSettings setRequestType:@"offer"];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:routeSettings];
    routeSettings.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.userProfileView saveImgToDisk:image];
    [self.userProfileView loadImgFromFile];
    LFDebug(@"User photo selected: %@", image);
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
  
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.imagePickerController.sourceType = sourceType;
    self.imagePickerController.delegate = self;
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma UITableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    LFDebug(@"Number of rows: %d",self.rides.count);
    return self.rides.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFDebug(@"");
	static NSString *theIdentifier = @"theIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theIdentifier];
    	// If no cell is available, create a new one using the given identifier
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:theIdentifier];
	}
    Route *cellRoute = [self.rides objectAtIndex:indexPath.row];

    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor grayColor];
    if([cellRoute.type isEqualToString:@"search"]){
        cell.imageView.image = [UIImage imageNamed:@"passenger.jpg"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"driver.jpg"];

    }
    cell.textLabel.text = [NSString stringWithFormat:@" %@: %@ \n-> %@: %@", NSLocalizedString(@"FROM", nil), [[cellRoute.fromAddress  substringToIndex:28] stringByAppendingString:@"..." ],NSLocalizedString(@"TO", nil), cellRoute.toAddress ];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LFDebug(@"Rides count: %d", self.rides.count);
    MapViewVC *mapView = [[MapViewVC alloc]initWithRoute:[self.rides objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:mapView animated:YES];
}


#pragma RouteDelegate
-(void) addRoute:(Route *)route{
    
    DirectionService *mds = [[DirectionService alloc] init];
    SEL selector = @selector(setToLocation:);
    [mds retrieveCoordinatesFromAddress:route.toAddress andSelector:selector withDelegate:self];
    NSIndexPath *path =  [NSIndexPath indexPathForRow:0 inSection:0];
    [self.rides  addObject:route];
    [self.routesView  insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationBottom];
    
}

-(void) setToLocation:(NSDictionary *)res{
    NSArray *results = [res objectForKey:@"results"];
    Route *r = [self.rides objectAtIndex:0];
    NSDictionary *loc = [[results objectAtIndex:0] objectForKey:@"geometry"] ;
    r.toLocation = CLLocationCoordinate2DMake([[[loc objectForKey:@"location"] objectForKey:@"lat"] doubleValue], [[[loc objectForKey:@"location"] objectForKey:@"lng"] doubleValue]);
}

@end
