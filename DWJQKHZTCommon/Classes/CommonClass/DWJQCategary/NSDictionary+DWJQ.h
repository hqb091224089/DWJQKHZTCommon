//
//  NSDictionary+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Parsing)

- (NSString *)parseStringForKey:(NSString *)key;
- (NSInteger)parseIntegerForKey:(NSString *)key;
- (NSArray *)parseArrayForKey:(NSString *)key;
- (NSNumber *)parseNumberForKey:(NSString *)key;
- (BOOL)parseBooleanForKey:(NSString *)key;
- (NSDictionary *)parseDictionaryForKey:(NSString *)key;
- (long long )parseLongLongForKey:(NSString *)key;
- (NSMutableDictionary *)parseMutableDictionaryForKey:(NSString *)key;
@end

@interface NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data;
+ (NSDictionary *)dictionaryWithJSONString:(NSString *)str;
+ (NSDictionary *)dictionaryWithMainBundleJsonFile:(NSString *)fileName;

- (NSString *)toJSONString;

@end


@interface NSDictionary (URL)

- (NSString *)toURLString;

@end