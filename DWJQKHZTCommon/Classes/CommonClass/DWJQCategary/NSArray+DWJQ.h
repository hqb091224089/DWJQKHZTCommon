//
//  NSArray+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DWJQ)

+ (NSArray *)arrayWithJSONData:(NSData *)data;
+ (NSArray *)arrayWithJSONString:(NSString *)str;

- (NSString *)toJSONString;
- (NSString *)getMax;
- (NSString *)getMin;
- (NSArray *)shuffle;
- (NSArray *)distinct;
- (id)getRandomObject;

- (BOOL)isExistString:(NSString *)string;

@end
@interface NSArray (DWJQBasetableViewCell)
- (void)removeLastSeparator;

@end
