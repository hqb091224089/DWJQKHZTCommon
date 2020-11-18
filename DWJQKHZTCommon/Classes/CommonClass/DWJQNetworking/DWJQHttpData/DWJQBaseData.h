//
//  DWJQBaseData.h
//  DWJQ
//
//  Created by luoxingyu on 16/5/31.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWJQBaseData : NSObject
- (id)initWithDictionary:(NSDictionary *)dict;
- (void)parse:(NSDictionary *)dict;
- (NSMutableDictionary *)toDictionary;
- (NSMutableDictionary *)toDictionaryWithClassName;
@end
