//
//  DWJQCommonTipView.h
//  DWJQ
//
//  Created by luoxingyu on 2017/1/17.
//  Copyright © 2017年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum DWJQCommonTipViewBottomButtonStyle:NSInteger {
    DWJQCommonTipViewBottomButtonStyleNone     = 0,
    DWJQCommonTipViewBottomButtonStyleRedSureBtn  ,
    DWJQCommonTipViewBottomButtonStyleBlueSureBtn ,
    DWJQCommonTipViewBottomButtonStyleCustom
}DWJQCommonTipViewBottomButtonStyle;

typedef enum DWJQCommonTipViewCloseButtonStyle:NSInteger {
    DWJQCommonTipViewCloseButtonStyleNone    = 0,
    DWJQCommonTipViewCloseButtonStyleInside  = 1,
    DWJQCommonTipViewCloseButtonStyleOutside = 2
}DWJQCommonTipViewCloseButtonStyle;

@class DWJQCommonTipView;


@protocol DWJQCommonTipViewDelegate <NSObject>
@optional
- (void)commonTipViewDidClickCloseButton:(DWJQCommonTipView *)view;
- (void)commonTipViewDidClickBackgroundView:(DWJQCommonTipView *)view;
- (void)commonTipView:(DWJQCommonTipView *)view didClickBottomButton:(UIButton *)bottomButton;

@end

@protocol DWJQCommonTipViewDatesource <NSObject>
@required
- (UIView *)commonTipViewViewForBottom:(DWJQCommonTipView *)view;
- (CGFloat)commonTipViewViewHeightForBottom:(DWJQCommonTipView *)view;
@end

@interface DWJQCommonTipView : UIView
@property (nonatomic , weak) id<DWJQCommonTipViewDelegate> tipViewDelegate;
@property (nonatomic , weak) id<DWJQCommonTipViewDatesource> tipViewDatesource;

/**
 弹窗覆盖在屏幕上的背景view
 */
@property (nonatomic , weak) UIView *coverView;
@property (nonatomic , assign) BOOL isCoverViewClickEnable;

/**
 底部按钮的按钮
 */
@property (nonatomic , weak) UIButton *bottomButton;
/**
 标题
 */
@property (nonatomic , weak) UILabel *titleLabel;
/**
 底部按钮的文字，默认没有
 */
@property (nonatomic , strong) NSString *buttonTitle;



- (instancetype )commonTipViewReloadDataWithTitle:(NSString *)titleStr image:(UIImage *)tipImage content:(NSAttributedString *)contentStr bottomButtonStyle:(DWJQCommonTipViewBottomButtonStyle)bottomButtonStyle closeButtonStyle:(DWJQCommonTipViewCloseButtonStyle)closeButtonStyle delegate:(id<DWJQCommonTipViewDelegate>)delegate datesource:(id<DWJQCommonTipViewDatesource>)datesource;
- (void)showTipView;
- (void)dismissTipView;


/**
 根据传入的段落数组返回一个带点的可变字符

 @param strArray 段落数组
 @param font 点的字体大小
 @return 带点的可变字符
 */
+(NSMutableAttributedString *)getDotStringWithStrArray:(NSArray *)strArray fontSize:(UIFont *)font;

@end
