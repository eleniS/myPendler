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


-(id) initWithData:(NSDictionary *)data{
    self = [super init];
    if(self){
        self.email = [data objectForKey:[NSUserDefaults emailKey]];
        self.firstName = [data objectForKey:[NSUserDefaults firstNameKey]];
        self.lastName = [data objectForKey:[NSUserDefaults lastNameKey]];
    }
    return self;
}

-(id) init{
    self = [super init];
    if(self){
        self.firstName = @"";
        self.lastName = @"";
        self.email =@"";
    }
    return self;
}

-(void) save{
    NSLog(@"Save %@ with %@", self.firstName, [NSUserDefaults firstNameKey]);
    NSDictionary *changes = [NSDictionary dictionaryWithObjectsAndKeys: self.email,[NSUserDefaults emailKey],
                             self.firstName, [NSUserDefaults firstNameKey], 
                             self.lastName,[NSUserDefaults lastNameKey], nil];
    NSLog(@"Save changes: %@", changes);
    [NSUserDefaults saveUserDataWithChanges:changes];
    
}


@end
