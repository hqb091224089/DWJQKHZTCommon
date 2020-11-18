//
//  DWJQCommonTipView.m
//  DWJQ
//
//  Created by luoxingyu on 2017/1/17.
//  Copyright © 2017年 logictech. All rights reserved.
//

#import "DWJQCommonTipView.h"
static const CGFloat kDWJQCommonContainerViewToLeftMargin = 20.f;
static const CGFloat kDWJQCommonContainerViewToTopMinMargin = 40.f;

static const CGFloat kDWJQCommonContainerViewTitleTopMargin = 30.f;
static const CGFloat kDWJQCommonContainerViewTitleLeftMargin = 28.f;

static const CGFloat kDWJQCommonContainerViewImageToTopMargin = 0.f;
static const CGFloat kDWJQCommonContainerViewImageToLeftMargin = 0.f;

static const CGFloat kDWJQCommonContainerViewContentToImageTopMargin = 16.f;
static const CGFloat kDWJQCommonContainerViewContentToTitleTopMargin = 30.f;

static const CGFloat kDWJQCommonContainerViewContentToLeftMargin = 28.f;

static const CGFloat kDWJQCommonContainerViewButtonViewToTopMargin = 30.f;

static const CGFloat kDWJQCommonContainerViewCloseButtonWidth = 35.f;

//14

@interface DWJQCommonTipView()
@property (nonatomic , weak) UIView *containerView;

@property (nonatomic , weak) UIImageView *tipImageView;
@property (nonatomic , weak) UILabel *tipContent;

@property (nonatomic , assign) CGFloat viewHeight;

@end

