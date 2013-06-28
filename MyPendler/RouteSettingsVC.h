//
//  RouteSettingsVC.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/27/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol RouteSearchDelegate;



@interface RouteSettingsVC : UIViewController<UITableViewDelegate, UITableViewDataSource,  UITextFieldDelegate>

@property (nonatomic, weak) id<RouteSearchDelegate> delegate;

-(void) originalPointWithLocation:(CLLocation *)location;

@end


@protocol RouteSearchDelegate<NSObject>


- (void)routeSettingsVC:(RouteSettingsVC*)viewController;

@end
