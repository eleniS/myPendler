//
//  SignUpVC.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/30/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginVC.h"
#import "User.h"

@protocol SignUpCompletedDelegate ;

@interface SignUpVC : LoginVC

@property (nonatomic,weak) id<SignUpCompletedDelegate> delegate;

@end

@protocol SignUpCompletedDelegate<NSObject>


- (void)showUserProfile:(User *)user;

@end
