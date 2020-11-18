//
//  DWJQLogMacro.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#ifndef DWJQLogMacro_h
#define DWJQLogMacro_h

#import "DDLog.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

// 1
#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif

// 2
#define USEDDLOG 1
#ifdef USEDDLOG
#define LOGI(format, ...) DDLogInfo((@"LOG INFO(f:%s l:%d)=>\r\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LOGE(format, ...) DDLogError((@"LOG ERROR(f:%s l:%d)=>\r\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define LOGI(format, ...) NSLog((@"LOG INFO(f:%s l:%d)=>\r\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define LOGE(format, ...) NSLog((@"LOG ERROR(f:%s l:%d)=>\r\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif


#ifdef DEBUG
#define DWJQLOGI(format, ...) LOGI(format, ##__VA_ARGS__)
#define DWJQLOGE(format, ...) LOGE(format, ##__VA_ARGS__)
#else
#define DWJQLOGI(format, ...)
#define DWJQLOGE(format, ...)
#endif

#endif /* DWJQLogMacro_h */
