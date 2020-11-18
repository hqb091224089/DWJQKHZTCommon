//
//  NSDictionary+DWJQ.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSDictionary+DWJQ.h"

#pragma mark - Parsing
@implementation NSDictionary (Parsing)

- (NSString *)parseStringForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)object;
        return tmp.stringValue;
    }
    return nil;
}

- (NSInteger)parseIntegerForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *tmp = (NSString *)object;
        return tmp.integerValue;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)object;
        return tmp.integerValue;
        
    }
    return DWJQUnSetIntValue;
}

- (long long)parseLongLongForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *tmp = (NSString *)object;
        return tmp.longLongValue;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)object;
        return tmp.longLongValue;
    }
    return 0.f;
}

- (BOOL)parseBooleanForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object boolValue];
    }
    if ([object isKindOfClass:[NSString class]]) {
        return [(NSString *)object boolValue];
    }
    return NO;
}

- (NSNumber *)parseNumberForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    }
    return nil;
}

- (NSArray *)parseArrayForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    }
    return nil;
}

- (NSDictionary *)parseDictionaryForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    }
    return nil;
}
- (NSMutableDictionary *)parseMutableDictionaryForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSMutableDictionary class]]) {
        return object;
    }
    return nil;
}
@end

#pragma mark - JSON
@implementation NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data
{
    NSError *error;
    if (data == nil)
        return nil;
    if ([data length] <= 0)
        return nil;
    
    id ret = [NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingMutableContainers
                                               error:&error];
    if ([ret isKindOfClass:[NSDictionary class]]) {
        return ret;
    }
    return nil;
}


+ (NSDictionary *)dictionaryWithJSONString:(NSString *)str
{
    if (str) {
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        return [NSDictionary dictionaryWithJSONData:jsonData];
    }
    return nil;
}


+ (NSDictionary *)dictionaryWithMainBundleJsonFile:(NSString *)fileName
{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    return  [self jsonFileToDictWithFilePath:filePath];
}

+ (NSDictionary *)jsonFileToDictWithFilePath:(NSString *)filePath
{
    NSData *fileData=[NSData dataWithContentsOfFile:filePath];
    if (fileData == nil) return [[NSDictionary alloc] init];
    if ([fileData length] <= 0) return [[NSDictionary alloc] init];
    NSError *error=nil;
    NSDictionary *contentDict=[NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return [[NSDictionary alloc] init];
    } else {
        return contentDict;
    }
}

- (NSString *)toJSONString
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (jsonData == nil || error != nil) {
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end

#pragma mark - URL
@implementation NSDictionary (URL)

- (NSString *)toURLString
{
    NSMutableString *str = [NSMutableString stringWithString:@""];
    
    for (NSString *key in [self allKeys]) {
        if (key) {
            NSString *value = [self objectForKey:key];
            if (value) {
                [str appendFormat:@"%@=%@&", key, value];
            }
        }
    }
    if (str.length > 0) {
        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    }
    
    return str;
}

@end

