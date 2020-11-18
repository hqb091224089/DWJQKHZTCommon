//
//  UIColor+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/6/28.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DWJQ)
/**
 *  颜色转换 IOS中十六进制的颜色转换为UIColor
 *
 *  @param color 16进制字符串
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithHexString:(NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert andAlpha:(NSString *)alpha;
@end
