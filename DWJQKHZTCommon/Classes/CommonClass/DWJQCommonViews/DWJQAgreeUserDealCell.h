//
//  DWJQAgreeUserDealCell.h
//  DWJQ
//
//  Created by User01 on 16/12/26.
//  Copyright © 2016年 logictech. All rights reserved.
//
/**
 同意用户使用协议CELL
 */
#import "DWJQBaseTableViewCell.h"
//#import "UILabel+DWJQAttributeTapAction.h"

typedef void(^DidClickActionTextBlock) (void);

@interface DWJQAgreeUserDealCell : DWJQBaseTableViewCell
{
    float _cellHeight;
}
@property(nonatomic,strong)UILabel *dealTextLabel;

@property(nonatomic,strong)NSString *tipText;
@property(nonatomic,strong)NSString *dealName;
@property(nonatomic,strong)UIColor *tipTextColor;
@property(nonatomic,strong)UIColor *dealNameColor;
@property(nonatomic,copy)DidClickActionTextBlock clickActionTextBlock;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTipText:(NSString *)TipText andDealName:(NSString *)dealName andTipTextColor:(UIColor *)tipTextColor andDealNameColor:(UIColor *)dealNameColor;
-(void)resetTipText:(NSString *)tipText andDealName:(NSString *)dealName andTextAlignment:(NSTextAlignment)alignment;
@end
