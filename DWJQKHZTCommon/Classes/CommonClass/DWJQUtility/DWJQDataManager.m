//
//  DWJQDataManager.m
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQDataManager.h"

@implementation DWJQDataManager

+ (DWJQDataManager*)sharedManager
{
    static DWJQDataManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DWJQDataManager alloc] init];
    });
    
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.encryptBody = NO;
    }
    return self;
}


@end
