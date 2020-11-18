//
//  DWJQBaseData.m
//  DWJQ
//
//  Created by luoxingyu on 16/5/31.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseData.h"

@implementation DWJQBaseData
- (id)init
{
    self = [super init];
    if (self) {
        ;
    }
    return  self;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [self init];
    if (self) {
        [self parse:dict];
    }
    return self;
}

- (void)parse:(NSDictionary *)dict
{
    
}

- (NSMutableDictionary *)toDictionary
{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        unsigned int propsCount;
        objc_property_t *props = class_copyPropertyList([self class], &propsCount);
        for(int i = 0;i < propsCount; i++)
        {
            objc_property_t prop = props[i];
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            id value = [self valueForKey:propName];
            if(value == nil)
            {
                value = @"";
            }
            else
            {
                value = [self getObjectInternal:value];
            }
            [dic setObject:value forKey:propName];
        }
        return dic;
}

- (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    if([obj isKindOfClass:[DWJQBaseData class]])
    {
        DWJQBaseData *objData = obj;
        return [objData toDictionary];
    }
    return [NSNull null];
}
- (NSString *)description
{
    return [[self toDictionary] toJSONString];
}
- (NSMutableDictionary *)toDictionaryWithClassName
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [self valueForKey:propName];
        if(value == nil)
        {
            value = @"";
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    [dic setObject:NSStringFromClass([self class]) forKey:@"className"];
    return dic;
}
@end
