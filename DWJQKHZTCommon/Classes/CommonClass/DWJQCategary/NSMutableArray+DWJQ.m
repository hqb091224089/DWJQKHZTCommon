//
//  NSMutableArray+DWJQ.m
//  DWJQ
//
//  Created by 东吴秀财开发 on 16/8/23.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSMutableArray+DWJQ.h"

@implementation NSMutableArray (DWJQ)
- (void)replaceObject:(NSObject *)object1 WithObject:(NSObject *)object2
{
    [self replaceObjectAtIndex:[self indexOfObject:object1] withObject:object2];
}
@end
