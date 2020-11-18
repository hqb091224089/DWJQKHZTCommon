//
//  DWJQVarifyCodeSendCell.h
//  DWJQ
//
//  Created by User01 on 16/12/26.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseTableViewCell.h"
#import "DWJQVarifyCodeSendView.h"

@class DWJQVarifyCodeSendCell;
typedef void(^DidClickVarifyCodeSendBlock)(DWJQVarifyCodeSendCell *varifyCodeSendCell);
/**
 发送验证码CELL
 */
@interface DWJQVarifyCodeSendCell : DWJQBaseTableViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextField *valueTf;
@property(nonatomic,strong)DWJQVarifyCodeSendView *varifyCodeSendView;
@property(nonatomic,strong)UIView *topSepLine;
@property(nonatomic,strong)UIView *bottomSepLine;

@property(nonatomic,assign)float topLineSpace;

@property(nonatomic,assign)float bottomLineSpace;

@property(nonatomic,strong)NSString *phoneNum;
/**
 输入框占位文字（set方法里设置占位文字文字属性）
 */
@property(nonatomic,strong)NSString *inputPlaceHolder;


@property(nonatomic,strong)DidClickVarifyCodeSendBlock clickVarifyCodeSendBlock;
@property(nonatomic,strong)TimerDidCountEndBlock timerDidCountEndBlock;
@property(nonatomic,strong)TimerCountingBlock timerCountingBlock;
@end
