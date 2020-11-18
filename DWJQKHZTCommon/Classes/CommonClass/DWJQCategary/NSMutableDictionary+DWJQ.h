//
//  NSMutableDictionary+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SETVALUE)

- (BOOL)setDWJQObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (BOOL)setIntObject:(NSInteger)integerValue forKey:(id<NSCopying>)aKey;
- (BOOL)setBoolObject:(BOOL)boolValue forKey:(id<NSCopying>)aKey;

@end