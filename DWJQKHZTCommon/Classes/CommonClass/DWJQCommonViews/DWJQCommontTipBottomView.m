//
//  DWJQCommontTipBottomView.m
//  DWJQ
//
//  Created by 东吴秀财开发 on 2017/2/10.
//  Copyright © 2017年 logictech. All rights reserved.
//

#import "DWJQCommontTipBottomView.h"
static const CGFloat kDWJQCommonContainerViewToLeftMargin = 20.f;

@implementation DWJQCommontTipBottomView
+ (CGFloat)viewHeight{
    return 0.f;
}
@end
@implementation DWJQCommontTipBottomViewWithTowButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+ (instancetype)initBottomView
{
    CGFloat viewWidth = kDWJQScreenWidth - 2 * kDWJQCommonContainerViewToLeftMargin;

    DWJQCommontTipBottomViewWithTowButton *view = [[DWJQCommontTipBottomViewWithTowButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth, [DWJQCommontTipBottomViewWithTowButton viewHeight])];
    view.firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, viewWidth/2, [DWJQCommontTipBottomViewWithTowButton viewHeight])];
    view.secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2, 0, viewWidth/2, [DWJQCommontTipBottomViewWithTowButton viewHeight])];
    UIView * horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 1)];
    horizontalLine.backgroundColor = DWJQCOLOR_C15;
    UIView * verticalLine = [[UIView alloc]initWithFrame:CGRectMake(viewWidth/2, 0, 1, [DWJQCommontTipBottomViewWithTowButton viewHeight])];
    verticalLine.backgroundColor = DWJQCOLOR_C15;
    [view addSubview:view.firstBtn];
    [view addSubview:view.secondBtn];
    [view addSubview:horizontalLine];
    [view addSubview:verticalLine];
    return view;
}
+ (CGFloat)viewHeight{
    return 56.f;
}
@end
