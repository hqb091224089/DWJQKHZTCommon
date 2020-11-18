//
//  DWJQCommontTipBottomView.h
//  DWJQ
//
//  Created by 东吴秀财开发 on 2017/2/10.
//  Copyright © 2017年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWJQCommontTipBottomView : UIView
+ (CGFloat)viewHeight;
@end
@interface DWJQCommontTipBottomViewWithTowButton : DWJQCommontTipBottomView
@property (nonatomic,strong) UIButton *firstBtn;
@property (nonatomic,strong) UIButton *secondBtn;

+ (instancetype)initBottomView;
@end
