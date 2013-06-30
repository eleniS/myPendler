//
//  User.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/30/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *password;


-(id) initWithData:(NSDictionary *)data;
-(void) save;

@end
