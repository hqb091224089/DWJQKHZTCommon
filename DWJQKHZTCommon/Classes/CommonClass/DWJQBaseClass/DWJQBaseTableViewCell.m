//
//  DWJQBaseTableViewCell.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/21.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseTableViewCell.h"

// TableViewCell分割线默认的左间距
#define kDWJQBaseTableViewCell_DefaultSeparatorLeft       15.0f
#define kDWJQBaseTableViewCell_DefaultSeparatorRight      0.0f

#define kDWJQBaseTableViewCell_ArrowImageViewOffsetX      20.0f

#define kDWJQBaseTableViewCell_ArrowImageViewMarginX      5.0f

#define kDWJQBaseTableViewCell_ContentViewOffsetX         10.0f
#define kDWJQBaseTableViewCell_LineImageViewHeight        0.5f

#define kDWJQBaseTableViewCell_ContentViewCornerRadius    8.0f
#define kDWJQBaseTableViewCell_ContentViewBorderWidth     0.5f
#define kDWJQBaseTableViewCell_ContentViewBorderColor     DWJQCOLOR_CLEAR

@interface DWJQBaseTableViewCell ()
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, assign) CGFloat lineImageViewHeight;

// DWJQTableViewCellStyleGrouped时圆角的半径
@property (nonatomic, assign) CGFloat contentViewCornerRadius;
@property (nonatomic, assign) CGFloat contentViewBorderWidth;
@property (nonatomic, strong) UIColor *contentViewBorderColor;
@end

@implementation DWJQBaseTableViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    [self layoutIfNeeded];
}

- (void)setup
{
    // 1.
    self.backgroundColor = DWJQCOLOR_CLEAR;
    self.contentView.backgroundColor = DWJQCOLOR_CLEAR;
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleBottomMargin;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
    self.contentView.clipsToBounds = YES;
    // 2.
    if (self.lineImageView == nil) {
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.lineImageView.backgroundColor = _separatorColor?_separatorColor :DWJQCOLOR_MobileHall_C4;
        [self.contentView addSubview:self.lineImageView];
    }
    
    if (self.backgourndImageView == nil) {
        self.backgourndImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.backgourndImageView.backgroundColor = DWJQCOLOR_WHITE;
        [self.contentView insertSubview:self.backgourndImageView atIndex:0];
    }
    
    if (self.arrowImageView == nil) {
        NSString *fn = @"common_arrow_gray";
        UIImage *img = DWJQCreateImage(fn);
        self.arrowImageView = [[UIImageView alloc] initWithImage:img];
        self.arrowImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [self.contentView addSubview:self.arrowImageView];
    }
    
    // 3.
    self.contentViewOffsetX = kDWJQBaseTableViewCell_ContentViewOffsetX;
    self.separatorLeft = kDWJQBaseTableViewCell_DefaultSeparatorLeft;
    self.separatorRight = kDWJQBaseTableViewCell_DefaultSeparatorRight;
    self.lineImageViewHeight = kDWJQBaseTableViewCell_LineImageViewHeight;
    self.tableViewCellStyle = DWJQTableViewCellStylePlain;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGRect frame = self.bounds;
    if (self.tableViewCellStyle == DWJQTableViewCellStyleGrouped) {
        self.contentView.frame = CGRectInset(frame, self.contentViewOffsetX, 0);
        self.lineImageView.frame = CGRectMake(self.contentViewCornerRadius, self.contentView.height - self.lineImageViewHeight, self.contentView.width - self.contentViewCornerRadius * 2, self.lineImageViewHeight);
    } else {
        self.lineImageView.frame = CGRectMake(self.separatorLeft, self.contentView.height - self.lineImageViewHeight, self.contentView.width - self.separatorLeft - self.separatorRight, self.lineImageViewHeight);
    }
    self.contentView.clipsToBounds = YES;
    [self.contentView bringSubviewToFront:self.lineImageView];
    self.backgourndImageView.frame = self.contentView.bounds;
    self.arrowImageView.hidden = !self.showArrow;
    self.arrowImageView.frame = CGRectMake(self.contentView.width - kDWJQBaseTableViewCell_ArrowImageViewOffsetX - self.arrowImageView.width / 2, (self.contentView.height - self.arrowImageView.height) / 2, self.arrowImageView.width, self.arrowImageView.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setSeparatorHidden:(BOOL)separatorHidden
{
    _separatorHidden = separatorHidden;
    self.lineImageView.hidden = separatorHidden;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    //self.backgourndImageView.backgroundColor = highlighted ? DWJQCOLOR_C7 : DWJQCOLOR_C2;
}


- (void)setTableViewCellStyle:(DWJQTableViewCellStyle)tableViewCellStyle
{
    _tableViewCellStyle = tableViewCellStyle;
    if (self.tableViewCellStyle == DWJQTableViewCellStyleGrouped) {
        self.contentViewCornerRadius = kDWJQBaseTableViewCell_ContentViewCornerRadius;
        self.contentViewBorderWidth = kDWJQBaseTableViewCell_ContentViewBorderWidth;
        self.contentViewBorderColor = kDWJQBaseTableViewCell_ContentViewBorderColor;
    } else {
        self.contentViewCornerRadius = 0;
        self.contentViewBorderColor = DWJQCOLOR_CLEAR;
        self.contentViewBorderWidth = 0;
    }
    
    self.contentView.layer.cornerRadius = self.contentViewCornerRadius;
    self.contentView.layer.borderColor = self.contentViewBorderColor.CGColor;
    self.contentView.layer.borderWidth = self.contentViewBorderWidth;
}

+ (CGFloat)arrowViewWidth
{
    CGFloat w = kDWJQBaseTableViewCell_ArrowImageViewOffsetX;
    
    NSString *fn = @"common_arrow_gray";
    UIImage *img = DWJQCreateImage(fn);
    w += img.size.width;
    
    w += kDWJQBaseTableViewCell_ArrowImageViewMarginX;
    return w;
}

+ (CGFloat)cellHeightWithData:(id)cellData
{
    return 0;
}

+ (CGFloat)defaultContentViewOffsetX
{
    return kDWJQBaseTableViewCell_ContentViewOffsetX;
}

- (CGFloat)cellHeight
{
    return 0;
}

//  to ensure the setting of radius of corners.
- (void) customCornerRadiusWithView:(UITableViewCell*)tableViewCell topLeftCorner:(CGFloat)radius_tl topRightC:(CGFloat)radius_tr bottomLeftC:(CGFloat)radius_bl bottomRightC:(CGFloat)radius_br {
    
    UIImage *mask = MTDContextCreateRoundedMask( tableViewCell.contentView.bounds, radius_tl, radius_tr, radius_bl, radius_br );
    // Create a new layer that will work as a mask
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = tableViewCell.contentView.frame;
    // Put the mask image as content of the layer
    layerMask.contents = (id)mask.CGImage;
    // set the mask layer as mask of the view layer
    tableViewCell.layer.mask = layerMask;
}
- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    self.lineImageView.backgroundColor = separatorColor;
}
- (void)setSeparatorHeight:(CGFloat)separatorHeight
{
    _separatorHeight = separatorHeight;
    self.lineImageViewHeight = separatorHeight;
}
-(UITableView *)tableView{
    if ([self.superview isKindOfClass:[UITableView class]]) {
        return (UITableView *)self.superview;
    }else if ([self.superview.superview isKindOfClass:[UITableView class]]) {
        return (UITableView *)self.superview.superview;
    }else if ([self.superview isKindOfClass:[UITableView class]]) {
        return (UITableView *)self.superview;
    }
    else{
        return nil;
    }
}
@end
