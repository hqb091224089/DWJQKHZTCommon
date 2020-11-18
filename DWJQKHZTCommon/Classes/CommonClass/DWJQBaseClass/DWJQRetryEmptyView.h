//
//  DWJQRetryEmptyView.h
//  DWJQ
//
//  Created by 东吴秀财开发 on 16/9/10.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQEmptyView.h"
@protocol DWJQRetryDelegate<NSObject>
- (void)afterRetryTouch;
@end
@interface DWJQRetryEmptyView : DWJQEmptyView
@property id<DWJQRetryDelegate> delegate;
@end
