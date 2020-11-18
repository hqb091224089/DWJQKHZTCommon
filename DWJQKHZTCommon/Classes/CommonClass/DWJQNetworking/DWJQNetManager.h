//
//  DWJQNetManager.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DWJQNetManagerImpl [DWJQNetManager sharedManager]

@interface DWJQNetManager : NSObject

+ (DWJQNetManager*)sharedManager;
- (void)setup;
/**
 Whether or not the network is currently reachable.
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

/**
 Whether or not the network is currently reachable via WWAN.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

/**
 Whether or not the network is currently reachable via WiFi.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;



- (NSString *)netServiceErrorDesc;
- (NSString *)netNotReachalbeDesc;
- (NSString *)netTimeOutDesc;
- (NSString *)netServiceMaintainDesc;
- (NSString *)netForbiddenDesc;
//新开户APP接口错误提示
- (NSString *)newKaiHuNetServiceErrorDesc;
@end
