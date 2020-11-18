//
//  DWJQBaseTableView.h
//  DWJQ
//
//  Created by luoxingyu on 16/7/12.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWJQPageInfoMData.h"
@interface DWJQBaseTableView : UITableView
/**
 *  页面信息
 */
@property (nonatomic,strong) DWJQPageInfoMData *pageInfoData;
-(DWJQPageInfoMData *)pageInfoData;

@property (nonatomic , assign) NSInteger currentPage;

@end
