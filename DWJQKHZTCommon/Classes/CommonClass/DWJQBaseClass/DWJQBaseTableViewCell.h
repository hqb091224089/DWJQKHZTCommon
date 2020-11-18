//
//  DWJQBaseTableViewCell.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/21.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _DWJQBaseTableViewCellStyle
{
    DWJQTableViewCellStylePlain   = 0,
    DWJQTableViewCellStyleGrouped = 1
} DWJQTableViewCellStyle;
@interface DWJQBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger cellType;

@property (nonatomic, strong) UIImageView *backgourndImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, assign, getter = isSeparatorHidden) BOOL separatorHidden;
@property (nonatomic, assign) BOOL showArrow;

@property (nonatomic, assign) NSInteger separatorLeft;
@property (nonatomic, assign) NSInteger separatorRight;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CGFloat separatorHeight;


@property (nonatomic, assign) DWJQTableViewCellStyle tableViewCellStyle;

@property (nonatomic, assign) CGFloat contentViewOffsetX;

//计算cell高度的方法，具体实现由需要的子类实现，默认返回为0.f
+ (CGFloat)cellHeightWithData:(id)cellData;
+ (CGFloat)defaultContentViewOffsetX;

// arrow所需要的宽度（包含间距）
+ (CGFloat)arrowViewWidth;

- (CGFloat)cellHeight;

/**
 *  为UITableViewCell四个角设置指定圆角, 如左上，左下，右上，右下
 *
 *  @param tableviewCell    tableviewCell
 *  @param radius_tl        topLeftCorner 左上角弧度值
 *  @param radius_tr        topRightC     右上角
 *  @param radius_bl        bottomLeftC   左下角
 *  @param radius_br        bottomRightC  右下角
 */
- (void) customCornerRadiusWithView:(UITableViewCell*)tableViewCell topLeftCorner:(CGFloat)radius_tl topRightC:(CGFloat)radius_tr bottomLeftC:(CGFloat)radius_bl bottomRightC:(CGFloat)radius_br;

-(UITableView *)tableView;

- (void)setup;

@end
