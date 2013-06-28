//
//  NSUserDefaults+AccessMethods.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/28/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (AccessMethods)

+(NSDictionary *) userData;
+(NSString *) userEmail;

@end
