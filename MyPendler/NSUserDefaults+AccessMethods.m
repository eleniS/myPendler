//
//  NSUserDefaults+AccessMethods.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "NSUserDefaults+AccessMethods.h"

@implementation NSUserDefaults (AccessMethods)


+(NSDictionary *) userData{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user_data"];
}


+(NSString *) userEmail{
    return [[NSUserDefaults userData] objectForKey:@"email"];
}

@end
