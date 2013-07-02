//
//  DirectionService.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/26/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "DirectionService.h"

@implementation DirectionService{
@private
    BOOL _sensor;
    BOOL _alternatives;
    NSURL *_directionsURL;
    NSArray *_waypoints;
}

static NSString *kMDDirectionsURL = @"http://maps.googleapis.com/maps/api/directions/json?";

- (void)setDirectionsQuery:(NSDictionary *)query withSelector:(SEL)selector
              withDelegate:(id)delegate{
    NSArray *waypoints = [query objectForKey:@"waypoints"];
    NSString *origin = [waypoints objectAtIndex:0];
    int waypointCount = [waypoints count];
    int destinationPos = waypointCount -1;
    NSString *destination = [waypoints objectAtIndex:destinationPos];
    NSString *sensor = [query objectForKey:@"sensor"];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=%@",
     kMDDirectionsURL,origin,destination, sensor];
    if(waypointCount>2) {
        [url appendString:@"&waypoints=optimize:true"];
        int wpCount = waypointCount-2;
        for(int i=1;i<wpCount;i++){
            [url appendString: @"|"];
            [url appendString:[waypoints objectAtIndex:i]];
        }
    }
    NSString *urlFinal = [url
           stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    _directionsURL = [NSURL URLWithString:urlFinal];
    [self retrieveDirections:selector withDelegate:delegate];
}
- (void)retrieveDirections:(SEL)selector withDelegate:(id)delegate{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data =
        [NSData dataWithContentsOfURL:_directionsURL];
        [self fetchedData:data withSelector:selector withDelegate:delegate];
    });
}

-(void) fetchDataFromUrl:(NSURL *)url withSelector:(SEL)selector andDelegate:(id)delegate{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data =
        [NSData dataWithContentsOfURL:[url copy]];
        [self fetchedData:data withSelector:selector withDelegate:delegate];
    });
    
}

-(void) retrieveAddressFromLat:(NSString *)lat andLon:(NSString *)lon andSelector:(SEL)selector withDelegate:(id)delegate{

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",lat,lon ]];
    NSLog(@"Reversr Geocoding %@", url);
    [self fetchDataFromUrl:url withSelector:selector andDelegate:delegate];
    
}

-(void) retrieveCoordinatesFromAddress:(NSString *)address andSelector:(SEL)selector withDelegate:(id)delegate{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",address ]];
    NSLog(@"Reversr Geocoding %@", url);
    [self fetchDataFromUrl:url withSelector:selector andDelegate:delegate];
    
}

- (void)fetchedData:(NSData *)data
       withSelector:(SEL)selector
       withDelegate:(id)delegate{
    
    NSError* error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    [delegate performSelector:selector withObject:json];
}

@end
