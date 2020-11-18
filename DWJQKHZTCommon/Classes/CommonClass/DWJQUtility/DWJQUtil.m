//
//  DWJQUtil.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQUtil.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

#define XCODE_COLORS "XcodeColors"

//七牛图片 URL：http://7xi80o.com1.z0.glb.clouddn.com
//http://7xjyap.com2.z0.glb.qiniucdn.com/
static NSString * kPrefixURLForQingNiu = @"7xi80o.com";
static NSString * kTruncatedForQingNiu = @"&e=";

@interface DWJQUtil ()

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation DWJQUtil

- (id)init
{
    self = [super init];
    if (self) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

+ (DWJQUtil*)sharedManager
{
    static DWJQUtil *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DWJQUtil alloc] init];
    });
    return _instance;
}


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        char *xcode_colors = getenv(XCODE_COLORS);
        if (xcode_colors && (strcmp(xcode_colors, "YES") != 0))
            
            return;
        setenv(XCODE_COLORS, "YES", 0);
    });
}

+ (void)setupDDLog
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

+ (void)setupSDWebImageManager
{
    [[SDWebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url) {
        NSString * keyString = nil;
        if ( url ) {
            //            url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
            NSString *key = [NSMutableString stringWithString:[url absoluteString]];
            NSString * hostStr = url.host;
            if ( [hostStr hasPrefix:kPrefixURLForQingNiu] ) {
                NSRange range = [key rangeOfString:kTruncatedForQingNiu];
                keyString = [key substringWithRange:NSMakeRange(0, range.location)];
            } else {
                keyString = [url absoluteString];
            }
        }
        return keyString;
    }];
}

/**
 *  在Appstore中打开
 */
+ (void)openAppStore:(NSString *)appId
{
    NSString *iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

+ (void)saveImageToAlbum:(UIImage *)image toAlbum:(NSString *)albumName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [DWJQUtilImpl.library saveImage:image toAlbum:albumName completion:^(NSURL *assetURL, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *msg = @"储存成功";
                [DWJQDialogHelper showSuccessHUD:msg];
            });
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *msg = @"存储失败";
                [DWJQDialogHelper showErrorHUD:msg];
            });
            
        }];
    });
}



+ (NSArray *)allSubviews:(UIView *)view
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray * subviews = view.subviews;
    if (subviews) {
        [array addObjectsFromArray:subviews];
        for (UIView * subView in subviews) {
            NSArray * arraySub = [DWJQUtil allSubviews:subView];
            if (arraySub.count > 0) {
                [array addObjectsFromArray:arraySub];
            }
        }
    }
    return array;
}

+ (void)dismissAllSystemViewInApp
{
    for (UIWindow * windowSub in [[UIApplication sharedApplication] windows]) {
        for (UIView * viewSub in [DWJQUtil allSubviews:windowSub]) {
            if ([viewSub isKindOfClass:[UIAlertView class]]) {
                UIAlertView *alertView = (UIAlertView *)viewSub;
                [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:NO];
            } else if ([viewSub isKindOfClass:[UIActionSheet class]]) {
                UIActionSheet *actionSheet = (UIActionSheet *)viewSub;
                [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:NO];
            }
        }
    }
}

+ (void)closeModalView
{
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        for (UIView* view in window.subviews) {
            [DWJQUtil dismissActionSheetAndAletrtViewInView:view];
        }
    }
}

+ (void)dismissActionSheetAndAletrtViewInView:(UIView*)view
{
    if ([view isKindOfClass:[UIActionSheet class]]) {
        UIActionSheet *actionView = (UIActionSheet *)view;
        [actionView dismissWithClickedButtonIndex:actionView.cancelButtonIndex animated:NO];
    } else if ([view isKindOfClass:[UIAlertView class]]) {
        UIAlertView *alertView = (UIAlertView *)view;
        [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:NO];
    } else {
        for (UIView* subView in view.subviews) {
            [self dismissActionSheetAndAletrtViewInView:subView];
        }
    }
}

+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @".jpeg";
        case 0x89:
            return @".png";
        case 0x47:
            return @".gif";
        case 0x49:
        case 0x4D:
            return @".tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @".webp";
            }
            
            return nil;
    }
    return nil;
}
+ (BOOL)isPwd:(NSString *)pwd complexed:(BOOL)isShowError
{
    BOOL ret = YES;
    if (pwd.length != 6) {
        ret = NO;
        return ret;
    }
    
    NSString *pass123456 = @"01234567890";
    NSString *pass654321 = @"9876543210" ;
    if ([pass123456 rangeOfString:pwd].location != NSNotFound) {
        ret = NO;
        if (isShowError) {
            [DWJQDialogHelper showErrorHUD:@"密码不能为连续的数字，如123456"];
        }
        return ret;
    }
    
    if ([pass654321 rangeOfString:pwd].location != NSNotFound) {
        ret = NO;
        if (isShowError) {
            [DWJQDialogHelper showErrorHUD:@"密码不能为连续的数字，如654321"];
        }
        return ret;
    }
    
    NSInteger n6 = [pwd substringWithRange:NSMakeRange(0, 4)].integerValue;
    NSInteger n7 = [pwd substringWithRange:NSMakeRange(1, 4)].integerValue;
    NSInteger n8 = [pwd substringWithRange:NSMakeRange(2, 4)].integerValue;
    if (n6 % 1111 == 0 || n7 % 1111 == 0 || n8 % 1111 == 0) {
        ret = NO;
        if (isShowError) {
            [DWJQDialogHelper showErrorHUD:@"相同数字不得连续出现4次，如11112"];
        }
        return ret;
    }
    
    NSString  *sub3 = [pwd substringWithRange:NSMakeRange(0, 3)];
    NSString  *_sub3 = [pwd stringByReplacingOccurrencesOfString:sub3 withString:@""];
    if ([_sub3 isEqualToString:@""] || _sub3.length == 0) {
        ret = NO;
        if (isShowError) {
            [DWJQDialogHelper showErrorHUD:@"密码不能过于简单，如123123"];
        }
        return ret;
    }
    
    
    NSString  *sub2 = [pwd substringWithRange:NSMakeRange(0, 2)];
    NSString  *_sub2 = [pwd stringByReplacingOccurrencesOfString:sub2 withString:@""];
    if ([_sub2 isEqualToString:@""] || _sub2.length == 0) {
        ret = NO;
        if (isShowError) {
            [DWJQDialogHelper showErrorHUD:@"密码不能过于简单，如121212"];
        }
        return ret;
    }
    
    NSInteger n1 = [pwd substringWithRange:NSMakeRange(0, 2)].integerValue;

    NSInteger n2 = [pwd substringWithRange:NSMakeRange(2, 2)].integerValue;

    NSInteger n3 = [pwd substringWithRange:NSMakeRange(4, 2)].integerValue;

    if (n1 % 11 == 0 && n2 % 11 == 0 && n3 % 11 == 0) {
        ret = NO;
        if (isShowError) {
            [DWJQDialogHelper showErrorHUD:@"密码不能过于简单，如112233"];
        }
        return ret;
    }
    
    NSInteger n4 = [pwd substringWithRange:NSMakeRange(0, 3)].integerValue;
    
    NSInteger n5 = [pwd substringWithRange:NSMakeRange(3, 3)].integerValue;

    
    if (n4 % 111 == 0 && n5 % 111 == 0) {
        ret = NO;
        if (isShowError) {
            [DWJQDialogHelper showErrorHUD:@"密码不能过于简单，如111222"];
        }
        return ret;
    }
    return ret;
}




@end
