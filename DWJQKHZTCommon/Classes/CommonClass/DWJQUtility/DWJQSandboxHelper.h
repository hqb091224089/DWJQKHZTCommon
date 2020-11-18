//
//  DWJQSandboxHelper.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/18.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DWJQSandboxHelperRemoveLevelZero = 0,//什么也不做
    DWJQSandboxHelperRemoveLevelOne  = 1,//删除级别一
    DWJQSandboxHelperRemoveLevelTwo  = 2,//删除级别二
    DWJQSandboxHelperRemoveLevelThree= 3,//删除级别三
} DWJQSandboxHelperRemoveLevel;

@interface DWJQSandboxHelper : NSObject

/**
 *  程序主目录，可见子目录(3个):Documents、Library、tmp
 */
+ (NSString *)homePath;

/**
 *  程序目录，不能存任何东西
 */
+ (NSString *)appPath;

/**
 *  文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
 */
+ (NSString *)docPath;

/**
 *  配置目录，配置文件存这里
 */
+ (NSString *)libPrefPath;

/**
 *  缓存目录，系统永远不会删除这里的文件，ITUNES会删除
 */
+ (NSString *)libCachePath;

/**
 *  临时缓存目录，APP退出后，系统可能会删除这里的内容
 *
 */
+ (NSString *)tmpPath;
/**
 *  DWJQ缓存根路径
 *
 */
+ (NSString *)cacheRootPath;

/**
 *  判断目录是否存在，不存在则创建
 *
 */
+ (BOOL)hasLive:(NSString *)path;

/**
 *  用户阅读快讯的历史记录
 */
+ (NSString *)quickNewsReadedPath:(NSString *)userId;

/*
 * 网络缓存
 */
+ (NSString *)myUrlDataPath:(NSString *)pathKey withRequestName:(NSString *)reqName;
/**
 *  字体适配库
 */
+ (NSString*)fontPlistPath;
/**
 *  用户数据
 */
+ (NSString *)userDataPath;
/**
 *  网络缓存根路径
 *
 */
+ (NSString *)myUrlDataPath;
/**
 *  设备标志
 */
+ (NSString *)dwjqDeviceID;
/**
 *  用户分析数据
 *
 */
+ (NSString *)statisUserDataPath;
/**
 *  功能列表
 *
 */
+ (NSString *)functionListDataPath;
#pragma mark -- 删除的三个级别
+ (void)removeDateWithLevel:(DWJQSandboxHelperRemoveLevel)level;
@end
