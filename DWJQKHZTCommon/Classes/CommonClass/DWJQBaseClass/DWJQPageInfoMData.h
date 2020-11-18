//
//  DWJQPageInfoMData.h
//  DWJQ
//
//  Created by luoxingyu on 16/7/12.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseData.h"

@interface DWJQPageInfoMData : DWJQBaseData
@property(nonatomic,retain)NSNumber *page;
@property(nonatomic,retain)NSNumber *pageSize;
@property(nonatomic,retain)NSNumber *total;
@property(nonatomic,retain)NSNumber *isEnd;
-(NSMutableArray *)success:(NSMutableArray *)originArray
                  newArray:(NSArray *)newArray;
@end
