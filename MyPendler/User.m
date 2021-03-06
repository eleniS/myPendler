//
//  User.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/30/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "User.h"
#import "NSUserDefaults+AccessMethods.h"

@implementation User


@synthesize email;
@synthesize firstName;
@synthesize lastName;
@synthesize password;
@synthesize co2Shared;
@synthesize kmShared;
@synthesize ridesShared;


-(id) initWithData:(NSDictionary *)data{
    self = [super init];
    if(self){
        self.email = [data objectForKey:[NSUserDefaults emailKey]];
        self.firstName = [data objectForKey:[NSUserDefaults firstNameKey]];
        self.lastName = [data objectForKey:[NSUserDefaults lastNameKey]];
        self.kmShared = [data objectForKey:[NSUserDefaults kmSharedKey]];
        self.co2Shared = [data objectForKey:[NSUserDefaults co2SharedKey]];
        self.ridesShared = [data objectForKey:[NSUserDefaults ridesSharedKey]];
        self.imgFilePath = [data objectForKey:[NSUserDefaults imgFilePath]];
    }
    return self;
}

-(id) init{
    self = [super init];
    if(self){
        self.firstName = @"";
        self.lastName = @"";
        self.email = @"";
        self.ridesShared = @"0";
        self.co2Shared = @"0";
        self.kmShared = @"0";
        self.imgFilePath = @"";
    }
    return self;
}

-(void) save{
    NSLog(@"Save %@ with %@", self.firstName, [NSUserDefaults firstNameKey]);
    NSDictionary *changes = [NSDictionary dictionaryWithObjectsAndKeys:
                             self.email,[NSUserDefaults emailKey],
                             self.firstName, [NSUserDefaults firstNameKey], 
                             self.lastName,[NSUserDefaults lastNameKey],
                             self.ridesShared, [NSUserDefaults ridesSharedKey],
                             self.kmShared, [NSUserDefaults kmSharedKey],
                             self.co2Shared, [NSUserDefaults co2SharedKey],
                             self.imgFilePath,[NSUserDefaults imgFilePath], nil];
    NSLog(@"Save changes: %@", changes);
    [NSUserDefaults saveUserDataWithChanges:changes];
    
}


@end
