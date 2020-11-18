//
//  DWJQDeviceHelper.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQDeviceHelper.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "DeviceUtil.h"
#import "DWJQUtil.h"
#import <sys/utsname.h>

static CGFloat mainScreenBrightness;

@implementation DWJQDeviceHelper

/**
 * 设备名
 */
+ (NSString *)deviceName
{
    NSString *name = [[[DeviceUtil alloc]init] hardwareDescription];
    return name;
}
/**
 * 判断是否为全面屏
 */
+ (BOOL )isInfinityScreen
{
    NSString *name = [[[DeviceUtil alloc]init] hardwareDescription];
    return [name isEqualToString:@"iPhone X"]||
    [name isEqualToString:@"iPhone XS"]||
    [name isEqualToString:@"iPhone XS Max"]||
    [name isEqualToString:@"iPhone XS Max China"]||
    [name isEqualToString:@"iPhone XR"];
}
+ (BOOL)isCameraAvailable:(BOOL)isShowAlert
{
    BOOL ret = YES;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        ret = NO;
        if ( isShowAlert ) {
            NSString *title = @"无法打开照相机";
            NSString *msg = @"请在“设置-隐私-相机”选项中允许东吴秀才访问你的相机";
            [DWJQDialogHelper showWithTitle:title message:msg cancelButtonTitle:@"确定" otherButtonTitles:nil actionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }
    }
    return ret;
}

+ (BOOL)isAlbumAvailable:(BOOL)isShowAlert
{
    BOOL ret = YES;
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
        ret = NO;
        if ( isShowAlert ) {
            NSString *title = @"无法打开照片";
            NSString *msg = @"请在“设置-隐私-照片”选项中允许东吴秀才访问你的照片";
            [DWJQDialogHelper showWithTitle:title message:msg cancelButtonTitle:@"确定" otherButtonTitles:nil actionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }
    }
    return ret;
}

+ (BOOL)isRemoteNotificationAvailable
{
    BOOL ret = NO;
    if (IS_GREATER_OR_EQUAL_IOS8_0) {
        ret = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    }
    return ret;
}


+ (void)changeScreentBrightness:(CGFloat)value
{
    mainScreenBrightness = [UIScreen mainScreen].brightness;
    [UIScreen mainScreen].brightness = value;
}

+ (void)restoreScreentBrightness
{
    [UIScreen mainScreen].brightness = mainScreenBrightness;
}

+ (NSString *)randomStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    
    for (int i=0; i<length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex:(NSUInteger)arc4random_uniform((uint32_t)[letters length])]];
    }
    
    return randomString;
}

+ (NSString*)iphoneType {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])
    return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])
        return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])
        return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])
        return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])
        return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])
        return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])
        return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])
        return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])
        return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])
        return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])
        return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])
        return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])
        return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])
        return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])
        return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"])
        return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"])
        return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"])
        return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"])
        return@"iPhone X";
    return @"iOS 其他设备";
}

@end
