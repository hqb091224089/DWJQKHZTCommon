//
//  DWJQNetCacheCountData.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQNetCacheCountData.h"

@implementation DWJQNetCacheCountData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _markedPageNumber = 0;
        _totalPageNumber = 0;
        _cacheResDict = [NSMutableDictionary dictionary];
        _loadSize = 1;
        _cacheStateNumber = 0;
    }
    return self;
}

@end
