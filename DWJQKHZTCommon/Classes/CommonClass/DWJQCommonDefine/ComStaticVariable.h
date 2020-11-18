//
//  ComStaticVariable.h
//  Com
//
//  Created by LTA on 14-12-16.
//  Copyright (c) 2014年 logictech. All rights reserved.
//

#ifndef Com_ComStaticVariable_h
#define Com_ComStaticVariable_h


//静态storyboard名字

#define Main @"Main"

#define FnclSmryInfoSB @"FnclSmryInfoSB"
#define PkInfoSB @"PkInfoSB"
#define MyProfitDayWeekSB @"MyProfitDayWeekSB"
#define UnlockSB @"UnlockSB"
#define QuestionSB @"QuestionSB"
#define QuestionNavSB @"QuestionNavSB"
#define RecommendSB @"RecommendSB"
//特色秀
#define SpecShowSB @"SpecShowSB"
#define PersonCenterSB @"PersonCenter"
#define CombitionSB @"CombitionSB"




#define VersionInfoKey @"VersionInfoKey"

#define UserInfoKey @"UserInfoKey"


//全局单列记录的一些用户信息
#define ComUserId [Com_UserInfo sharedInstance].userId
#define ComPicturePath [Com_UserInfo sharedInstance].picturePath
#define ComNickName [Com_UserInfo sharedInstance].nickName
#define ComAccount [Com_UserInfo sharedInstance].account
#define ComAccountName [Com_UserInfo sharedInstance].accountName
#define ComtempUerId [Com_UserInfo sharedInstance].tempUerId
#define ComLogOutFlg [Com_UserInfo sharedInstance].isLogout
#define ComNeverLogin [Com_UserInfo sharedInstance].isNeverLogin
#define Comlsh [Com_UserInfo sharedInstance].lsh
#define ComMobile [Com_UserInfo sharedInstance].mobile
#define ComportfolioId [Com_UserInfo sharedInstance].portfolioId
#define ComcanAmountEdit [Com_UserInfo sharedInstance].canAmountEdit
#define ComRenewDate [Com_UserInfo sharedInstance].renewDate


#define hiddenTime 1


#define ThisIsLast @"🐰🐯🐱"


/**
 *  有权限
 */

#define SECRETKEY @"123qwe."

#define SECRETNAME @"md5Info"

#define TOKENID @"token"

#define APPREQUESTVERSION @"version"

#define APPREQUESTSYSTEM @"osType"

#define CommonInfo @"info"

//记账模块用到
//收入
#define CommonIncome @"1"
//支出
#define CommonPay @"2"

#define RightBarButtonFont [UIFont systemFontOfSize:15.0f]

#endif
