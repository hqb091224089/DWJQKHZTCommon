//
//  DWJQJSONResponseSerializer.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "AFNetworking.h"

#define kDWJQEncryptHeaderKey         @"transport-security-token"
#define kDWJQEncryptHeaderKeyDebug    @"transport-security-token-debug"

@interface DWJQJSONResponseSerializer : AFJSONResponseSerializer

- (instancetype)init;

@end
