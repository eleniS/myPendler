//
//  AppDelegate.h
//  MyPendler
//
//  Created by Eleni Siakagianni on 6/26/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#if DEBUG
#define LFDebug(fmt, ...) \
NSLog(@"%s\tLine:%d\t>>> " fmt,\
__PRETTY_FUNCTION__,\
__LINE__,\
##__VA_ARGS__\
)
#else
#define LFDebug(fmt, ...)
#endif

@class MapViewVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MapViewVC *viewController;

@end
