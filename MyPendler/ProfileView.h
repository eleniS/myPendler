//
//  ProfileView.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 7/4/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileView : UIView

-(void) saveImgToDisk:(UIImage *) img;
- (id)initWithFrame:(CGRect)frame andUser:(User *)user;

-(void) resetToDefault;

-(void) loadImgFromFile;
@end
