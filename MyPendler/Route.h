//
//  Route.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 7/4/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Route : NSObject

@property (nonatomic, strong) NSString *fromAddress;
@property (nonatomic, strong) NSString *toAddress;
@property (nonatomic) CLLocationCoordinate2D fromLocation;
@property (nonatomic) CLLocationCoordinate2D toLocation;

@property (nonatomic, strong) NSString *type;

@end
