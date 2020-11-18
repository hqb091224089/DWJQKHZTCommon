//
//  DWJQVarifyCodeSendCell.m
//  DWJQ
//
//  Created by User01 on 16/12/26.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQVarifyCodeSendCell.h"

@implementation DWJQVarifyCodeSendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = DWJQCOLOR_WHITE;
        
        float cellHeight = 62*DWJQViewScaleX_375;
        float cellWidth = kDWJQScreenWidth;
        
        _titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(20,0,80*DWJQViewScaleX_375,cellHeight)];
        _titleLabel.textColor = DWJQCOLOR_C25;
        _titleLabel.font =  [UIFont systemFontOfSize:16*DWJQViewScaleX_375];;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
        

        _varifyCodeSendView = [[DWJQVarifyCodeSendView alloc] initWithFrame:CGRectMake(kDWJQScreenWidth-135*DWJQViewScaleX_375,0,135*DWJQViewScaleX_375, cellHeight) andStartSecond:60];

        _varifyCodeSendView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_varifyCodeSendView];
        
        DWJQWeakSelf;
        _varifyCodeSendView.didClickAuthCodeBtnBlock = ^(DWJQVarifyCodeSendView  *varifyCodeSendView)
        {
            if (weakSelf.clickVarifyCodeSendBlock) {
                weakSelf.clickVarifyCodeSendBlock(weakSelf);
            }
        };

        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(kDWJQScreenWidth-135*DWJQViewScaleX_375-0.5,10,0.5,cellHeight-20)];
        sepLine.backgroundColor = DWJQCOLOR_C20;
        [self addSubview:sepLine];

        
        _valueTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, cellWidth-CGRectGetMaxX(_titleLabel.frame)-_varifyCodeSendView.bounds.size.width-5, cellHeight)];
        _valueTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _valueTf.font = [UIFont systemFontOfSize:18];
        _valueTf.textColor = DWJQCOLOR_C25;
        [self addSubview:_valueTf];
        
        _topSepLine = [[UIView alloc] initWithFrame:CGRectMake(0,0,cellWidth, 0.5)];
        _topSepLine.backgroundColor = DWJQCOLOR_C20;
        [self addSubview:_topSepLine];
        
        _bottomSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-0.5, cellWidth, 0.5)];
        _bottomSepLine.backgroundColor = DWJQCOLOR_C20;
        [self addSubview:_bottomSepLine];
    }
    return  self;
}

-(void)setInputPlaceHolder:(NSString *)inputPlaceHolder
{
    _inputPlaceHolder = inputPlaceHolder;
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:inputPlaceHolder];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:@"c6c6c6"]
                        range:NSMakeRange(0, inputPlaceHolder.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, inputPlaceHolder.length)];
    
    NSMutableParagraphStyle *style = [_valueTf.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    
    style.minimumLineHeight = _valueTf.font.lineHeight - (_valueTf.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
    [placeholder addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, inputPlaceHolder.length)];
    
    _valueTf.attributedPlaceholder = placeholder;
    
}



-(void)setTimerDidCountEndBlock:(TimerDidCountEndBlock)timerDidCountEndBlock
{
    _timerDidCountEndBlock = timerDidCountEndBlock;
    _varifyCodeSendView.timerDidCountEndBlock = _timerDidCountEndBlock;
}

-(void)setTimerCountingBlock:(TimerCountingBlock)timerCountingBlock
{
    _timerCountingBlock = timerCountingBlock;
    _varifyCodeSendView.timerCountingBlock = _timerCountingBlock;
}

-(CGFloat)cellHeight
{
    return 62*DWJQViewScaleX_375;
}

@end
