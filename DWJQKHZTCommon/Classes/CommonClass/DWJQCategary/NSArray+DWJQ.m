//
//  NSArray+DWJQ.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSArray+DWJQ.h"
#import "DWJQBaseTableViewCell.h"
@implementation NSArray (DWJQ)

+ (NSArray *)arrayWithJSONData:(NSData *)data
{
    NSError *error;
    if (data == nil)
        return nil;
    if ([data length] <= 0)
        return nil;
    
    id ret = [NSJSONSerialization JSONObjectWithData:data
                                             options:NSJSONReadingMutableContainers
                                               error:&error];
    if ([ret isKindOfClass:[NSArray class]]) {
        return ret;
    }
    return nil;
}


+ (NSArray *)arrayWithJSONString:(NSString *)str
{
    if (str) {
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        return [NSArray arrayWithJSONData:jsonData];
    }
    return nil;
}


- (NSString *)toJSONString
{
    NSError * error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0  && error == nil) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        DWJQLOGE(@"toJSONString - error: %@", error );
        return @"";
    }
}
- (NSString *)getMax{
    return [[self valueForKeyPath:@"@max.floatValue"] isNotEmpty]?[self valueForKeyPath:@"@max.floatValue"]:@"0.00";
}
- (NSString *)getMin{
    return [[self valueForKeyPath:@"@min.floatValue"] isNotEmpty]?[self valueForKeyPath:@"@min.floatValue"]:@"0.00";
}
- (BOOL)isExistString:(NSString *)string{
    BOOL isExist = NO;
    for (NSString *str in self) {
        if ([string isEqualToString:str]) {
            isExist = YES;
            break;
        }
    }
    return isExist;
}
- (NSArray *)shuffle
{
    NSUInteger count = [self count];
    NSMutableArray *newArray = [self mutableCopy];
    for (int i = 0; i < count; ++i) {
        int n = (arc4random() % (count - i)) + i;
        [newArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return [newArray copy];
}
- (NSArray *)distinct{
    NSSet *set = [NSSet setWithArray:self];
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
    NSArray *sortSetArray = [set sortedArrayUsingDescriptors:sortDesc];  
    return sortSetArray;
}
- (id)getRandomObject
{
    NSInteger count = self.count;
    NSInteger index = arc4random() % count;
    return [self objectAtIndex:index];
}
@end

@implementation NSArray (DWJQBasetableViewCell)
- (void)removeLastSeparator
{
    DWJQBaseTableViewCell *cell = [self lastObject];
    cell.separatorHidden = YES;
}
@end
