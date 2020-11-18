//
//  DWJQNetCacheCountData.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWJQNetCacheCountData : NSObject

/**
 *  已经被取走的response
 */
@property (nonatomic,assign) NSInteger markedPageNumber;
/**
 *  当前字典内的页码
 */
@property (nonatomic,assign) NSInteger totalPageNumber;
/**
 *  缓存的长度:默认是5个请求
 */
@property (nonatomic,assign) NSInteger loadSize;

/**
 *  页码作为key response作为value
 */
@property (nonatomic,strong) NSMutableDictionary *cacheResDict;
/**
 *  页码作为key 为0表示没有正在加载中的
 */
@property (nonatomic,assign) NSInteger cacheStateNumber;

/**
 *  加载冲突的时候需要执行的block
 */
@property (nonatomic ,copy)void (^tempSuccess)(id responseObject);
@property (nonatomic ,copy)void (^tempFailure)( NSError *error);

@end
