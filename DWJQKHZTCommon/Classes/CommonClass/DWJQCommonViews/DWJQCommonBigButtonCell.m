//
//  DWJQCommonBigButtonCell.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/22.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQCommonBigButtonCell.h"

@implementation DWJQCommonBigButtonCell

+ (instancetype)cellFromNib
{
    UINib * nib = [UINib nibWithNibName:@"DWJQCommonBigButtonCell" bundle:nil];
    NSArray * array = [nib instantiateWithOwner:nil options:nil];
    for (id object in array) {
        if ([object isKindOfClass:[DWJQCommonBigButtonCell class]]) {
            return object;
        }
    }
    return nil;
}

+ (CGFloat)cellHeight
{
    CGFloat h = 60.0f;
    return h;
}
+ (CGFloat)cellHeightWithData:(id)cellData
{
    return [self cellHeight];
}
- (CGFloat)cellHeight
{
    return [DWJQCommonBigButtonCell cellHeightWithData:nil];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.button setBackgroundColor:DWJQCOLOR_MobileHall_C1];
    self.button.layer.cornerRadius = 5;
    [self.button setTitleColor:DWJQCOLOR_WHITE forState:UIControlStateNormal];
    [self.button setTitleColor:DWJQCOLOR_WHITE forState:UIControlStateHighlighted];
    self.buttonStyle = DWJQCommonBigButtonCellButtonStyle_Bottom;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_buttonStyle == DWJQCommonBigButtonCellButtonStyle_Bottom) {
        self.button.top = self.height - self.button.height-1;
    } else if (_buttonStyle == DWJQCommonBigButtonCellButtonStyle_Center) {
        self.button.top = (self.height - self.button.height) / 2;
    }
    else if (_buttonStyle == DWJQCommonBigButtonCellButtonStyle_Top) {
        self.button.top = 1;
    }

}

- (void)setButtonStyle:(DWJQCommonBigButtonCellButtonStyle)buttonStyle
{
    _buttonStyle = buttonStyle;
    if (_buttonStyle == DWJQCommonBigButtonCellButtonStyle_Bottom) {
        self.button.bottom = self.bottom-1;
    } else if (_buttonStyle == DWJQCommonBigButtonCellButtonStyle_Center) {
        self.button.top = (self.height - self.button.height) / 2;
    }
    else if (_buttonStyle == DWJQCommonBigButtonCellButtonStyle_Top) {
        self.button.top = 1;
    }
}

@end
