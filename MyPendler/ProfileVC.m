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

@interface ProfileVC ()

@property (nonatomic,strong) User *user;

@end

@implementation ProfileVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        LFDebug(@"Data %@",[NSUserDefaults userData] );
        self.user = [[User alloc] initWithData:[NSUserDefaults userData]];
    }
    return self;
}

-(void) loadView{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.title = [NSString stringWithFormat:@"%@ %@",self.user.firstName, self.user.lastName];
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

@end
