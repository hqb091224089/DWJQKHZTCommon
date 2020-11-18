//
//  TTTAttributedLabel+DWJQ.h
//  DWJQ
//
//  Created by 东吴秀财开发 on 16/9/21.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "TTTAttributedLabel.h"

@interface TTTAttributedLabel (DWJQ)
//修改label间距以自适应有无表情
+(TTTAttributedLabel *)getMutableParagraphStyle:(TTTAttributedLabel *)label;

@end
