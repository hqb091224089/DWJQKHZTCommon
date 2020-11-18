//
//  DWJQEncryptHelper.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWJQEncryptHelper : NSObject

+ (NSString *)createSecretKey;

+ (NSString*)encrypt:(NSString*)string key:(NSString*)key;
+ (NSString*)decrypt:(NSString*)string key:(NSString*)key;
//md5加密
+ (NSString *)getMd5InfoFromDict:(NSMutableDictionary *)dict;
@end
