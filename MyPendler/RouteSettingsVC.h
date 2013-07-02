//
//  RouteSettingsVC.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/27/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface RouteSettingsVC : UIViewController<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>


@property (nonatomic,strong) NSString* requestType;



@end


