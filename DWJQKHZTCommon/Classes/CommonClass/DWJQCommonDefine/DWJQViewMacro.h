//
//  DWJQViewMacro.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#ifndef DWJQViewMacro_h
#define DWJQViewMacro_h

// 1.
#define kDWJQScreenWidth          ([[UIScreen mainScreen] bounds].size.width)
#define kDWJQScreenHeight         ([[UIScreen mainScreen] bounds].size.height)
#define kDWJQScreenFrame          (CGRectMake(0, 0 ,kDWJQScreenWidth,kDWJQScreenHeight))
#define kDWJQStatusBarHeight      ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kDWJQApplicationHeight    (kDWJQScreenHeight - kDWJQStatusBarHeight)

#define kDWJQTabBarHeight         49.0f
#define kDWJQNavigationBarHeight  [UIApplication sharedApplication].keyWindow.currentViewController.navigationController.navigationBar.frame.size.height
#define kDWJQSafeAreaHeight [UIApplication sharedApplication].keyWindow.currentViewController.view.safeAreaInsets.bottom
#define kDWJQKeyboardrHeight      216.0f
#define kDWJQRefreshHeaderHeight  80.0f
#define kDWJQHomeIndicatorHeight  34.0f
#define kDWJQRefreshSlowAnimationDuration  0.6f
#define kDWJQRefreshSlowAnimationDelay  0.2f

#define SINGLE_LINE_Height           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define kDWJQLabelSeparatorWithoutEmoji  5.0f

//获取导航栏+状态栏的高度
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


// 判断是否3.5英尺
#define DWJQThreeHalfInch (480 == kDWJQScreenHeight)
#define DWJQThreeHalfInchScreenWidth 320
// 判断是否4英尺
#define DWJQFourInch (568 == kDWJQScreenHeight)
#define DWJQFourInchScreenWidth 320

//4.7 英寸
#define DWJQFourSevenInch (667 == kDWJQScreenHeight)
#define DWJQFourSevenInchScreenWidth 375
#define DWJQFourSevenInchScreenHeight 667

//5.5英寸
#define DWJQFiveFiveInch (736  == kDWJQScreenHeight)

// 相对于(320 * 568)的比例--iPhone 5s
#define DWJQViewScaleX (kDWJQScreenWidth / 320.f)
#define DWJQViewScaleY (DWJQThreeHalfInch ? 1 : (kDWJQScreenHeight / 568.0f))

#define DWJQViewScaleX_320    (kDWJQScreenWidth / 320.f)
#define DWJQViewScaleY_320    (DWJQThreeHalfInch ? 1 : (kDWJQScreenHeight / 480.0f))

#pragma mark - iPhone 6
//相对于iPhone6(375 * 667)的比例
#define DWJQViewScaleX_375    (kDWJQScreenWidth / 375.f)
#define DWJQViewScaleY_375    DWJQViewScaleX_375
#define DWJQViewScaleY_667    (DWJQFourSevenInch ? 1 : (kDWJQScreenHeight / 667.f))

#define DWJQViewScaleN    DWJQViewScaleX_375

#define DWJQScaleRectMakeN(x, y, w, h) \
CGRectMake((x) * DWJQViewScaleN, (y) * DWJQViewScaleN, (w) * DWJQViewScaleN, (h) * DWJQViewScaleN)

#define DWJQScaleRectMakeWithRectN(r)  \
DWJQScaleRectMakeN(r.origin.x, r.origin.y, r.size.width, r.size.height)


#pragma mark - iPhone 5s
// 相对于(320 * 568)的rect和size
#define DWJQScaleRectMake(x, y, w, h) \
CGRectMake((x) * DWJQViewScaleX, (y) * DWJQViewScaleY, (w) * DWJQViewScaleX, (h) * DWJQViewScaleY)

#define DWJQScaleRectMakeWithRect(r)  \
DWJQScaleRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height)

#define DWJQScaleSizeMake(w, h)       \
CGSizeMake((w) * DWJQViewScaleX, (h) * DWJQViewScaleY)
#define DWJQScalePointMake(x, y)      \
CGPointMake((x) * DWJQViewScaleX, (y) * DWJQViewScaleY)

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)  

#endif /* DWJQViewMacro_h */
