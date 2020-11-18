//
//  DWJQVarifyCodeSendView.h
//  DWJQ
//
//  Created by User01 on 16/12/26.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DWJQVarifyCodeSendView;
typedef void(^DidClickAuthCodeBtnBlock)(DWJQVarifyCodeSendView *varifyCodeSendView);
typedef void(^TimerCountingBlock)(int);
typedef void(^TimerDidCountEndBlock)(void);

/**
 发送验证码按钮
 */
@interface DWJQVarifyCodeSendView : UIControl
{
    int _currentSecond;
}


@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UIControl *varifyCodeSendControl;

@property(nonatomic,strong)UILabel *countlabel;

@property(nonatomic,strong)DidClickAuthCodeBtnBlock didClickAuthCodeBtnBlock;
@property(nonatomic,strong)TimerDidCountEndBlock timerDidCountEndBlock;
@property(nonatomic,strong)TimerCountingBlock timerCountingBlock;
@property(nonatomic,assign)int startSecond;
@property(nonatomic,assign)int currentSecond;
-(instancetype)initWithFrame:(CGRect)frame andStartSecond:(int)second;
-(void)stop;
-(void)startCount;
@end
