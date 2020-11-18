//
//  DWJQAppDefine.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#ifndef DWJQAppDefine_h
#define DWJQAppDefine_h
//-------------------- 提交appstore时修改 --------------------
// base url（1:开发环境；2:测试环境；3:正式环境 ; 4:灰度环境）
/**
 *  备注：1秀才的开发环境，掌厅的测试环境dev branch
 *       2秀才的测试环境，掌厅的测试环境release branch
 *       3秀才的正式环境，掌厅的正式环境
 *       4秀才的灰度环境，掌厅的灰度环境
 #       5秀才的压测环境，掌厅的测试环境dev branch
 */
#define kDWJQNetEnvVar  1
#define kDWJQZhangTingNetEnvVar  0
//标志是否展示网络提示／是否收集崩溃日志／是否在设置页展示版本信息
//#define DWJQDEBUG

//标志不同的推送id／不同的分享
//#define ISAppStore //Appstore标签


#define kDWJQAppNetVersion  @"350"


//-------------------- 不需要修改 --------------------
// appstore的appid
#define kDWJQAppStoreId               @"1041288958"

// 友盟的appid(待添加)

// 这个是分享相关的 
// QQ好友、QQ空间分享的AppId
#define kDWJQQqAppId                  @""

// QQ的AppKey
#define kDWJQQqAppKey                 @""



// 微信的默认分享url
#define kDWJQWeiXinDeaultShareURL     @""

// 微信的scheme
#define kDWJQSchemeWeiXin             @""


// 硬编码的联系电话
// 秀才 (拨打)
#define kDWJQXiuCaiTelePhoneNumber   @"95330"
// 客服QQ
#define kDWJQXiuCaiQQNumber   @"4008601555"

// 微信的appid
#define kDWJQWeiXinAppId              @""

// 微信的SecretKey
#define kDWJQWeiXinSecretKey         @""

//掌厅股东账户开户的协议号
#define kDWJQMobileHall_OpenCount_Protocal         @"10000029"

//weak
#define DWJQWeakSelf                  typeof(self) __weak weakSelf = self

#define DWJQVisitorNetCacheKey    @"visitor"

// 市场代码
#define HX_ParamKey_StockMarket_SH @73  //沪市
#define HX_ParamKey_StockMarket_SZ @153 //深市

#define kDWJQOnePassCustomID @"7f7f09f4d96b811b7fec1e4e40b6f656"
#define kDWJQSecrectKey  @"4a2b96d21444c437f7a25960178203e5"

#define kDWJQAskProductId  @"WENDA_PROD"
#define kDWJQCircuseeProductId  @"WEIGUAN_PROD"

#endif /* DWJQAppDefine_h */
