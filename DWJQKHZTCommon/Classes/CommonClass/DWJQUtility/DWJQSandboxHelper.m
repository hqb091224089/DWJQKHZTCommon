//
//  DWJQSandboxHelper.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/18.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQSandboxHelper.h"

static NSString * versionKey=@"DWJQVersionNumber";
static NSString * ADUrlKey=@"ADUrlKey";

@implementation DWJQSandboxHelper

+ (BOOL)hasLive:(NSString *)path
{
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    return NO;
}

+ (NSString *)homePath
{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/Caches"];
}

+ (NSString *)tmpPath
{
    return NSTemporaryDirectory();
}


// 用户数据根路径
+ (NSString *)userDataRootPath
{
    NSString *docPath = [DWJQSandboxHelper docPath];
    NSString *ret = [docPath stringByAppendingString:@"/DWJQuser/"];
    [DWJQSandboxHelper hasLive:ret];
    return ret;
}

// 缓存根路径
+ (NSString *)cacheRootPath
{
    NSString *libCachePath = [DWJQSandboxHelper libCachePath];
    NSString *ret = [libCachePath stringByAppendingString:@"/DWJQcache/"];
    [DWJQSandboxHelper hasLive:ret];
    return ret;
}

+ (NSString *)fontPlistPath
{
    NSString * fontFile = [[NSBundle mainBundle] pathForResource:@"font" ofType:@"plist"];
    return fontFile;
}

+ (NSString *)userDataPath
{
    NSString *docPath = [DWJQSandboxHelper userDataRootPath];
    NSString *ret = [docPath stringByAppendingString:@"userData"];
    return ret;
}
+ (NSString *)quickNewsReadedPath
{
    NSString *docPath = [DWJQSandboxHelper userDataRootPath];
    NSString *ret = [docPath stringByAppendingString:@"feedTagHistory"];
    [self hasLive:ret];
    return ret;
}

+ (NSString *)quickNewsReadedPath:(NSString *)userId
{
    NSString *ret = [self quickNewsReadedPath];
    if (userId.length > 0) {
        ret = [ret stringByAppendingFormat:@"/%@", userId];
    }
    return ret;
}
+ (NSString *)myUrlDataPath
{
    NSString *docPath = [DWJQSandboxHelper userDataRootPath];
    NSString *ret = [docPath stringByAppendingString:@"urlPath/"];
    [self hasLive:ret];
    return ret;
}

+ (NSString *)myUrlDataPath:(NSString *)pathKey withRequestName:(NSString *)reqName{
    NSString *docPath = [DWJQSandboxHelper userDataRootPath];
    NSString *ret = [docPath stringByAppendingString:[NSString stringWithFormat:@"urlPath/%@/",reqName]];
    [self hasLive:ret];
    if (pathKey.length > 0) {
        ret = [ret stringByAppendingFormat:@"%@",pathKey];
    }
    return ret;
}
+ (NSString *)dwjqDeviceID
{
    NSString *deviceID = [[NSUserDefaults standardUserDefaults]objectForKey:@"dwjqDeviceID"];
    if (deviceID.length > 0) {
        return deviceID;
    }else{
        deviceID = [DWJQDeviceHelper randomStringWithLength:24];
        [[NSUserDefaults standardUserDefaults]setObject:deviceID forKey:@"dwjqDeviceID"];
    }
    return deviceID;
}
+ (NSString *)statisUserDataPath
{
    NSString *docPath = [DWJQSandboxHelper userDataRootPath];
    NSString *ret = [docPath stringByAppendingString:@"statisPath/statis"];
    [self hasLive:ret];
    return ret;
}
+(NSString *)studyPDFPath:(NSString *)pdfName{
    if (pdfName.length == 0) {
        return nil;
    }
    NSString *docPath = [DWJQSandboxHelper tmpPath];
    NSString *ret = [docPath stringByAppendingString:@"studyPDF/"];
    [self hasLive:ret];
    ret = [ret stringByAppendingFormat:@"%@",pdfName];
    return  ret;
}
+ (NSString *)functionListDataPath
{
    NSString *docPath = [DWJQSandboxHelper docPath];
    NSString *ret = [docPath stringByAppendingString:@"/functionListPath"];
    [self hasLive:ret];
    return ret;
}
#pragma mark -- 删除的三个级别

+ (void)removeDateWithLevel:(DWJQSandboxHelperRemoveLevel)level
{
    switch (level) {
        case DWJQSandboxHelperRemoveLevelOne:
            [self removeLeveOne];
            break;
        case DWJQSandboxHelperRemoveLevelTwo:
        {
            [self removeLeveOne];
            [self removeLeveTwo];
        }
            break;
        case DWJQSandboxHelperRemoveLevelThree:
        {
            [self removeLeveOne];
            [self removeLeveTwo];
            [self removeLeveThree];
        }
            break;
        default:
            break;
    }
}
+ (void)removeLeveOne
{
#ifndef DWKH
    //图片
    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:nil];
    //网络
#endif
    [DWJQFileHelper removeFolderAtPath:[DWJQSandboxHelper myUrlDataPath]];
    //录音
    [DWJQFileHelper removeFolderAtPath:[DWJQSandboxHelper cacheRootPath]];
    //临时文件夹
    [DWJQFileHelper removeFolderAtPath:[DWJQSandboxHelper tmpPath]];
}
+ (void)removeLeveTwo
{
    //快闻的阅读记录
    [DWJQFileHelper removeFolderAtPath:[DWJQSandboxHelper quickNewsReadedPath]];
    
    //是否第一次登陆
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:versionKey];
    
    //广告的URL
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:ADUrlKey];
    
}
+ (void)removeLeveThree
{
    //account/memeber/userToken/project/city
    [DWJQFileHelper removeFolderAtPath:[DWJQSandboxHelper userDataPath]];
}

@end