@implementation DWJQCommonTipView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, kDWJQScreenWidth, kDWJQScreenHeight);
    }
    return self;
}
- (instancetype )commonTipViewReloadDataWithTitle:(NSString *)titleStr image:(UIImage *)tipImage content:(NSAttributedString *)contentStr bottomButtonStyle:(DWJQCommonTipViewBottomButtonStyle)bottomButtonStyle closeButtonStyle:(DWJQCommonTipViewCloseButtonStyle)closeButtonStyle delegate:(id<DWJQCommonTipViewDelegate>)delegate datesource:(id<DWJQCommonTipViewDatesource>)datesource
{
    self.tipViewDelegate = delegate;
    self.tipViewDatesource = datesource;
    
    UIView *coverView = [[UIView alloc]init];
    coverView.frame = CGRectMake(0, 0, kDWJQScreenWidth, kDWJQScreenHeight);
    coverView.backgroundColor = DWJQCOLOR_C27;
    coverView.alpha = 0.65;
    [self addSubview:coverView];
    self.coverView = coverView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBackgroudView)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [coverView addGestureRecognizer:tap];
    
    self.isCoverViewClickEnable = YES;

    
    
    UIView *containerView = [[UIView alloc]init];
    containerView.backgroundColor = DWJQCOLOR_WHITE;
    containerView.layer.cornerRadius = 4.f;
    containerView.layer.masksToBounds = YES;
    [self addSubview:containerView];
    self.containerView = containerView;
    
    CGFloat viewWidth = kDWJQScreenWidth - 2 * kDWJQCommonContainerViewToLeftMargin;
    
    CGFloat viewHeight = 0.f;
    if (titleStr.length) {
        //标题的颜色和字号
        UIFont *titleFont = [UIFont systemFontOfSize:18];
        UIColor *titleColor = DWJQCOLOR_C25;

        CGFloat labelWidth = viewWidth - 2 * kDWJQCommonContainerViewTitleLeftMargin;
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = titleFont;
        titleLabel.textColor = titleColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0.f;
        titleLabel.text = [titleStr copy];
        CGSize  titleSize = [titleStr sizeWithFont:titleFont maxSize:CGSizeMake(labelWidth, MAXFLOAT)];
        self.titleLabel = titleLabel;
        [containerView addSubview:titleLabel];
        titleLabel.frame = CGRectMake(kDWJQCommonContainerViewTitleLeftMargin, kDWJQCommonContainerViewTitleTopMargin, labelWidth, titleSize.height);
        viewHeight = kDWJQCommonContainerViewTitleTopMargin + titleSize.height;
    }
    
    if (tipImage) {
        //
        CGFloat ratio = tipImage.size.width / tipImage.size.height;
        CGFloat tipImageWidth = viewWidth - 2 * kDWJQCommonContainerViewImageToLeftMargin;
        CGFloat tipImageHeight = tipImageWidth / ratio;
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:tipImage];
        [containerView addSubview:imageView];
        imageView.frame = CGRectMake(kDWJQCommonContainerViewImageToLeftMargin,viewHeight + kDWJQCommonContainerViewImageToTopMargin,tipImageWidth, tipImageHeight);
        viewHeight = viewHeight + kDWJQCommonContainerViewImageToTopMargin + tipImageHeight;
    }
    //中间的容器view，在整个控件的长度大于整个屏幕的高度时变成可以滑动
    UIScrollView *middleScrollView = [[UIScrollView alloc]init];
    [containerView addSubview:middleScrollView];
    if (contentStr.length) {
        UILabel *tipContent = [[UILabel alloc]init];
        tipContent.numberOfLines = 0;
        tipContent.attributedText = [contentStr copy];
        CGFloat labelWidth = viewWidth - 2 * kDWJQCommonContainerViewContentToLeftMargin;
        tipContent.width = labelWidth;
        [tipContent sizeToFit];
        tipContent.width = labelWidth;
        [middleScrollView addSubview:tipContent];
        self.tipContent = tipContent;
        if (tipImage) {
            middleScrollView.frame = CGRectMake(kDWJQCommonContainerViewContentToLeftMargin, viewHeight + kDWJQCommonContainerViewContentToImageTopMargin, tipContent.width, tipContent.height);
            middleScrollView.contentSize = CGSizeMake(tipContent.width, tipContent.height);
            tipContent.frame = CGRectMake(0, 0, tipContent.width, tipContent.height);
            viewHeight = viewHeight + tipContent.height + kDWJQCommonContainerViewContentToImageTopMargin;
        }else{
            middleScrollView.frame = CGRectMake(kDWJQCommonContainerViewContentToLeftMargin, viewHeight + kDWJQCommonContainerViewContentToTitleTopMargin, tipContent.width, tipContent.height);
            middleScrollView.contentSize = CGSizeMake(tipContent.width, tipContent.height);
            tipContent.frame = CGRectMake(0, 0, tipContent.width, tipContent.height);
            viewHeight = viewHeight + tipContent.height + kDWJQCommonContainerViewContentToTitleTopMargin;
        }
    }
    CGFloat bottomViewHeight = 56.f;
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:bottomView];
    switch (bottomButtonStyle) {
        case DWJQCommonTipViewBottomButtonStyleNone:
        {
            bottomViewHeight = 0;
            break;
        }
        case DWJQCommonTipViewBottomButtonStyleCustom:
        {
            if (self.tipViewDatesource) {
                UIView *customView = [self.tipViewDatesource commonTipViewViewForBottom:self];
                bottomViewHeight = [self.tipViewDatesource commonTipViewViewHeightForBottom:self];
                customView.frame =  CGRectMake(0,0,viewWidth,bottomViewHeight);
                [bottomView addSubview:customView];
            }
            break;
        }
        case DWJQCommonTipViewBottomButtonStyleRedSureBtn:
        {
            UIButton *bottomButton  = [[UIButton alloc] initWithFrame:CGRectMake(0,0,viewWidth,bottomViewHeight)];
            bottomButton.backgroundColor = DWJQCOLOR_C22;
            [bottomButton setTitleColor:DWJQCOLOR_WHITE forState:UIControlStateNormal];
            [bottomButton setTitleColor:DWJQCOLOR_C21 forState:UIControlStateDisabled];
            bottomButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
            [bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:bottomButton];
            self.bottomButton = bottomButton;
            break;

        }
        case DWJQCommonTipViewBottomButtonStyleBlueSureBtn:
        {
            UIButton *bottomButton  = [[UIButton alloc] initWithFrame:CGRectMake(0,0,viewWidth,bottomViewHeight)];
            bottomButton.backgroundColor = DWJQCOLOR_C32;
            [bottomButton setTitleColor:DWJQCOLOR_WHITE forState:UIControlStateNormal];
            [bottomButton setTitleColor:DWJQCOLOR_C21 forState:UIControlStateDisabled];
            bottomButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
            [bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:bottomButton];
            self.bottomButton = bottomButton;
            break;
        }
    }
    bottomView.frame = CGRectMake(0,viewHeight + kDWJQCommonContainerViewButtonViewToTopMargin,viewWidth, bottomViewHeight);

    viewHeight = viewHeight + bottomViewHeight + kDWJQCommonContainerViewButtonViewToTopMargin;
    
    CGFloat deltaHeight = (viewHeight + 2 * kDWJQCommonContainerViewToTopMinMargin) - kDWJQScreenHeight;
    if (deltaHeight > 0) {
        middleScrollView.height = self.tipContent.height - deltaHeight;
        bottomView.top = middleScrollView.bottom + kDWJQCommonContainerViewButtonViewToTopMargin;
        self.viewHeight = kDWJQScreenHeight - 2 * kDWJQCommonContainerViewToTopMinMargin;
    }else{
        self.viewHeight = viewHeight;
    }
    containerView.frame = CGRectMake(kDWJQCommonContainerViewToLeftMargin, (kDWJQScreenHeight -  self.viewHeight) / 2, kDWJQScreenWidth - 2 * kDWJQCommonContainerViewToLeftMargin, self.viewHeight);
    
    
    switch (closeButtonStyle) {
        case DWJQCommonTipViewCloseButtonStyleNone:
            
        break;
        case DWJQCommonTipViewCloseButtonStyleInside:
        {
            UIButton *closeBtn  = [[UIButton alloc] initWithFrame:CGRectMake(self.containerView.right - kDWJQCommonContainerViewCloseButtonWidth, self.containerView.top, kDWJQCommonContainerViewCloseButtonWidth, kDWJQCommonContainerViewCloseButtonWidth)];
            [closeBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            [closeBtn setImage:[UIImage imageNamed:@"tipCloseImage"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:closeBtn];
            break;
        }
        case DWJQCommonTipViewCloseButtonStyleOutside:
        {
            //关闭按钮
            UIButton *closeBtn = [[UIButton alloc]init];
            [closeBtn setImage:[UIImage imageNamed:@"DWJQ_ZhiCai_Announcement_cancel"] forState:UIControlStateNormal];
            [closeBtn setSize:CGSizeMake(50, 50)];
            [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            [closeBtn setCenter:CGPointMake(self.containerView.right-5, self.containerView.top)];
            [closeBtn addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:closeBtn];
            break;
        }
    }
    return self;
}
- (void)setButtonTitle:(NSString *)buttonTitle
{
    _buttonTitle = buttonTitle;
    if (self.bottomButton) {
        [self.bottomButton setTitle:buttonTitle forState:UIControlStateNormal];
        [self.bottomButton setTitle:buttonTitle forState:UIControlStateDisabled];
    }
}
- (void)showTipView
{
    [DWJQAppKeyWindow addSubview:self];
}
- (void)dismissTipView
{
    [self removeFromSuperview];
}
- (void)closeSelf
{
    if ([self.tipViewDelegate respondsToSelector:@selector(commonTipViewDidClickCloseButton:)]) {
        [self.tipViewDelegate commonTipViewDidClickCloseButton:self];
    }else{
        [self dismissTipView];
    }
}
- (void)touchBackgroudView
{
    if ([self.tipViewDelegate respondsToSelector:@selector(commonTipViewDidClickBackgroundView:)]) {
        [self.tipViewDelegate commonTipViewDidClickBackgroundView:self];
    }else{
        if (self.isCoverViewClickEnable) {
            [self dismissTipView];
        }
    }
}
- (void)bottomButtonClick:(UIButton *)sender
{
    if ([self.tipViewDelegate respondsToSelector:@selector(commonTipView:didClickBottomButton:)]) {
        [self.tipViewDelegate commonTipView:self didClickBottomButton:sender];
    }
    else
    {
        [self dismissTipView];
    }
}
+(NSMutableAttributedString *)getDotStringWithStrArray:(NSArray *)strArray fontSize:(UIFont *)font
{
    if (strArray.count == 0) {
        return nil;
    }
    NSAttributedString *attachString = [[NSAttributedString  alloc]initWithString:@"•  "];
    NSMutableAttributedString *paragraAttributeStr = [[NSMutableAttributedString alloc]init];
    for (NSString *str in strArray) {
        if (str.length > 0) {
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",str]];
            [attr insertAttributedString:attachString atIndex:0];
            [paragraAttributeStr appendAttributedString:attr];
        }
    }
    
    [paragraAttributeStr addAttribute:NSFontAttributeName
     
                                value:font
     
                                range:NSMakeRange(0, paragraAttributeStr.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    CGSize headSize = [attachString.string sizeWithFont:font];
    paragraphStyle.headIndent = headSize.width;
    paragraphStyle.lineSpacing = 5;
    [paragraAttributeStr addAttribute:NSParagraphStyleAttributeName
     
                                value:paragraphStyle
     
                                range:NSMakeRange(0,paragraAttributeStr.length)];
    return paragraAttributeStr;
}
@end
