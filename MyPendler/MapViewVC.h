//
//  ViewController.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/26/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Route.h"

@interface MapViewVC : UIViewController<GMSMapViewDelegate, CLLocationManagerDelegate>

-(id) initWithRoute:(Route *) route;

@end
