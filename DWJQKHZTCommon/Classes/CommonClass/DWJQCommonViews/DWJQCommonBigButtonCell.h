//
//  DWJQCommonBigButtonCell.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/22.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseTableViewCell.h"

typedef enum
{
    DWJQCommonBigButtonCellButtonStyle_Bottom     = 0,
    DWJQCommonBigButtonCellButtonStyle_Center     = 1,
     DWJQCommonBigButtonCellButtonStyle_Top       = 2,
} DWJQCommonBigButtonCellButtonStyle;

@interface DWJQCommonBigButtonCell : DWJQBaseTableViewCell

@property (nonatomic, weak) IBOutlet UIButton *button;

@property (nonatomic, assign) DWJQCommonBigButtonCellButtonStyle buttonStyle;

+ (instancetype)cellFromNib;
+ (CGFloat)cellHeight;

@end
