//
//  DWJQEmptyView.m
//  DWJQ
//
//  Created by luoxingyu on 16/6/28.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQEmptyView.h"

@implementation DWJQEmptyView
+ (instancetype)viewFromNib
{
    DWJQEmptyView *emptyView = [[NSBundle mainBundle]loadNibNamed:@"DWJQEmptyView" owner:nil options:nil].firstObject;
    return emptyView;
}
+ (CGSize)emptyViewFixedSize
{
    return CGSizeMake(200.f, 150.f);
}
@end
