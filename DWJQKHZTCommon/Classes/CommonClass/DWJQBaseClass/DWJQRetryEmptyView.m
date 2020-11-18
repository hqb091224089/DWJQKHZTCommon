//
//  DWJQRetryEmptyView.m
//  DWJQ
//
//  Created by 东吴秀财开发 on 16/9/10.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQRetryEmptyView.h"
@interface DWJQRetryEmptyView()
@property (weak, nonatomic) IBOutlet UIButton *retryBtn;

@end
@implementation DWJQRetryEmptyView
+ (instancetype)viewFromNib
{
    DWJQRetryEmptyView *emptyView = [[NSBundle mainBundle]loadNibNamed:@"DWJQEmptyView" owner:nil options:nil].lastObject;
    return emptyView;
}
+ (CGSize)emptyViewFixedSize
{
    return CGSizeMake(200.f, 260.f);
}
- (IBAction)retry:(id)sender {
    [self.delegate afterRetryTouch];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.retryBtn setTitleColor:DWJQCOLOR_C25 forState:UIControlStateNormal];
}
@end
