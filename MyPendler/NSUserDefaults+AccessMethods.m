//
//  NSUserDefaults+AccessMethods.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "NSUserDefaults+AccessMethods.h"

@implementation NSUserDefaults (AccessMethods)

+(BOOL) userLogggedIn{
    return [NSUserDefaults userEmail] && ![[NSUserDefaults userEmail] isEqualToString:@""];
}

+(NSDictionary *) userData{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user_data"];
}


+(NSString *) userEmail{
    return [[NSUserDefaults userData] objectForKey:@"email"];
}

+(void) saveUserDataWithChanges:(NSDictionary *)changes{
    NSLog(@"Canges %@",changes);
    NSMutableDictionary *userData = [[NSUserDefaults userData] mutableCopy];
    if(!userData ){
        userData = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    [userData addEntriesFromDictionary:changes];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user_data"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+(NSString *) emailKey{
    return @"email";
}

+(NSString *) firstNameKey{
    return @"first_name";
}

+(NSString *) lastNameKey{
    return @"last_name";
}

+(NSString *) ridesSharedKey{
    return @"rides_shared";
}

+(NSString *) kmSharedKey{
    return @"km_shared";
}

+(NSString *) co2SharedKey{
    return @"co2_shared";
}

+(NSString *) imgFilePath{
    return @"img_file_path";
}


@end
