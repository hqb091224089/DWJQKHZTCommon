//
//  UIScrollView+DWJQ.m
//  DWJQ
//
//  Created by 东吴秀财开发 on 16/7/8.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "UIScrollView+DWJQ.h"

@implementation UIScrollView (DWJQ)
-(void)scrollToButtom{
    [self setContentOffset:CGPointMake(0, self.contentSize.height-self.height) animated:YES];
}
@end
