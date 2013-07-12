//
//  UIButton+CustomStyle.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 7/2/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "UIButton+CustomStyle.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (CustomStyle)

-(void) addStrokeBorderWidth:(CGFloat ) width{
    CALayer *thisLayer = self.layer;
    [thisLayer setBorderWidth:width];
    [thisLayer setBorderColor:[[UIColor lightGrayColor] CGColor]];
}

-(void) addOrangeFont{
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
}

-(void) addGreyGradient{

    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    btnGradient.frame = self.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                          (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                          nil];
    [self.layer insertSublayer:btnGradient atIndex:0];
}

- (void)makeGlossy
{
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    CALayer *thisLayer = self.layer;
    

    thisLayer.masksToBounds = NO;

    
    // Give it a shadow
    /*if ([thisLayer respondsToSelector:@selector(shadowOpacity)]) // For compatibility, check if shadow is supported
    {
        thisLayer.shadowOpacity = 0.7;
        thisLayer.shadowColor = [[UIColor blackColor] CGColor];
        thisLayer.shadowOffset = CGSizeMake(0.0, 3.0);
        
        // TODO: Need to test these on iPad
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        {
            thisLayer.rasterizationScale=2.0;
        }
        thisLayer.shouldRasterize = YES; // FYI: Shadows have a poor effect on performance
    }*/
    
    // Add backgorund color layer and make original background clear
    CALayer *backgroundLayer = [CALayer layer];
   // backgroundLayer.cornerRadius = 10.0f;
    backgroundLayer.masksToBounds = YES;
    backgroundLayer.frame = thisLayer.bounds;
    backgroundLayer.backgroundColor=self.backgroundColor.CGColor;
    [thisLayer insertSublayer:backgroundLayer atIndex:0];
    
    thisLayer.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.0f].CGColor;
    
    // Add gloss to the background layer
    CAGradientLayer *glossLayer = [CAGradientLayer layer];
    glossLayer.frame = thisLayer.bounds;
    glossLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.0f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         nil];
    glossLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    [backgroundLayer addSublayer:glossLayer];
}

@end
