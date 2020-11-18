//
//  DWJQDialogHelper.m
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/8.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQDialogHelper.h"
#import "DWJQSVProgressHUD.h"
//#import <apexsoftiOSBaseLib/SVProgressHUD.h>
//#import "UIAlertView+DWJQBlocks.h"
#import "UIAlertView+Blocks.h"
#import <WebKit/WebKit.h>
static const NSTimeInterval kMinimumDismissTimeInterval = 2.0;

// 禁止显示HUD
static BOOL disabledShowHUD = NO;

@implementation DWJQDialogHelper

#pragma mark - HUD
+ (void)enabledHUD
{
    disabledShowHUD = NO;
}

+ (void)disabledHUD
{
    disabledShowHUD = YES;
}
+ (void)showSuccessHUD:(NSString *)text delay:(CGFloat)delay
{
    if (disabledShowHUD)
        return;
    [DWJQSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [DWJQSVProgressHUD setMinimumDismissTimeInterval:delay];
    [DWJQSVProgressHUD showImage:nil status:text];
}
+ (void)showSuccessHUD:(NSString *)text
{
    if (disabledShowHUD)
        return;
    [DWJQSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [DWJQSVProgressHUD setMinimumDismissTimeInterval:kMinimumDismissTimeInterval];
    [DWJQSVProgressHUD showImage:nil status:text];
}

+ (void)showErrorHUD:(NSString *)text
{
    if (disabledShowHUD)
        return;
    [DWJQSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [DWJQSVProgressHUD setMinimumDismissTimeInterval:kMinimumDismissTimeInterval];
    [DWJQSVProgressHUD showImage:nil status:text];
}
+ (void)showErrorHUD:(NSString *)text delay:(CGFloat)delay
{
    if (disabledShowHUD)
        return;
    [DWJQSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [DWJQSVProgressHUD setMinimumDismissTimeInterval:delay];
    [DWJQSVProgressHUD showImage:nil status:text];
}


+ (void)showProgressHUD:(NSString *)text
{
    if (disabledShowHUD)
        return;
    [DWJQSVProgressHUD setRingNoTextRadius:19.f];
    [DWJQSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];//自定义动图
//    [DWJQSVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeElephant];//自定义动图
    [DWJQSVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];//自定义动图
    [DWJQSVProgressHUD setMinimumDismissTimeInterval:kMinimumDismissTimeInterval];
    [DWJQSVProgressHUD showWithStatus:text];
}

+ (void)showBlockProgressHUD:(NSString *)text
{
    if (disabledShowHUD)
        return;
    [DWJQSVProgressHUD setRingNoTextRadius:19.f];
    [DWJQSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [DWJQSVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];//自定义动图
//    [DWJQSVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeElephant];//自定义动图
    [DWJQSVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];//自定义动图
    [DWJQSVProgressHUD setMinimumDismissTimeInterval:kMinimumDismissTimeInterval];
    [DWJQSVProgressHUD showWithStatus:text];
}

+ (void)dismissWaitHUD
{
    [DWJQSVProgressHUD dismiss];
}
+ (void)dismissMessageHUD
{
    [DWJQSVProgressHUD dismiss];
}
#pragma mark - AlertView

+ (UIAlertView *)showWithTitle:(NSString *)title
                      message:(NSString *)message
                        style:(UIAlertViewStyle)style
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                     actionBlock:(DWJQAlertViewCommonActionBlock)actionBlock
{

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message cancelButtonItem:nil otherButtonItems:nil];
    BOOL hasCancleButton = YES;
    if (cancelButtonTitle.length > 0) {
        RIButtonItem *cancleItem = [RIButtonItem itemWithLabel:cancelButtonTitle action:^{
            if (actionBlock) {
                actionBlock(alertView,0);
            }
            
        }];
        [alertView addButtonItem:cancleItem];
    }else{
        hasCancleButton = NO;
    }
    if (otherButtonTitles.count > 0) {
        for (int index = 0;index < otherButtonTitles.count;index++) {
            NSString *title = otherButtonTitles[index];
            RIButtonItem *item = [RIButtonItem itemWithLabel:title action:^{
                if (actionBlock) {
                    actionBlock(alertView,index+(hasCancleButton?1:0));
                }
                
            }];
            [alertView addButtonItem:item];
        }
    }
    [alertView show];
    return alertView;
}

+ (UIAlertView *)showWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                     actionBlock:(DWJQAlertViewCommonActionBlock)actionBlock
{
    return [DWJQDialogHelper showWithTitle:title message:message style:UIAlertViewStyleDefault cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles actionBlock:actionBlock];
}

#pragma mark - DialView
+ (BOOL)showTelephoneView:(NSString *)telephone view:(UIView *)view
{
    BOOL ret = NO;
    if (telephone.length > 0 && view != nil) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",telephone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    return ret;
    
}
+ (BOOL)showQQView:(NSString *)QQNumber view:(UIView *)view
{
    BOOL ret = NO;
    if (QQNumber.length > 0 && view != nil) {
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQNumber]];
//         NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqqwpa://im/chat?chat_type=crm&uin=%@&version=1&src_type=web&web_src=http:://wpa.b.qq.com",@"938007826"]];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [webView loadRequest:request];
//        [view addSubview:webView];
        NSString *url = [NSString stringWithFormat:@"http://wpa.b.qq.com/cgi/wpa.php?ln=2&uin=%@",QQNumber];
 		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
        ret = YES;
    }
    return ret;
    
}
@end
