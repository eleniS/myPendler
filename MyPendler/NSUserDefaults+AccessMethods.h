//
//  NSUserDefaults+AccessMethods.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (AccessMethods)


+(BOOL) userLogggedIn;
+(NSDictionary *) userData;
+(NSString *) userEmail;
+(void) saveUserDataWithChanges:(NSDictionary *)changes;

+(NSString *) emailKey;
+(NSString *) firstNameKey;
+(NSString *) lastNameKey;

@end
