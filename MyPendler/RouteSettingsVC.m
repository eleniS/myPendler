//
//  RouteSettingsVC.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/27/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "RouteSettingsVC.h"


@interface RouteSettingsVC ()

@property (nonatomic, strong) UITableView *table;

@end

@implementation RouteSettingsVC{
    NSString *type ;
    
}

@synthesize table;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadView{
    NSLog(@"LoadView");
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.title = type;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeWithRoute)];
    self.navigationItem.rightBarButtonItem = done;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [self.view bounds].size.width, [self.view bounds].size.height) style: UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self.view bounds].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    bgview.opaque = YES;
    bgview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.table.backgroundView = bgview;
    
    [self.table setDataSource:self];
    [self.view addSubview:self.table];
    
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

#pragma button functions

-(void) cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) closeWithRoute{
    
}

#pragma public methods

-(void) originalPointWithLocation:(CLLocation *)location{
    
}

-(void) requestType:(NSString *)requestType{
    type = requestType;
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
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theIdentifier];
    
	// If no cell is available, create a new one using the given identifier
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:theIdentifier];
	}
    
    switch (indexPath.row)
    
    {
        case 0:{
            cell.textLabel.text = @"From";
            UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(0,10,200,25)];
            myTextField.adjustsFontSizeToFitWidth = NO;
            myTextField.backgroundColor = [UIColor clearColor];
            myTextField.textColor = cell.detailTextLabel.textColor;
            myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            myTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            myTextField.keyboardType = UIKeyboardTypeDefault;
            myTextField.returnKeyType = UIReturnKeyDone;
            myTextField.clearButtonMode = UITextFieldViewModeNever;
            cell.accessoryView = myTextField;
            break;
        }
        case 1:{
            cell.textLabel.text = @"To";
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

@end
