//
//  DWJQCommonMacro.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#ifndef DWJQCommonMacro_h
#define DWJQCommonMacro_h

// 1.
#define DWJQSharedApplication         ([UIApplication sharedApplication])
#define DWJQSharedApplicationDelegate ((AppDelegate *)[DWJQSharedApplication delegate])

#define DWJQAppKeyWindow              (DWJQSharedApplication.keyWindow)

#define DWJQMainBundle                [[NSBundle mainBundle] infoDictionary]
#define kDWJQAppBundleId              ([DWJQMainBundle objectForKey:(__bridge NSString *)kCFBundleIdentifierKey])
#define kDWJQAppVersion               ([DWJQMainBundle objectForKey:@"CFBundleShortVersionString"])
#define kDWJQAppBuildVersion          ([DWJQMainBundle objectForKey:@"CFBundleVersion"])

#define DWJQWeakSelf                  typeof(self) __weak weakSelf = self


// 3.
#define SYSTEM_VERSION_COMPARE_TO(v, order)                  \
([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] == (order))

#define SYSTEM_VERSION_EQUAL_TO(v) SYSTEM_VERSION_COMPARE_TO(v, NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) SYSTEM_VERSION_COMPARE_TO(v, NSOrderedDescending)
#define SYSTEM_VERSION_LESS_THAN(v) SYSTEM_VERSION_COMPARE_TO(v, NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) !SYSTEM_VERSION_LESS_THAN(v)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) !SYSTEM_VERSION_GREATER_THAN(v)


// >= 7
#define IS_GREATER_OR_EQUAL_IOS7 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))

// < 7.1
#define IS_LESS_IOS7_1 (SYSTEM_VERSION_LESS_THAN(@"7.1"))

// >= 7.1
#define IS_GREATER_OR_EQUAL_IOS7_1 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.1"))

// >=8.0
#define IS_GREATER_OR_EQUAL_IOS8_0 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))

// >=8.1
#define IS_GREATER_OR_EQUAL_IOS8_1 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.1"))

// < 8.2
#define IS_LESS_IOS8_2 (SYSTEM_VERSION_LESS_THAN(@"8.2"))


#endif /* DWJQCommonMacro_h */
