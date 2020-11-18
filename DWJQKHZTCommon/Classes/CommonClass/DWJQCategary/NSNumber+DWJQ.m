//
//  NSNumber+DWJQ.m
//  DWJQ
//
//  Created by luoxingyu on 16/7/12.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSNumber+DWJQ.h"

@implementation NSNumber (DWJQ)
- (BOOL)isNotEmpty
{
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }else{
        return YES;
    }
}
@end
