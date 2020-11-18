//
//  DWJQEncryptHelper.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQEncryptHelper.h"

@implementation DWJQEncryptHelper
+ (NSString *)createSecretKey
{
    return @"";
}
+ (NSString*)encrypt:(NSString*)string key:(NSString*)key
{
    return string;
}
+ (NSString*)decrypt:(NSString*)string key:(NSString*)key
{
    return string;
}

+ (NSString *)getMd5InfoFromDict:(NSMutableDictionary *)dict
{
    NSString *strInfo = [[NSString alloc]init];
    NSArray *allKeys  = [[NSArray alloc]initWithArray:[[dict allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    for (NSString *key in allKeys) {
        if ([[dict parseStringForKey:key] isNotEmpty]) {
            strInfo = [strInfo stringByAppendingString:key];
            strInfo = [strInfo stringByAppendingString:@"="];
            strInfo = [strInfo stringByAppendingString:[dict parseStringForKey:key]];
            strInfo = [strInfo stringByAppendingString:@"&"];
        }
    }
    if (strInfo.length > 0) {
        strInfo = [strInfo substringWithRange:NSMakeRange(0,strInfo.length-1)];
    }
    strInfo = [strInfo stringByAppendingString:SECRETKEY.MD5].MD5;
    return strInfo;
}

@end
