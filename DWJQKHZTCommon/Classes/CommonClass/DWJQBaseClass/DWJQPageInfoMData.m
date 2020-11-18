//
//  DWJQPageInfoMData.m
//  DWJQ
//
//  Created by luoxingyu on 16/7/12.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQPageInfoMData.h"

@implementation DWJQPageInfoMData
- (id)init
{
    self = [super init];
    if (self) {
        self.page = @1;
        self.pageSize = @10;
        self.total = @0;
        self.isEnd = @1;
    }
    return  self;
}
-(NSMutableArray *)success:(NSMutableArray *)originArray newArray:(NSArray *)newArray{
    if (self.page.integerValue == 1) {
        [originArray removeAllObjects];
        originArray = [NSMutableArray array];
    }
    if([newArray count]>0){
        [originArray addObjectsFromArray:newArray];
    }
    return originArray;
}

@end
