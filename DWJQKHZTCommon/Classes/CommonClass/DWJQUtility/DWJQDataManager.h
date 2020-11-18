//
//  DWJQDataManager.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DWJQDataManagerImpl [DWJQDataManager sharedManager]

@interface DWJQDataManager : NSObject

// userToken
@property (nonatomic, strong) NSString *userToken;

// 是否加密body
@property (nonatomic, assign) BOOL encryptBody;

+ (DWJQDataManager *)sharedManager;

@end
