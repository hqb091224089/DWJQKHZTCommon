//
//  DWJQUtil.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DWJQUtilImpl [DWJQUtil sharedManager]

@interface DWJQUtil : NSObject

+ (DWJQUtil*)sharedManager;

// DDLOG
+ (void)setupDDLog;

// SDWebImageManager
+ (void)setupSDWebImageManager;

+ (void)openAppStore:(NSString *)appId;


// 保存图片到相册
+ (void)saveImageToAlbum:(UIImage *)image toAlbum:(NSString *)albumName;


// 关闭UIAlertView和UIActionSheet
+ (void)closeModalView;

+ (NSString *)typeForImageData:(NSData *)data;

+ (BOOL)isPwd:(NSString *)pwd complexed:(BOOL)isShowError;
@end
