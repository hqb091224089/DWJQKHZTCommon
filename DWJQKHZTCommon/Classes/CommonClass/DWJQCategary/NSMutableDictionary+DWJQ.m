//
//  NSMutableDictionary+DWJQ.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSMutableDictionary+DWJQ.h"

@implementation NSMutableDictionary (SETVALUE)

- (BOOL)setDWJQObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
        return YES;
    }
    return NO;
}

- (BOOL)setIntObject:(NSInteger)integerValue forKey:(id<NSCopying>)aKey
{
    [self setObject:[NSNumber numberWithInteger:integerValue] forKey:aKey];
    return YES;
}
- (BOOL)setBoolObject:(BOOL)boolValue forKey:(id<NSCopying>)aKey
{
    [self setObject:[NSNumber numberWithBool:boolValue] forKey:aKey];
    return YES;
}
@end
