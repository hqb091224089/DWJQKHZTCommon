//
//  DWJQAgreeUserDealCell.m
//  DWJQ
//
//  Created by User01 on 16/12/26.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQAgreeUserDealCell.h"

@implementation DWJQAgreeUserDealCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTipText:(NSString *)TipText andDealName:(NSString *)dealName andTipTextColor:(UIColor *)tipTextColor andDealNameColor:(UIColor *)dealNameColor
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = DWJQCOLOR_C18;
        _tipText = TipText;
        _dealName = dealName;
        _cellHeight = 40*DWJQViewScaleX_375;
 
        float cellWidth = kDWJQScreenWidth;
        if (!tipTextColor) {
            tipTextColor = [UIColor colorWithHexString:@"a8a8a8"];
        }
        if (!dealNameColor) {
            dealNameColor = [UIColor colorWithHexString:@"7889C1"];
        }
        _tipTextColor = tipTextColor;
        _dealNameColor = dealNameColor;
        
        NSString *allText = [NSString stringWithFormat:@"%@%@",_tipText,_dealName];
        
        NSRange tipTextRange = [allText rangeOfString:TipText];
        NSRange dealNameRange = [allText rangeOfString:dealName];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allText];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, allText.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:tipTextColor range:tipTextRange];
        [attributedString addAttribute:NSForegroundColorAttributeName value:dealNameColor range:dealNameRange];
        
         NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributedString addAttribute:NSParagraphStyleAttributeName
                                    value:paragraphStyle
                                    range:NSMakeRange(0,attributedString.length)];
        
        _dealTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0,cellWidth - 40, 40*DWJQViewScaleX_375)];
        _dealTextLabel.numberOfLines = 0;
//        _dealTextLabel.adjustsFontSizeToFitWidth = YES;
        _dealTextLabel.backgroundColor = DWJQCOLOR_C18;
        _dealTextLabel.attributedText = attributedString;
        [self addSubview:_dealTextLabel];
        
        [_dealTextLabel addTapAction:self selector:@selector(showAgreeDeal)];
        
//        DWJQWeakSelf;
//        [_dealTextLabel yb_addAttributeTapActionWithStrings:@[dealName] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
//            if (weakSelf.clickActionTextBlock) {
//                weakSelf.clickActionTextBlock();
//            }
//        }];
//        //设置是否有点击效果，默认是YES
//        _dealTextLabel.enabledTapEffect = NO;
  
    }
    return  self;
}
-(void)showAgreeDeal
{
    if (self.clickActionTextBlock) {
        self.clickActionTextBlock();
    }
}

-(void)resetTipText:(NSString *)tipText andDealName:(NSString *)dealName andTextAlignment:(NSTextAlignment)alignment
{
    _tipText = tipText;
    _dealName = dealName;
    NSString *allText = [NSString stringWithFormat:@"%@%@",_tipText,_dealName];
    
    NSRange tipTextRange = [allText rangeOfString:_tipText];
    NSRange dealNameRange = [allText rangeOfString:_dealName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allText];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, allText.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:_tipTextColor range:tipTextRange];
    [attributedString addAttribute:NSForegroundColorAttributeName value:_dealNameColor range:dealNameRange];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0,attributedString.length)];
    _dealTextLabel.attributedText = attributedString;
    
    _cellHeight = 50*DWJQViewScaleX_375;
}


-(CGFloat)cellHeight
{
    return _cellHeight;
}

@end
