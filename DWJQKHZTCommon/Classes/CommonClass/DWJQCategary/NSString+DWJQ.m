//
//  NSString+DWJQ.m
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSString+DWJQ.h"
#import "GTMBase64.h"

@implementation NSString (DWJQ)

- (NSString*)urlEncodedString
{
    NSString *encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return encodedString;
}
- (NSString *)urlEncoded
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
- (NSString *)md5EncodedString
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}
- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)hexStringWithData:(NSData *)data {
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    if (!dataBuffer) {
        return [NSString string];
    }
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", (unsigned char)dataBuffer[i]];
    }
    return [NSString stringWithString:hexString];
}
- (NSString *)AES256EncryptWithKey:(NSString *)key
{
    return [NSString hexStringWithData:[[self dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key]];
}
@end


@implementation NSString (Size)

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size
{
    CGSize realSize = CGSizeZero;
    CGRect textRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    realSize = textRect.size;
    realSize.width = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
}

@end


@implementation NSString (Emoji)

- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

- (BOOL)containEmoji
{
    NSUInteger len = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (len < 3) {// 大于2个字符需要验证Emoji(有些Emoji仅三个字符)
        return NO;
    }// 仅考虑字节长度为3的字符,大于此范围的全部做Emoji处理
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];Byte *bts = (Byte *)[data bytes];
    Byte bt;
    short v;
    for (NSUInteger i = 0; i < len; i++) {
        bt = bts[i];
        
        if ((bt | 0x7F) == 0x7F) {// 0xxxxxxxASIIC编码
            continue;
        }
        if ((bt | 0x1F) == 0xDF) {// 110xxxxx两个字节的字符
            i += 1;
            continue;
        }
        if ((bt | 0x0F) == 0xEF) {// 1110xxxx三个字节的字符(重点过滤项目)
            // 计算Unicode下标
            v = bt & 0x0F;
            v = v << 6;
            v |= bts[i + 1] & 0x3F;
            v = v << 6;
            v |= bts[i + 2] & 0x3F;
            
            // NSLog(@"%02X%02X", (Byte)(v >> 8), (Byte)(v & 0xFF));
            if ([self emojiInSoftBankUnicode:v] || [self emojiInUnicode:v]) {
                return YES;
            }
            
            i += 2;
            continue;
        }
        if ((bt | 0x3F) == 0xBF) {// 10xxxxxx10开头,为数据字节,直接过滤
            continue;
        }
        
        return YES; // 不是以上情况的字符全部超过三个字节,做Emoji处理
    }return NO;
}
/**
 * 一种非官方的, 采用私有Unicode 区域
 * e0 - e501 - 59
 */
- (BOOL) emojiInSoftBankUnicode:(short)code
{
    return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}
//根据从Unicode官网找到的资料，匹配三字节Unicode
- (BOOL) emojiInUnicode:(short)code
{
    if (code == 0x0023
        || code == 0x002A
        || (code >= 0x0030 && code <= 0x0039)
        || code == 0x00A9
        || code == 0x00AE
        || code == 0x203C
        || code == 0x2049
        || code == 0x2122
        || code == 0x2139
        || (code >= 0x2194 && code <= 0x2199)
        || code == 0x21A9 || code == 0x21AA
        || code == 0x231A || code == 0x231B
        || code == 0x2328
        || code == 0x23CF
        || (code >= 0x23E9 && code <= 0x23F3)
        || (code >= 0x23F8 && code <= 0x23FA)
        || code == 0x24C2
        || code == 0x25AA || code == 0x25AB
        || code == 0x25B6
        || code == 0x25C0
        || (code >= 0x25FB && code <= 0x25FE)
        || (code >= 0x2600 && code <= 0x2604)
        || code == 0x260E
        || code == 0x2611
        || code == 0x2614 || code == 0x2615
        || code == 0x2618
        || code == 0x261D
        || code == 0x2620
        || code == 0x2622 || code == 0x2623
        || code == 0x2626
        || code == 0x262A
        || code == 0x262E || code == 0x262F
        || (code >= 0x2638 && code <= 0x263A)
        || (code >= 0x2648 && code <= 0x2653)
        || code == 0x2660
        || code == 0x2663
        || code == 0x2665 || code == 0x2666
        || code == 0x2668
        || code == 0x267B
        || code == 0x267F
        || (code >= 0x2692 && code <= 0x2694)
        || code == 0x2696 || code == 0x2697
        || code == 0x2699
        || code == 0x269B || code == 0x269C
        || code == 0x26A0 || code == 0x26A1
        || code == 0x26AA || code == 0x26AB
        || code == 0x26B0 || code == 0x26B1
        || code == 0x26BD || code == 0x26BE
        || code == 0x26C4 || code == 0x26C5
        || code == 0x26C8
        || code == 0x26CE
        || code == 0x26CF
        || code == 0x26D1
        || code == 0x26D3 || code == 0x26D4
        || code == 0x26E9 || code == 0x26EA
        || (code >= 0x26F0 && code <= 0x26F5)
        || (code >= 0x26F7 && code <= 0x26FA)
        || code == 0x26FD
        || code == 0x2702
        || code == 0x2705
        || (code >= 0x2708 && code <= 0x270D)
        || code == 0x270F
        || code == 0x2712
        || code == 0x2714
        || code == 0x2716
        || code == 0x271D
        || code == 0x2721
        || code == 0x2728
        || code == 0x2733 || code == 0x2734
        || code == 0x2744
        || code == 0x2747
        || code == 0x274C
        || code == 0x274E
        || (code >= 0x2753 && code <= 0x2755)
        || code == 0x2757
        || code == 0x2763 || code == 0x2764
        || (code >= 0x2795 && code <= 0x2797)
        || code == 0x27A1
        || code == 0x27B0
        || code == 0x27BF
        || code == 0x2934 || code == 0x2935
        || (code >= 0x2B05 && code <= 0x2B07)
        || code == 0x2B1B || code == 0x2B1C
        || code == 0x2B50
        || code == 0x2B55
        || code == 0x3030
        || code == 0x303D
        || code == 0x3297
        || code == 0x3299
        // 第二段
        || code == 0x23F0) {
        return YES;
    }
    return NO;
}

