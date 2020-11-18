//
//  DWJQErrorDefine.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#ifndef DWJQErrorDefine_h
#define DWJQErrorDefine_h

#define DWJQErrorDomain       @"DWJQerrormain"

typedef enum _DWJQErrorCode {
    DWJQErrorCodeCommon               = -99999,
    DWJQErrorCodeInvalidParameter     = DWJQErrorCodeCommon - 1,  // 参数无效
    
} DWJQErrorCode;

// int型数据的初始化数值
#define DWJQUnSetIntValue     -999999

#endif /* DWJQErrorDefine_h */
