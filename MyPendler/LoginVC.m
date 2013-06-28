//
//  LoginVC.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "LoginVC.h"
#import "CellWithTextField.h"

@interface LoginVC ()

@end

@implementation LoginVC

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
    [self addTableViewWithTopPadding:height];
    [self addLoginBtn];
    [self addSignUpBtn];
}

-(CGFloat) addImageAndReturnHeight{
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo512x512.png"]];
    logoView.frame = CGRectMake(90, 0, [self.view bounds].size.height * 0.3, [self.view bounds].size.height * 0.3);
    [self.view addSubview:logoView];
    return logoView.bounds.size.height;
}

-(void) addTableViewWithTopPadding:(CGFloat) topPadding{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, topPadding , [self.view bounds].size.width, [self.view bounds].size.height * 0.4) style: UITableViewStyleGrouped];
    table.delegate = self;
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self.view bounds].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    bgview.opaque = YES;
    bgview.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    table.backgroundView = bgview;
    
    [table setDataSource:self];
    [self.view addSubview:table];

}

-(void) addLoginBtn{
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake([self.view bounds].size.width * 0.2, [self.view bounds].size.height * 0.55 , [self.view bounds].size.width * 0.6, 44);
    [myButton setTitle:@"Log in" forState:UIControlStateNormal];
    myButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleTopMargin;
    [myButton addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:myButton];
}

-(void) addSignUpBtn{
    UIView *bck = [[UIView alloc] initWithFrame:CGRectMake(0,[self.view bounds].size.height * 0.87 , [self.view bounds].size.width, [self.view bounds].size.height * 0.15) ];
    [self.view addSubview:bck];
    bck.backgroundColor = [UIColor whiteColor];
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake([self.view bounds].size.width * 0.2, [self.view bounds].size.height * 0.9 , [self.view bounds].size.width * 0.6, 44);
    [myButton setTitle:@"No account? Sign up" forState:UIControlStateNormal];
    // add targets and actions
    [myButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
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
            cell.textLabel.text = @"Email";
            [cell setPlaceholder:@"you@example.com"];
            break;
        }
        case 1:{
            cell.textLabel.text = @"Password";
            [cell setPlaceholder:@"xxxxxxxxxx"];
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