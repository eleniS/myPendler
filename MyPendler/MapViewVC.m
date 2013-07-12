//
//  ViewController.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/26/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "MapViewVC.h"
#import "RouteSettingsVC.h"
#import "DirectionService.h"
#import "User.h"
#import "NSUserDefaults+AccessMethods.h"
#import "ProfileView.h"

@interface MapViewVC ()
@property (nonatomic,strong) Route *route;


@end

@implementation MapViewVC{
    GMSMapView *mapView_;
    UIColor *routeColor;

       
}

-(id)initWithRoute:(Route *)route{
    self = [super init];
    if(self){
        NSLog(@"initWithroute");
        self.route = route;
    }
    return self;
}

- (void)loadView {
 
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.route.fromLocation.latitude
                                                            longitude:self.route.fromLocation.longitude
                                                                 zoom:11];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    self.view = mapView_;
    routeColor = [UIColor orangeColor];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    

    
    self.view = mapView_;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    [self loadDirectionForRoute:self.route];
    
    
    
    // Delay execution of my block for 10 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        [self loadMockRideOffer];
    });
}

-(void) loadMockRideOffer{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 140, self.view.bounds.size.width, 20) ];
    label.text = @"Available drivers";
    label.textColor = [UIColor orangeColor];
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.5f;
    [label setOpaque:NO];
    [self.view addSubview:label];
    NSDictionary *driverData = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Simon", [NSUserDefaults firstNameKey],
                                @"Fischer", [NSUserDefaults lastNameKey],
                                @"simon@clevis.de", [NSUserDefaults emailKey],
                                @"4", [NSUserDefaults ridesSharedKey],
                                @"45" , [NSUserDefaults kmSharedKey],
                                @"6.8 kg", [NSUserDefaults co2SharedKey],
                                @"/Users/elenisiakagianni/Library/Application Support/iPhone Simulator/6.1/Applications/86A9F281-0403-4AD2-A46B-F47E58E790B6/Documents/driver_profile.png", [NSUserDefaults imgFilePath],nil];
    
    Route *driverRoute = [[Route alloc] init];
    [driverRoute setType:@"offer"];
    driverRoute.toAddress = @"UnternehmerTUM";
    driverRoute.toLocation = CLLocationCoordinate2DMake(48.268005, 11.663117);
    driverRoute.fromAddress = @"Wehrlestrasse 12, München";
    driverRoute.fromLocation = CLLocationCoordinate2DMake(48.148441, 11.609261);

    User *myDriver = [[User alloc] initWithData:driverData];

    ProfileView *driverPRofile = [[ProfileView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 120, self.view.bounds.size.width, 120) andUser:myDriver];
    [self.view addSubview:driverPRofile];
    routeColor = [UIColor greenColor];
    [self loadDirectionForRoute:driverRoute];
}


- (void)loadDirectionForRoute:(Route *)route{
    
    NSArray *parameters = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f,%f",route.fromLocation.latitude, route.fromLocation.longitude], [NSString stringWithFormat:@"%f,%f",route.toLocation.latitude, route.toLocation.longitude], nil];
    NSArray *keys = [NSArray arrayWithObjects:@"from", @"to", nil];
    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                      forKeys:keys];
    DirectionService *mds = [[DirectionService alloc] init];
    SEL selector = @selector(addDirections:);
    [mds setDirectionsQuery:query
               withSelector:selector
               withDelegate:self];
    
}

- (void)addDirections:(NSDictionary *)json {
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = routeColor;
    polyline.strokeWidth = 3.f;
    polyline.map = mapView_;
}







@end
