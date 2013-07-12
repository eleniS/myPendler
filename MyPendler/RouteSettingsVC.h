//
//  RouteSettingsVC.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/27/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Route.h"

@protocol RouteDelegate <NSObject>;

-(void) addRoute:(Route *) route;

@end


@interface RouteSettingsVC : UIViewController<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (nonatomic, strong) id<RouteDelegate> delegate;
@property (nonatomic, strong) NSString* requestType;
@property (nonatomic, strong) Route *route;



@end


