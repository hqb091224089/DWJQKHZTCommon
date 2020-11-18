//
//  NSData+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/5/30.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DWJQ)
- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256CBCEncryptWithKey:(NSString *)key;//加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
- (NSData *)MD5;
- (NSData *)AES256CBCDecryptWithKey:(NSString *)key;
@end
