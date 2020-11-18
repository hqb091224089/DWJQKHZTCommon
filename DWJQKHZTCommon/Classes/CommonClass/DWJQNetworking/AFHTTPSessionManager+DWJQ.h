//
//  AFHTTPSessionManager+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/7/4.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "AFNetworking.h"

@interface AFHTTPSessionManager (DWJQ)
NS_ASSUME_NONNULL_BEGIN
- (NSURLSessionDataTask *)DWJQPOST:(NSString *)URLString
                                 parameters:(id)parameters
                                   progress:(void (^)( NSProgress *uploadProgress))uploadProgress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask * task, NSError *error,id responseObject))failure;
- (NSURLSessionDataTask *)DWJQGET:(NSString *)URLString
                            parameters:(id)parameters
                              progress:(void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(void (^)(NSURLSessionDataTask *task, id  responseObject))success
                               failure:(void (^)(NSURLSessionDataTask * task, NSError *error,id responseObject))failure;
- (NSURLSessionDataTask *)DWJQPOST:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask * task, NSError *error,id responseObject))failure;
NS_ASSUME_NONNULL_END
@end
