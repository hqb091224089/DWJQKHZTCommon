//
//  TTTAttributedLabel+DWJQ.m
//  DWJQ
//
//  Created by 东吴秀财开发 on 16/9/21.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "TTTAttributedLabel+DWJQ.h"

@implementation TTTAttributedLabel (DWJQ)
+(TTTAttributedLabel *)getMutableParagraphStyle:(TTTAttributedLabel *)label
{
    NSMutableAttributedString *arrtibutestr =  [label.attributedText mutableCopy];
    
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
        
        
        BOOL isIncludeM = [lineString isIncludingEmoji:NO];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        if (isIncludeM) {
            paragraphStyle.lineSpacing = 0;
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            
        }else{
            paragraphStyle.lineSpacing = kDWJQLabelSeparatorWithoutEmoji;
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            
        }
        
        [arrtibutestr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
    label.attributedText = arrtibutestr;
    
    CFRelease(myFont);
    CFRelease(frameSetter);
    CFRelease(path);
    CFRelease(frame);
    
    return label;
    
}
//重写该方法，使得放手时可以出发点击事件
- (void)touchesCancelled:(NSSet *)touches
               withEvent:(UIEvent *)event
{
    if ([self valueForKey:@"activeLink"]) {
        [self touchesEnded:touches withEvent:event];
    } else {
        [super touchesCancelled:touches withEvent:event];
    }
}
@end
