//
//  DWJQBaseBlackCell.m
//  DWJQ
//
//  Created by User01 on 16/12/23.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseBlackCell.h"

/**
 空白cell
 */
@implementation DWJQBaseBlackCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellHeight:(float)resetCellHeight
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = DWJQCOLOR_C18;
        float cellWidth = kDWJQScreenWidth;
        _resetCellHeight = resetCellHeight;
        
        _topSepLine = [[UIView alloc] initWithFrame:CGRectMake(0,0,cellWidth, 0.5)];
        _topSepLine.backgroundColor = DWJQCOLOR_C9;
        _topSepLine.hidden = YES;
        [self addSubview:_topSepLine];
        
        _bottomSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, _resetCellHeight-0.5, cellWidth, 0.5)];
        _bottomSepLine.backgroundColor = DWJQCOLOR_C9;
        _bottomSepLine.hidden = YES;
        [self addSubview:_bottomSepLine];
#ifdef DWKH
        _topSepLine.backgroundColor = DWJQCOLOR_C20;
        _bottomSepLine.backgroundColor = DWJQCOLOR_C20;
#endif
        
    }
    return  self;
}

-(void)setTopLineSpace:(float)topLineSpace
{
    _topLineSpace = topLineSpace;
    float cellWidth = kDWJQScreenWidth;
    _topSepLine.frame = CGRectMake(_topLineSpace,0,cellWidth-_topLineSpace*2, 0.5);
}

-(void)setBottomLineSpace:(float)bottomLineSpace
{
    _bottomLineSpace = bottomLineSpace;
    float cellWidth = kDWJQScreenWidth;
    float cellHeight = _resetCellHeight;//50;
    _bottomSepLine.frame = CGRectMake(_bottomLineSpace, cellHeight-0.5,cellWidth-_bottomLineSpace*2, 0.5);
}

-(void)setResetCellHeight:(float)resetCellHeight
{
    _resetCellHeight = resetCellHeight;
    float cellWidth = kDWJQScreenWidth;
    _bottomSepLine.frame = CGRectMake(_bottomLineSpace, _resetCellHeight-0.5,cellWidth-_bottomLineSpace*2, 0.5);
}

-(CGFloat)cellHeight
{
    return _resetCellHeight;
}

@end
