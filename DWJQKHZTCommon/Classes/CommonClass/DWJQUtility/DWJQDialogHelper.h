//
//  DWJQDialogHelper.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/8.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _DWJQAlertViewButtonType
{
    DWJQAlertViewButtonType_Close     = -1,   // 关闭
    DWJQAlertViewButtonType_OK        = 0,    // 确定
    DWJQAlertViewButtonType_Cancel    = 1,    // 取消
} DWJQAlertViewButtonType;

typedef void (^DWJQAlertViewActionBlock)(DWJQAlertViewButtonType type);
typedef void (^DWJQAlertViewCommonActionBlock)(UIAlertView *alertView, NSInteger buttonIndex);


@interface DWJQDialogHelper : NSObject
#pragma mark - HUD
//提示框的便捷宏
#pragma mark message
#define ShowErrorMessage(msg) [DWJQDialogHelper showErrorHUD:msg];
#define ShowSuccessMessage(msg) [DWJQDialogHelper showSuccessHUD:msg];
#define DisappearWaitView [DWJQDialogHelper dismissWaitHUD];
#define DisappearMessageView [DWJQDialogHelper dismissMessageHUD];
#define ShowWaitView [DWJQDialogHelper showProgressHUD:nil];
#define ShowLoadView [DWJQDialogHelper showProgressHUD:nil];
#define ShowUpdateWaitView [DWJQDialogHelper showProgressHUD:@"上传中"];

+ (void)enabledHUD;
+ (void)disabledHUD;
+ (void)showSuccessHUD:(NSString *)text;
+ (void)showSuccessHUD:(NSString *)text delay:(CGFloat)delay;

+ (void)showErrorHUD:(NSString *)text;
+ (void)showErrorHUD:(NSString *)text delay:(CGFloat)delay;
+ (void)showProgressHUD:(NSString *)text;
+ (void)showBlockProgressHUD:(NSString *)text;

+ (void)dismissWaitHUD;
+ (void)dismissMessageHUD;
#pragma mark - AlertView

+ (UIAlertView *)showWithTitle:(NSString *)title
                      message:(NSString *)message
                        style:(UIAlertViewStyle)style
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                     actionBlock:(DWJQAlertViewCommonActionBlock)actionBlock;

+ (UIAlertView *)showWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                     actionBlock:(DWJQAlertViewCommonActionBlock)actionBlock;

#pragma mark - DialView
+ (BOOL)showTelephoneView:(NSString *)telephone view:(UIView *)view;
+ (BOOL)showQQView:(NSString *)QQNumber view:(UIView *)view;

@end
