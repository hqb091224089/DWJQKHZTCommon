//
//  NSMutableAttributedString+DWJQ.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSMutableAttributedString+DWJQ.h"
#import "TTTAttributedLabel.h"

@implementation NSMutableAttributedString (DWJQ)

+ (CGSize) getOffsetHeight:(NSMutableAttributedString *)attributedString maxSize:(CGSize)maxSize realSize:(CGSize)realSize
{
    //1.获取原TTTAttrbutedLable属性
    NSRange range = NSMakeRange(0, attributedString.length);
    NSDictionary * dd = [attributedString attributesAtIndex:0 effectiveRange:&range];
    //2.设置Emoji表情符
    NSMutableAttributedString * esString = [[NSMutableAttributedString alloc] initWithString:@"\U0001F604 \U0001F610" attributes:dd];
    //3.计算单行Emoji表情的高度
    CGFloat esHeight = [TTTAttributedLabel sizeThatFitsAttributedString:esString withConstraints:maxSize limitedToNumberOfLines:0].height;
    
    //4.计算单行文字的高度
    NSAttributedString * newAttStr = [[NSAttributedString alloc] initWithString:@"单行文字高度" attributes:dd];
    [esString setAttributedString:newAttStr];
    CGFloat wsHeight = [TTTAttributedLabel sizeThatFitsAttributedString:esString withConstraints:maxSize limitedToNumberOfLines:0].height;
    
    //5.单行Emoji高度与单行文字高度差值
    CGFloat maxHeight = esHeight;
    CGFloat offsetHeight = esHeight - wsHeight;
    if (wsHeight > esHeight) {
        offsetHeight = wsHeight - esHeight;
        maxHeight = wsHeight;
    }
    
    //6.补全文字高度
    CGSize lastSize = realSize;
    if ( fabs(realSize.height - maxHeight) < 1 ) {
        ;
    } else {
        lastSize.height += offsetHeight;
    }
    return lastSize;
}

@end
