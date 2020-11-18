//
//  UIScrollView+DWJQRefresh.h
//  DWJQ
//
//  Created by 东吴秀财开发 on 2017/6/16.
//  Copyright © 2017年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DWJQRefreshHeader;

@interface UIScrollView (DWJQRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic) DWJQRefreshHeader *customHeader;

@end
