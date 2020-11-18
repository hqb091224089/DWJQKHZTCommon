//
//  DWJQVarifyCodeSendView.m
//  DWJQ
//
//  Created by User01 on 16/12/26.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQVarifyCodeSendView.h"

@implementation DWJQVarifyCodeSendView

-(instancetype)initWithFrame:(CGRect)frame andStartSecond:(int)second
{
    if (self = [super initWithFrame:frame]) {
        _startSecond = second;
        
        float viewWidth = frame.size.width;
        float viewHeight = frame.size.height;
        
        _varifyCodeSendControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        [_varifyCodeSendControl addTarget:self action:@selector(sendAuthCodeRequest) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_varifyCodeSendControl];

        _countlabel = [[UILabel alloc] initWithFrame:_varifyCodeSendControl.bounds];
        _countlabel.font = [UIFont systemFontOfSize:16*DWJQViewScaleX_375];
        _countlabel.textAlignment = NSTextAlignmentCenter;
        _countlabel.textColor = DWJQCOLOR_C25;
        _countlabel.text = @"获取验证码";
        [_varifyCodeSendControl addSubview:_countlabel];
        
    }
    return self;
}


-(void)sendAuthCodeRequest
{

    if (_didClickAuthCodeBtnBlock) {
        _didClickAuthCodeBtnBlock(self);
    }

}

-(void)startCount
{
    _varifyCodeSendControl.enabled = NO;
    
    NSString *secondStr = [NSString stringWithFormat:@"%d",_startSecond];
    NSString *descripStr = @"秒后可重发";
    
    NSString *allText = [NSString stringWithFormat:@"%@  %@",secondStr,descripStr];
    
    NSRange secondStrRange = [allText rangeOfString:secondStr];
    NSRange descripStrRange = [allText rangeOfString:descripStr];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allText];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18*DWJQViewScaleX_375] range:secondStrRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*DWJQViewScaleX_375] range:descripStrRange];
    [attributedString addAttribute:NSForegroundColorAttributeName value:DWJQCOLOR_C22 range:secondStrRange];
    [attributedString addAttribute:NSForegroundColorAttributeName value:DWJQCOLOR_C25 range:descripStrRange];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0,attributedString.length)];
    
    _countlabel.attributedText = attributedString;
    
    _currentSecond = _startSecond;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown) userInfo:nil repeats:YES];
    if (_timerCountingBlock) {
        _timerCountingBlock(_currentSecond);
    }
}



-(void)Countdown
{
    _currentSecond--;

    NSString *secondStr = [NSString stringWithFormat:@"%d",_currentSecond];
    NSString *descripStr = @"";
    NSString *allText = @"";
    
    if (_currentSecond == 0) {
        [self.timer invalidate];
        self.timer = nil;
        _varifyCodeSendControl.enabled = YES;
        descripStr = @"重发验证码";
        allText = descripStr;
        if (_timerDidCountEndBlock) {
            _timerDidCountEndBlock();
        }
    }
    else
    {
        descripStr = @"秒后可重发";
        allText = [NSString stringWithFormat:@"%@ %@",secondStr,descripStr];
        if (_timerCountingBlock) {
            _timerCountingBlock(_currentSecond);
        }
        
    }
    NSRange secondStrRange = [allText rangeOfString:secondStr];
    NSRange descripStrRange = [allText rangeOfString:descripStr];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allText];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18*DWJQViewScaleX_375] range:secondStrRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*DWJQViewScaleX_375] range:descripStrRange];
    [attributedString addAttribute:NSForegroundColorAttributeName value:DWJQCOLOR_C22 range:secondStrRange];
    [attributedString addAttribute:NSForegroundColorAttributeName value:DWJQCOLOR_C25 range:descripStrRange];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0,attributedString.length)];
    _countlabel.attributedText = attributedString;
    
    
    
}

-(void)stop
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }

    _varifyCodeSendControl.enabled = YES;
    NSString *descripStr = @"重发验证码";
    NSString *allText = descripStr;

    NSRange descripStrRange = [allText rangeOfString:descripStr];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allText];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*DWJQViewScaleX_375] range:descripStrRange];

    [attributedString addAttribute:NSForegroundColorAttributeName value:DWJQCOLOR_C25 range:descripStrRange];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0,attributedString.length)];
    _countlabel.attributedText = attributedString;

}



@end
