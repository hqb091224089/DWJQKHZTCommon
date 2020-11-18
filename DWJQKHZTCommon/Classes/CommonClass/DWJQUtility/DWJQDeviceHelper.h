//
//  DWJQDeviceHelper.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWJQDeviceHelper : NSObject

+ (NSString *)deviceName;
/**
 * 判断是否为全面屏
 */
+ (BOOL )isInfinityScreen;
/**
 *  是否授权使用相机
 *  isShowAlert: 未授权时，是否提示
 */
+ (BOOL)isCameraAvailable:(BOOL)isShowAlert;

/**
 *  是否授权使用相册
 *  isShowAlert: 未授权时，是否提示
 */
+ (BOOL)isAlbumAvailable:(BOOL)isShowAlert;

/**
 *  系统通知是否打开
 *
 */
+ (BOOL)isRemoteNotificationAvailable;


/**
 *  修改屏幕亮度
 *
 */
+ (void)changeScreentBrightness:(CGFloat)value;

/**
 *  恢复屏幕亮度
 *
 */
+ (void)restoreScreentBrightness;
/**
 *  生成随机长度的字符窜
 *
 */
+ (NSString *)randomStringWithLength:(NSInteger)length;



/**
 手机型号
 */
+ (NSString*)iphoneType;

@end
