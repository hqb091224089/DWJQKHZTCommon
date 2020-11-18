//
//  DWJQBaseBlackCell.h
//  DWJQ
//
//  Created by User01 on 16/12/23.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "DWJQBaseTableViewCell.h"
//空cell
@interface DWJQBaseBlackCell : DWJQBaseTableViewCell

@property(nonatomic,strong)UIView *topSepLine;
@property(nonatomic,strong)UIView *bottomSepLine;

@property(nonatomic,assign)float topLineSpace;

@property(nonatomic,assign)float bottomLineSpace;

@property(nonatomic,assign)float resetCellHeight;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellHeight:(float)resetCellHeight;
@end
