//
//  SignUpVC.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/30/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "SignUpVC.h"
#import "CellWithTextField.h"
#import "AppDelegate.h"
#import "User.h"
#import "ProfileVC.h"
#import "UIButton+CustomStyle.h"

@interface SignUpVC ()

@end

@implementation SignUpVC

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

    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    CGFloat height = [self addImageAndReturnHeight];
    self.tableView = [self addTableViewWithTopPadding:height];

    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 200);
    [self addSignUpBtnAtHeight:self.tableView.frame.origin.y + self.tableView.frame.size.height + 10];
    [self addCancelBtnAtHeight:self.tableView.frame.origin.y + self.tableView.frame.size.height + 10];
    

}

-(void) addSignUpBtnAtHeight:(CGFloat ) topPadding{

    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(170, topPadding , 140, 44);
    [myButton setTitle:NSLocalizedString(@"SIGN_UP", nil) forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(signUpBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton addOrangeFont];
    [myButton makeGlossy];
    [self.view addSubview:myButton];
}

-(void) addCancelBtnAtHeight:(CGFloat ) topPadding{

    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(10, topPadding , 140, 44);
    [myButton setTitle:NSLocalizedString(@"CANCEL", nil) forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton addOrangeFont];
    [myButton makeGlossy];
    [self.view addSubview:myButton];
}

-(void) signUpBtnClicked:(id) sender{
    User *user = [[User alloc] init];
    user.firstName = ((CellWithTextField *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).cellValue;
    user.lastName = ((CellWithTextField *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).cellValue;
    user.email = ((CellWithTextField *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).cellValue;
    user.password = ((CellWithTextField *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).cellValue;
    [user save];
    ProfileVC *profileVC = [[ProfileVC alloc] initWithNibName:@"" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc]  initWithRootViewController:profileVC];
    [self presentViewController:navigationController animated:YES completion:nil];

    
   
}

-(void) cancelBtnClicked:(id) sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) dealloc{
    LFDebug(@"");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
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
            cell.textLabel.text = NSLocalizedString(@"FIRST_NAME", nil);
            [cell setPlaceholder:NSLocalizedString(@"FIRST_NAME_PLH", nil)];
            break;
        }
        case 1:{
            cell.textLabel.text = NSLocalizedString(@"LAST_NAME", nil);
            [cell setPlaceholder:NSLocalizedString(@"LAST_NAME_PLH", nil)];
            break;
        }
        case 2:{
            cell.textLabel.text = NSLocalizedString(@"EMAIL", nil);
            [cell setPlaceholder:NSLocalizedString(@"EMAIL_PLH", nil)];
            break;
        }
        case 3: {
            cell.textLabel.text = NSLocalizedString(@"PASSWORD", nil);
            [cell setPlaceholder:NSLocalizedString(@"PASSWD_PLH", nil)];
            [cell setSecureTextEntry:YES];
            break;
        }
    }
    
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
    
}

@end
