//
//  ProfileView.m
//  MyPendler
//
//  Created by Eleni Siakagianni on 7/4/13.
//  Copyright (c) 2013 10betterpages GmbH. All rights reserved.
//

#import "ProfileView.h"


@interface ProfileView ()

@property (nonatomic, strong) UIImageView *userPhoto;
@property (nonatomic, strong) User *user;

@end

@implementation ProfileView

@synthesize userPhoto;

- (id)initWithFrame:(CGRect)frame andUser:(User *)user
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  [UIColor grayColor];
        self.user = user ;
        [self addNameLabel];
        [self addProfileImg];
        //[self addLocationLabel];
        [self addRidesLabel];
        [self addKmLabel];
        [self addCo2Label];
    }
    return self;
}


-(void) addProfileImg{

    self.userPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0,0 , 120, 120)];

    [self addSubview:self.userPhoto];
    
    if(!self.user.imgFilePath || [self.user.imgFilePath isEqualToString:@""])
        [self resetToDefault];
    else
        [self loadImgFromFile];
    
}

-(void) resetToDefault{
    self.userPhoto.image = [UIImage imageNamed:@"placeholder_user"];
}

-(void) loadImgFromFile{
    NSLog(@"Img Path: %@", self.user.imgFilePath);
    self.userPhoto.image = [UIImage imageWithContentsOfFile:self.user.imgFilePath];
}

-(void) addNameLabel{
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 200, 20)];
    name.text = [NSString stringWithFormat:@"%@ %@",self.user.firstName, self.user.lastName];
    name.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor whiteColor];
    [self addSubview:name];
    
}

-(void) addLocationLabel{
    UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(130, 20, 160, 20)];
    location.text = @"@Englschalkinger Str.71, 81925";
    location.font = [UIFont systemFontOfSize:12];
    
    location.backgroundColor = [UIColor clearColor];
    location.textColor = [UIColor whiteColor];
    [self addSubview:location];
}


-(void) addRidesLabel{
    UILabel *rides = [[UILabel alloc] initWithFrame:CGRectMake(130, 50, 160, 20)];
    rides.text = [NSString stringWithFormat:@"%@ %@", self.user.ridesShared, NSLocalizedString(@"RIDES_SHARED", nil)];
    rides.font = [UIFont systemFontOfSize:14];
    
    rides.backgroundColor = [UIColor clearColor];
    rides.textColor = [UIColor whiteColor];
    [self addSubview:rides];
}



-(void) addKmLabel{
    UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(130, 70, 160, 20)];
    location.text = [NSString stringWithFormat:@"%@ %@", self.user.kmShared, NSLocalizedString(@"KM_SHARED", nil)];
    location.font = [UIFont systemFontOfSize:14];
    location.backgroundColor = [UIColor clearColor];
    location.textColor = [UIColor whiteColor];
    [self addSubview:location];
}

-(void) addCo2Label{
    UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(130, 90, 160, 20)];
    location.text = [NSString stringWithFormat:@"%@ %@", self.user.co2Shared, NSLocalizedString(@"CO2_SAVED", nil)];
    location.font = [UIFont systemFontOfSize:14];
    
    location.backgroundColor = [UIColor clearColor];
    location.textColor = [UIColor whiteColor];
    [self addSubview:location];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }
    
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, M_PI_2); // + 90 degrees
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
        
        CGContextRotateCTM (bitmap, -M_PI_2); // - 90 degrees
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, -M_PI); // - 180 degrees
    }
    
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

-(void) saveImgToDisk:(UIImage *) img{
    
    UIImage *resizedImg = [self imageWithImage:img scaledToSizeWithSameAspectRatio:CGSizeMake(120,120)];
    NSString *imgName = [NSString stringWithFormat:@"%@.png", self.user.email];
   
    NSData* imageData = UIImagePNGRepresentation(resizedImg);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imgName];
    self.user.imgFilePath = fullPathToFile;
    [self.user save];
    [imageData writeToFile:fullPathToFile atomically:NO];
    NSLog(@"URL : %@", self.user.imgFilePath);
    //TODO Save to server:
    
}

@end
