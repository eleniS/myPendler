//
//  LoginVC.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "LoginVC.h"
#import "CellWithTextField.h"
#import "SignUpVC.h"
#import "ProfileVC.h"
#import "UIButton+CustomStyle.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadView{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    CGFloat height = [self addImageAndReturnHeight];
    self.tableView = [self addTableViewWithTopPadding:height];
    [self addLoginBtn];
    [self addNoAccountBtn];
}

-(CGFloat) addImageAndReturnHeight{
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo512x512.png"]];
    logoView.frame = CGRectMake(90, 0, [self.view bounds].size.height * 0.3, [self.view bounds].size.height * 0.3);
    [self.view addSubview:logoView];
    return logoView.bounds.size.height;
}

-(UITableView *) addTableViewWithTopPadding:(CGFloat) topPadding{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, topPadding , [self.view bounds].size.width, [self.view bounds].size.height * 0.4) style: UITableViewStyleGrouped];
    table.delegate = self;
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self.view bounds].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    bgview.opaque = YES;
    bgview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    table.backgroundView = bgview;
    
    [table setDataSource:self];
    [self.view addSubview:table];
    return table;

}

-(void) addLoginBtn{
    UIButton *myButton = [[UIButton alloc] init];
    myButton.frame = CGRectMake([self.view bounds].size.width * 0.2, [self.view bounds].size.height * 0.55 , [self.view bounds].size.width * 0.6, 44);
    [myButton setTitle:NSLocalizedString(@"LOG_IN", nil) forState:UIControlStateNormal];
    myButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleTopMargin;
    [myButton addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton addOrangeFont];
    [myButton makeGlossy];
    [self.view addSubview:myButton];
}

-(void) addNoAccountBtn{
    UIView *bck = [[UIView alloc] initWithFrame:CGRectMake(0,[self.view bounds].size.height * 0.87 , [self.view bounds].size.width, [self.view bounds].size.height * 0.15) ];
    [self.view addSubview:bck];
    bck.backgroundColor = [UIColor whiteColor];
    UIButton *myButton = [[UIButton alloc] init];
    myButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    myButton.frame = CGRectMake([self.view bounds].size.width * 0.15, [self.view bounds].size.height * 0.9 , [self.view bounds].size.width * 0.7, 44);
    [myButton setTitle:NSLocalizedString(@"NO_ACCOUNT", nil) forState:UIControlStateNormal];
    // add targets and actions
    [myButton addTarget:self action:@selector(noAccountBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton addOrangeFont];
    [myButton makeGlossy];
    [self.view addSubview:myButton];
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


-(void) noAccountBtnClicked:(id) button{
    SignUpVC *signUp = [[SignUpVC alloc] initWithNibName:@"" bundle:nil];
    signUp.delegate = self;
    [self presentViewController:signUp animated:YES completion:nil];
    
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
            cell.textLabel.text = NSLocalizedString(@"EMAIL", nil);
            [cell setPlaceholder:NSLocalizedString(@"EMAIL_PLH", nil)];
            break;
        }
        case 1:{
            cell.textLabel.text = NSLocalizedString(@"PASSWORD", nil);
            [cell setPlaceholder:NSLocalizedString(@"PASSWD_PLH", nil)];
            [cell setSecureTextEntry:YES];
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

#pragma mark - SignUpCompletedDelegate
- (void)showUserProfile:(User *)user{
    NSLog(@"SHow user profile");
    ProfileVC *profileVC = [[ProfileVC alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc]  initWithRootViewController:profileVC];
    [self presentViewController:navigationController animated:YES completion:nil];
    [self removeFromParentViewController];
    
}

@end