- (BOOL)isIncludingEmoji:(BOOL)showAlertView;
{
    BOOL __block result = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    if (result && showAlertView) {
        NSString * title = @"提示";
        NSString * msg = @"暂不支持输入表情等特殊字符";
        [DWJQDialogHelper showWithTitle:title message:msg cancelButtonTitle:@"确定" otherButtonTitles:nil actionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
        }];
    }
    return result;
}

- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}
- (instancetype)removedPointString {
    return self;
//    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
//    
//    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
//                             options:NSStringEnumerationByComposedCharacterSequences
//                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
//                              [buffer appendString:([substring isEqualToString:@"."])? @"": substring];
//                          }];
//    
//    return buffer;
}

//判断是否为整形：
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end

@implementation NSString (UIColor)

- (UIColor *)colorWithHexString
{
    NSString *cString = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end
@implementation NSString (DWJQCommon)
-(NSString *)getPrivateStr
{
    if (self.length <= 7) {
        return [self copy];
    }
    NSMutableString *mutableNormalStr = [NSMutableString stringWithString:self];
    NSRange startStrRange = NSMakeRange(3, self.length - 7);
    NSMutableString *startStr = [NSMutableString string];
    for (int index = 0; index < startStrRange.length; index++) {
        [startStr appendString:@"*"];
    }
    [mutableNormalStr replaceCharactersInRange:startStrRange withString:startStr];
    return [mutableNormalStr copy];
}

- (BOOL)isNotEmpty
{
    if (self.length > 0) {
        return YES;
    }else{
        return NO;
    }
}
- (NSString *)PointTwo{
    
    return [NSString stringWithFormat:@"%.2f",round([[NSDecimalNumber decimalNumberWithString:self] doubleValue]*100)/100];
    
}

//收益>=0加正号,收益<0加负号
- (NSString *)pointTwoSymbol
{
      return [[self doubleValue]>=0?@"+":@"" stringByAppendingString:[self PointTwo]];
}
//收益>0加正号,收益为0不加符号，收益<0加负号
- (NSString *)pointTwoSymbolJudgeZero
{
    return [[self doubleValue]>0?@"+":@"" stringByAppendingString:[self PointTwo]];
    
}

- (NSString *)PointFour{
    
    return [NSString stringWithFormat:@"%.4f",round([[NSDecimalNumber decimalNumberWithString:self] doubleValue]*10000)/10000];
    
}
- (NSString *)AddPercent{
    
    return [self stringByAppendingString:@"%"];
    
}
- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
+ (NSString *)replaceUnicode:(NSString *)unicodeStr

{
    if (unicodeStr) {
        NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
        
        NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
        
        NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
        
        NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
        
        NSLog(@"%@",returnStr);
        
        return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    }
    
    return unicodeStr;
}
- (NSInteger)convertToByte{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}
- (NSString *)transformLargeNumberStringToDefaultMaxNumberStr
{
    NSString *returnStr = @"";
    NSInteger originalNumber = self.integerValue;
    if (originalNumber < 0)
    {
        returnStr = @"0";
    }
    else
    {
        returnStr = [self transformLargeNumberStringToMaxNumberStr:99];
    }
    return returnStr;
}
- (NSString *)transformLargeNumberStringToMaxNumberStr:(NSInteger)maxNumber
{
    
    NSString *returnStr = @"";
    NSInteger originalNumber = self.integerValue;
    if (originalNumber < 0)
    {
        returnStr = @"0";
    }
    else if (originalNumber >= maxNumber)
    {
        returnStr = [NSString stringWithFormat:@"%ld+",(long)maxNumber];
    }else
    {
        returnStr = [NSString stringWithFormat:@"%ld",(long)originalNumber];
    }
    return returnStr;
}
- (BOOL)isValidUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}
@end
