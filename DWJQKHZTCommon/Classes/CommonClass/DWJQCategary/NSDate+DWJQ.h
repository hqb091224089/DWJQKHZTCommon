//
//  NSDate+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DWJQ)

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;


/**
 *  返回一个只有年月日的时间字符 yyyy年MM月dd日
 */
- (NSString *)stringDateWithFormatterStr:(NSString *)str;
/**
 *  根据NSDate返回昨天还是明天的字符串
 */
+ (NSString *) compareDate:(NSDate *)date;
//同上，扩展
+ (NSString *) compareCurrentTime:(NSDate*) compareDate;

/**
 *  根据一个自1970年的秒数返回一个yyyy/MM/dd格式的日期字符
 *  这个是毫秒
 */
+(NSString *)getDateStringWithBigStringStyle:(NSString *)string withFormatterStr:(NSString *)str;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString*)format;
+ (NSDate *)now;



/***************************************  股市日历用到 ****************************************************************/

#pragma mark - Decomposing Dates

+ (NSCalendar *) currentCalendar;
+ (NSCalendar *)sharedCalendar;
////
+ (BOOL) CheckSameDay:(NSDate*)day1 AnotherDay:(NSDate*)day2;


@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

//NSDate转NSString
- (NSString *)stringFromDate:(NSDate *)date;
//判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate;
//判断日期是今天,明天,后天,昨天、前天
-(NSString *)compareTodayWithDateForChineseDescrip;

#pragma mark -

//获取之后几天的日期

- (NSDate *) dateByAddingDays: (NSInteger) dDays;
//获取之后几个月的日期
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;



//获取当前日期之后的几个月
-(NSDate *)dayInTheFollowingMonth:(int)month;
//获取当前日期之后的几个星期
-(NSDate *)dayInTheFollowingWeek:(int)week;
//获取当前日期之后的几个天
-(NSDate *)dayInTheFollowingDay:(int)day;

//获取年月日对象
- (NSDateComponents *)YMDComponents;

#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format;

/***************临界日期方法  ***************/
- (NSDate *)beginningOfDay;
- (NSDate *)endOfDay;
- (NSDate *)beginningOfWeek;
- (NSDate *)endOfWeek;
- (NSDate *)beginningOfMonth;
- (NSDate *)endOfMonth;
- (NSDate *)beginningOfYear;
- (NSDate *)endOfYear;

- (NSUInteger)numberOfDaysInCurrentMonth;

- (NSUInteger)numberOfWeeksInCurrentMonth;

- (NSUInteger)weeklyOrdinality;

-(NSDate *)firstDayOfCurrentWeek;

- (NSDate *)firstDayOfCurrentMonth;

- (NSDate *)lastDayOfCurrentMonth;

- (NSDate *)dayInThePreviousMonth;

- (NSDate *)dayInTheFollowingMonth;


/***************  日期对比方法 ***************/
- (NSComparisonResult)CompareDateOnly:(NSDate *)otherDate;
- (NSComparisonResult)CompareMonthOnly:(NSDate *)otherDate;


#pragma mark - 获取农历的年份 月份 日期
- (NSString*) ChineseYear;
- (NSString*) ChineseMonth;
- (NSString*) ChineseDay;
- (NSInteger) chinese_month;
- (NSInteger) chinese_day;
-(NSString *) lunarHoliday;
-(NSString *) gregorianHoliday;


/***************  根据某个日期获取这个月的开始或结束的日期  ***************/
+ (NSDate *)startDateOfCalendarDate:(NSDate *)date;
+ (NSDate *)endDateOfCalendarDate:(NSDate *)date;


//获取某些日期的间隔
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;

-(NSInteger)getWeekNumberbeforeDay:(NSDate *)beforeDay;

-(NSInteger)getMonthNumberbeforeDay:(NSDate *)beforeDay;

-(NSInteger)getMinutesNumberbeforeDay:(NSDate *)beforeDay;

-(NSInteger)getMinutesNumberafterDay:(NSDate *)afterDay;

-(NSInteger)getWeekIntValueWithDate;
//通过数字返回周几
+(NSString *)getWeekStringFromInteger:(NSInteger)week;
//通过数字返回星期几
+(NSString *)getWeekString2FromInteger:(NSInteger)week;

// 获取某天的星期不同形式
+(NSString*)dayOfWeek:(NSDate*)date;
+(NSString*)dayOfWeekJX:(NSDate *)date;
//根据日期获取该日期对应星期几英文缩写
+(NSString*)dayOfWeekEnglishAbbr:(NSDate *)date;

/*************************************   股市日历用到 END*****************************************************************/
//判断是否是闰年
+(BOOL)bissextile:(NSInteger)year;
@end
