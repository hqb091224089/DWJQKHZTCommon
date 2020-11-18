//
//  UILabel+DWJQ.h
//  DWJQ
//
//  Created by 东吴秀财开发 on 16/9/21.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DWJQ)
//折行label获取每行内容
+ (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label;
@end
