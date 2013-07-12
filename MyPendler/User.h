//
//  User.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/30/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *ridesShared;
@property (nonatomic, strong) NSString *kmShared;
@property (nonatomic, strong) NSString *co2Shared;
@property (nonatomic, strong) NSString *imgFilePath;


-(id) initWithData:(NSDictionary *)data;
-(void) save;

@end
