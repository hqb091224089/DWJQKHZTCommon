//
//  UIScrollView+DWJQRefresh.m
//  DWJQ
//
//  Created by 东吴秀财开发 on 2017/6/16.
//  Copyright © 2017年 logictech. All rights reserved.
//

#import "UIScrollView+DWJQRefresh.h"


@implementation UIScrollView (DWJQRefresh)

static const char MJRefreshHeaderKey = '\0';
- (void)setCustomHeader:(DWJQRefreshHeader *)customHeader{
    if (customHeader != self.customHeader) {
        // 删除旧的，添加新的
        [self.customHeader removeFromSuperview];
        [self addSubview:customHeader];
        
        // 存储新的
        [self willChangeValueForKey:@"header"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
                                 customHeader, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"]; // KVO
    }
}
- (DWJQRefreshHeader *)customHeader{
    return objc_getAssociatedObject(self, &MJRefreshHeaderKey);
}

@end
