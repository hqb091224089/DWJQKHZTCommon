//
//  DWJQNetManager.m
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQNetManager.h"
#import "AFNetworkReachabilityManager.h"

static DWJQNetManager *_instance;

@interface DWJQNetManager()

@end

@implementation DWJQNetManager

+ (DWJQNetManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DWJQNetManager alloc] init];
    });
    
    return _instance;
}

- (void)setup
{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            {
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            {
            }
                break;
        }
    }];
    [manger startMonitoring];
}

- (BOOL)isReachable
{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    return manger.isReachable;
}

- (BOOL)isReachableViaWiFi
{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    return manger.isReachableViaWiFi;
}

- (BOOL)isReachableViaWWAN
{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    return manger.isReachableViaWWAN;
}

- (NSString *)netServiceErrorDesc
{
    NSString *desc = @"网络出现故障，请重试";
    return desc;
}


- (NSString *)netNotReachalbeDesc
{
    NSString *desc = @"网络不可用，请检查您的网络(N000)";
    return desc;
}
- (NSString *)netTimeOutDesc
{
    NSString *desc = @"网络不给力，请重试(N001)";
    return desc;
}
- (NSString *)netServiceMaintainDesc
{
    NSString *desc = @"系统维护中，请稍后再试";
    return desc;
}
- (NSString *)netForbiddenDesc
{
    NSString *desc = @"当前使用该服务的人数过多, 请稍候尝试";
    return desc;
}
//新开户APP接口错误提示
- (NSString *)newKaiHuNetServiceErrorDesc
{
    NSString *desc = @"很抱歉，系统出错了，请稍后重试";
    return desc;
}


@end
