//
//  NSString+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>



@interface NSString (Encoded)

- (NSString *)urlEncodedString;
- (NSString *)urlEncoded;
- (NSString *)md5EncodedString;
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
+ (NSString *)hexStringWithData:(NSData *)data;
- (NSString *)AES256EncryptWithKey:(NSString *)key;
@end

@interface NSString (Size)

- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size;

@end


@interface NSString (Emoji)

- (BOOL)containEmoji;//新判断是否含有表情符号的方法
- (BOOL)isIncludingEmoji:(BOOL)showAlertView;

- (instancetype)removedEmojiString;
- (instancetype)removedPointString;

//判断是否为整形：

- (BOOL)isPureInt;

@end


@interface NSString (UIColor)

- (UIColor *)colorWithHexString;

@end

@interface NSString (DWJQCommon)

- (BOOL)isNotEmpty;
- (NSString *)PointTwo;
//收益>=0加正号,收益<0加负号
- (NSString *)pointTwoSymbol;
//收益>0加正号,收益为0不加符号，收益<0加负号
- (NSString *)pointTwoSymbolJudgeZero;
- (NSString *)PointFour;
- (NSString *)AddPercent;
- (NSString *)MD5;
- (NSString *)getPrivateStr;
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
- (NSInteger)convertToByte;
/**
 *  把string格式的数字统一成最大上限不超过“99+”的string
 *
 *  @return 转化后的string
 */
- (NSString *)transformLargeNumberStringToDefaultMaxNumberStr;
/**
 *  把string格式的数字统一成最大上限不超过“maxNumber+”的string
 *
 *  @param maxNumber 最大上限数字
 *
 *  @return 转化后的string
 */
- (NSString *)transformLargeNumberStringToMaxNumberStr:(NSInteger)maxNumber;
//判断一个串是否是一个合法的URL
- (BOOL)isValidUrl;
@end

