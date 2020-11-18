//
//  NSMutableAttributedString+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (DWJQ)

+ (CGSize) getOffsetHeight:(NSMutableAttributedString *)attributedString maxSize:(CGSize)maxSize realSize:(CGSize)realSize;


@end
