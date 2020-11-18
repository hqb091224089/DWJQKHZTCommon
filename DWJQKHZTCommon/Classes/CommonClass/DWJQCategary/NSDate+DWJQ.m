//
//  NSDate+DWJQ.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "NSDate+DWJQ.h"
#define KOneYearM  (60*60*24*365*1000.f)


#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
#define DateComponentsUnit NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday
#define MonthComponentsUnit NSCalendarUnitYear | NSCalendarUnitMonth


@implementation NSDate (DWJQ)

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}


/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}


+ (NSString *) compareDate:(NSDate *)date {
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    NSString * yesterdayString = [[yesterday stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    
    NSString * dateString = [[date stringDateWithFormatterStr:@"yyyy年MM月dd日"] substringToIndex:10];
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone=[NSTimeZone defaultTimeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:date];
        return destDateString;
    }
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *) compareCurrentTime:(NSDate*) compareDate {
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}


- (NSString *)stringDateWithFormatterStr:(NSString *)str
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.timeZone=[NSTimeZone defaultTimeZone];
    fmt.dateFormat =str;
    NSString *selfStr = [fmt stringFromDate:self];
    return selfStr;
}

+ (NSString *)getDateStringWithBigStringStyle:(NSString *)string withFormatterStr:(NSString *)str
{
    if (string==nil) {
        return @"";
    }
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    NSNumber *number = [fmt numberFromString:string];
    NSNumber *smallNumber=[NSNumber numberWithDouble:number.doubleValue/1000.f];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:smallNumber.doubleValue];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.timeZone=[NSTimeZone defaultTimeZone];
    [dateFormatter setDateFormat:str];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}
+ (NSDate *)dateWithString:(NSString *)string format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:string];
}
+ (NSDate *)now
{
    return [NSDate date];
}


/***************************************  股市日历用到 ****************************************************************/

+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}


static NSCalendar *_calendar = nil;
static NSDateFormatter *_displayFormatter = nil;

+ (void)initializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if (_calendar == nil) {
#if __has_feature(objc_arc)
                _calendar = [NSCalendar currentCalendar];
#else
                _calendar = [[NSCalendar currentCalendar] retain];
#endif
            }
            if (_displayFormatter == nil) {
                _displayFormatter = [[NSDateFormatter alloc] init];
            }
        }
    });
}
+ (NSCalendar *)sharedCalendar {
    [self initializeStatics];
    return _calendar;
}

/***************** 农历使用 ****************/
+ (NSCalendar *) sharedInstanceCalendarForChinese {
    static NSCalendar *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    });
    return sharedInstance;
}

/////////////
+ (BOOL) CheckSameDay:(NSDate*)day1 AnotherDay:(NSDate*)day2
{
    BOOL rt = YES;
    if (day1.day == day2.day)
    {
        rt = NO;
    }
    return rt;
}


//NSDate转NSString
- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *mdf =  [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [mdf stringFromDate:date];
    
    return destDateString;
}
//判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps_today= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:todate];
    
    
    NSDateComponents *comps_other= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:self];
    
    
    //获取星期对应的数字
    NSInteger weekIntValue = [self getWeekIntValueWithDate];
    
    if (comps_today.year == comps_other.year &&
        comps_today.month == comps_other.month &&
        comps_today.day == comps_other.day) {
        return @"今天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -1){
        return @"明天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -2){
        return @"后天";
        
    }else{
        //直接返回当时日期的字符串(这里让它返回空)
        return [NSDate getWeekStringFromInteger:weekIntValue];//周几
    }
}
//判断日期是今天,明天,后天,昨天、前天
-(NSString *)compareTodayWithDateForChineseDescrip
{
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps_today= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:todate];
    
    
    NSDateComponents *comps_other= [calendar components:(NSCalendarUnitYear |
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay |
                                                         NSCalendarUnitWeekday) fromDate:self];
    
    
    //获取星期对应的数字
    NSInteger weekIntValue = [self getWeekIntValueWithDate];
    
    
    if (comps_today.year == comps_other.year && comps_today.month == comps_other.month){
        if (comps_today.day == comps_other.day) {
            return @"今天";
            
        }else if ((comps_today.day - comps_other.day) == -1){
            return @"明天";
            
        }else if ((comps_today.day - comps_other.day) == -2){
            return @"后天";
            
        }else if ((comps_today.day - comps_other.day) == 1){
            return @"昨天";
            
        }else if ((comps_today.day - comps_other.day) == 2){
            return @"前天";
        }
        else{
            //直接返回当时日期的字符串(这里让它返回空)
            return [NSDate getWeekStringFromInteger:weekIntValue];//周几
        }

    }
     return [NSDate getWeekStringFromInteger:weekIntValue];//周几
}
//周日是“1”，周一是“2”...
-(NSInteger)getWeekIntValueWithDate
{
    NSInteger weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps= [calendar components:(NSCalendarUnitYear |
                                                   NSCalendarUnitMonth |
                                                   NSCalendarUnitDay |
                                                   NSCalendarUnitWeekday) fromDate:self];
    return weekIntValue = [comps weekday];
}
//通过数字返回周几
+(NSString *)getWeekStringFromInteger:(NSInteger)week
{
    NSString *str_week;
    
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    return str_week;
}

//通过数字返回星期几
+(NSString *)getWeekString2FromInteger:(NSInteger)week
{
    NSString *str_week;
    
    switch (week) {
        case 1:
            str_week = @"星期日";
            break;
        case 2:
            str_week = @"星期一";
            break;
        case 3:
            str_week = @"星期二";
            break;
        case 4:
            str_week = @"星期三";
            break;
        case 5:
            str_week = @"星期四";
            break;
        case 6:
            str_week = @"星期五";
            break;
        case 7:
            str_week = @"星期六";
            break;
    }
    return str_week;
}



#pragma mark -


//获取之后几天的日期

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}
//获取之后几个月的日期
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}


//获取当前日期之后的几个月
-(NSDate *)dayInTheFollowingMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = month;
    return [[NSDate sharedCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取当前日期之后的几个星期
-(NSDate *)dayInTheFollowingWeek:(int)week
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.weekOfYear = week;
    return [[[self class] sharedCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

//获取当前日期之后的几个天
-(NSDate *)dayInTheFollowingDay:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = day;
    return [[[self class] sharedCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}
//获取年月日对象
- (NSDateComponents *)YMDComponents
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    
    return [calendar components:(NSCalendarUnitYear |
                                 NSCalendarUnitMonth |
                                 NSCalendarUnitDay |
                                 NSCalendarUnitWeekday) fromDate:self];
}




#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

#pragma mark -
#pragma mark  临界日期方法
- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self beginningOfDay] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)beginningOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self];
    
    NSUInteger offset = ([components weekday] == [calendar firstWeekday]) ? 6 : [components weekday] - 2;
    [components setDay:[components day] - offset - 1];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:1];
    return [[calendar dateByAddingComponents:components toDate:[self beginningOfWeek] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)beginningOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self beginningOfMonth] options:0] dateByAddingTimeInterval:-1];
}

- (NSDate *)beginningOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1];
    
    return [[calendar dateByAddingComponents:components toDate:[self beginningOfYear] options:0] dateByAddingTimeInterval:-1];
}

/*计算这个月有多少天*/
-(NSUInteger)numberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[[self class] sharedCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

//计算这个星期最开始的一天
-(NSDate *)firstDayOfCurrentWeek
{
    NSDate *startDate = nil;
    BOOL ok = [[[self class] sharedCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}


//计算这个月最开始的一天
-(NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[[self class] sharedCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}
//计算这个月最后的一天
-(NSDate *)lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[[self class] sharedCalendar] components:calendarUnit fromDate:self];
    [dateComponents setDay:[self numberOfDaysInCurrentMonth]];
    return [[[self class] sharedCalendar] dateFromComponents:dateComponents];
}


/*计算这个月的第一天是礼拜几*/
-(NSUInteger)weeklyOrdinality
{
    return [[[self class] sharedCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
}

/*获取这个月有多少周*/
- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

//上一个月
- (NSDate *)dayInThePreviousMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[[self class] sharedCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

//下一个月
- (NSDate *)dayInTheFollowingMonth
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[[self class] sharedCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}



#pragma mark -
#pragma mark  日期对比方法
- (NSComparisonResult)CompareDateOnly:(NSDate *)otherDate
{
    NSCalendar *calendar = [NSDate sharedCalendar];
    NSDateComponents *selfComponents = [calendar components:DateComponentsUnit fromDate:self];
    NSDate *selfDateOnly = [calendar dateFromComponents:selfComponents];
    
    NSDateComponents *otherCompents = [calendar components:DateComponentsUnit fromDate:otherDate];
    NSDate *otherDateOnly = [calendar dateFromComponents:otherCompents];
    return [selfDateOnly compare:otherDateOnly];
}

- (NSComparisonResult)CompareMonthOnly:(NSDate *)otherDate
{
    NSCalendar *calendar = [NSDate sharedCalendar];
    NSDateComponents *selfComponents = [calendar components:MonthComponentsUnit fromDate:self];
    NSDate *selfMonthOnly = [calendar dateFromComponents:selfComponents];
    
    NSDateComponents *otherCompents = [calendar components:MonthComponentsUnit fromDate:otherDate];
    NSDate *otherMonthOnly = [calendar dateFromComponents:otherCompents];
    return [selfMonthOnly compare:otherMonthOnly];
}


#pragma mark - 农历日期
//农历节日
- (NSString *)lunarHoliday
{
    if ([self chinese_month]==1 && [self chinese_day] == 1) {
        return @"春节";
    }else if ([self chinese_month]==1 && [self chinese_day] == 15) {
        return @"元宵节";
    }else if ([self chinese_month]==5 && [self chinese_day] == 5){
        return @"端午节";
    }else if ([self chinese_month]==7 && [self chinese_day] == 7){
        return @"七夕";
    }else if ([self chinese_month]==7 && [self chinese_day] == 15){
        return @"中元节";
    }else if ([self chinese_month]==8 && [self chinese_day] == 15){
        return @"中秋节";
    }else if ([self chinese_month]==9 && [self chinese_day] == 9){
        return @"重阳节";
    }else if ([self chinese_month]==12 && [self chinese_day]== 8){
        return @"腊八节";
    }else if ([self chinese_month]==12 && [self chinese_day]==23){
        return @"北方小年";
    }else if ([self chinese_month]==12 && [self chinese_day]==24){
        return @"南方小年";
    }else if ([self chinese_month]==12){
        if ([self isEve] == YES) {
            return @"除夕";
        }
    }
    return @"";
}
//是否是除夕
- (BOOL)isEve{
    
    NSDate *nextDay_date = [NSDate dateWithTimeInterval:60*60*24 sinceDate:self];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nextDay_date];
    
    if ( 1 == localeComp.month && 1 == localeComp.day ) {
        return YES;
    }
    return NO;
}
//公历节日
-(NSString *)gregorianHoliday
{
    if (self.month == 1 && self.day ==1) {
        return @"元旦";
    }else if (self.month == 2 && self.day == 14){
        return @"情人节";
    }else if (self.month == 3 && self.day == 8){
        return @"妇女节";
    }else if (self.month == 3 && self.day == 12){
        return @"植树节";
    }else if (self.month == 4 && self.day ==1){
        return @"愚人节";
    }else if (self.month == 4 && self.day== 4){
        return @"清明节";
    }else if (self.month == 5 && self.day== 1){
        return @"劳动节";
    }else if (self.month ==5 && self.day== 4){
        return @"青年节";
    }else if ((self.month ==5 && self.day==8) ||(self.month ==5 && self.day==9)||(self.month ==5 && self.day==10)||(self.month ==5 && self.day==11)||(self.month ==5 && self.day==12)||(self.month ==5 && self.day==13)||(self.month ==5 && self.day==14)){
        if(self.weekday == 1)
        {
            return @"母亲节";
        }
        
    }else if (self.month ==6 && self.day==1){
        return @"儿童节";
    }else if ((self.month ==6 && self.day==15) || (self.month ==6 && self.day==16) || (self.month ==6 && self.day==17) ||(self.month ==6 && self.day==18)|| (self.month ==6 && self.day==19)||(self.month ==6 && self.day==20)||(self.month ==6 && self.day==21)){
        if (self.weekday == 1) {
            return @"父亲节";
        }
    }else if (self.month ==7 && self.day==1){
        return @"建党节";
    }else if (self.month ==8 && self.day==1){
        return @"建军节";
    }else if (self.month ==9 && self.day==10){
        return @"教师节";
    }else if (self.month ==10 && self.day==1){
        return @"国庆节";
    }else if (self.month == 10 && self.day==31){
        return @"万圣节";
    }else if (self.month ==11 && self.day==11){
        return @"光棍节";
    }else if ((self.month ==11 && self.day==24) || (self.month ==11 && self.day==25) || (self.month ==11 && self.day==26) ||(self.month ==11 && self.day==27) || (self.month ==11 && self.day==28) || (self.month ==11 && self.day==29) || (self.month ==11 && self.day==30)){
        if (self.weekday == 5) {
            return @"感恩节";
        }
    }else if (self.month ==12 && self.day==24){
        return @"平安夜";
    }else if (self.month == 12 && self.day==25){
        return @"圣诞节";
    }
    return @"";
}
- (NSInteger) chinese_month
{
    NSCalendar *chinese_cal = [[self class] sharedInstanceCalendarForChinese];
    [chinese_cal setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay |\
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [chinese_cal components:unitFlags fromDate:self];
    
    return comps.month;
}

- (NSInteger) chinese_day
{
    NSCalendar *chinese_cal = [[self class] sharedInstanceCalendarForChinese];
    [chinese_cal setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay |\
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [chinese_cal components:unitFlags fromDate:self];
    
    return comps.day;
}

- (NSString*) ChineseYear
{
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子",   @"乙丑",  @"丙寅",  @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑",  @"戊寅",  @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    NSCalendar *localeCalendar = [[self class] sharedInstanceCalendarForChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay |\
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    
    NSString *year = [chineseYears objectAtIndex:localeComp.year-1];
    
    return year;
}
- (NSString*) ChineseMonth
{
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    NSCalendar *localeCalendar = [[self class] sharedInstanceCalendarForChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay |\
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    NSString *month = [chineseMonths objectAtIndex:localeComp.month-1];
    
    return month;
}
- (NSString*) ChineseDay
{
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[self class] sharedInstanceCalendarForChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay |\
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    NSString *day = [chineseDays objectAtIndex:localeComp.day-1];
    
//    if ([day isEqualToString:@"初一"]) {
//        if (localeComp.leapMonth == YES) {
//            day= [NSString stringWithFormat:@"闰%@",self.ChineseMonth];
//        }else{
//            day = self.ChineseMonth;
//        }
//        
//    }
    
    return day;
}

/********************** 根据某个日期获取这个月的开始或结束的日期 *******************************/
+ (NSDate *)startDateOfCalendarDate:(NSDate *)date
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Calculate the number of days at preious month.
    NSDateComponents *dateComponents = [calendar components:DateComponentsUnit fromDate:date];
    [dateComponents setDay:1];
    NSDate *firstDateOfMonth = [calendar dateFromComponents:dateComponents];
    dateComponents = [calendar components:DateComponentsUnit fromDate:firstDateOfMonth];
    NSInteger numberOfDayAtPreiousMonth = ([dateComponents weekday] == 1) ? 0 : ([dateComponents weekday] - 1);
    [dateComponents setDay:[dateComponents day] - numberOfDayAtPreiousMonth];
    return [calendar dateFromComponents:dateComponents];
}


+ (NSDate *)endDateOfCalendarDate:(NSDate *)date
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *dateComponents = [calendar components:DateComponentsUnit fromDate:date];
    // Calculate the number of days at next month.
    [dateComponents setMonth:[dateComponents month] + 1];
    [dateComponents setDay:0];
    NSDate *lastDateOfMonth = [calendar dateFromComponents:dateComponents];
    dateComponents = [calendar components:DateComponentsUnit fromDate:lastDateOfMonth];
    NSInteger numberOfDaysAtNextMonth = ([dateComponents weekday] == 7) ? 0 : (7 - [dateComponents weekday]);
    //界面已经修改为固定6行
    numberOfDaysAtNextMonth += 7;
    
    [dateComponents setDay:[dateComponents day] + numberOfDaysAtNextMonth];
    return [calendar dateFromComponents:dateComponents];
}



#pragma mark -
#pragma mark 获取某些日期的间隔
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday
{
    
    NSCalendar *calendar = [[self class] sharedCalendar];//日历控件对象
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    //    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    NSInteger day = [components day];//两个日历之间相差多少月//    NSInteger days = [components day];//两个之间相差几天
    return day;
}

-(NSInteger)getWeekNumberbeforeDay:(NSDate *)beforeDay
{
    NSCalendar *calendar = [[self class] sharedCalendar];//日历控件对象
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfMonth fromDate:self toDate:beforeDay options:0];
    //    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    NSInteger week = [components weekOfYear];//两个日历之间相差多少月//    NSInteger days = [components day];//两个之间相差几天
    return week;
}

-(NSInteger)getMonthNumberbeforeDay:(NSDate *)beforeDay
{
    NSCalendar *calendar = [[self class] sharedCalendar];//日历控件对象
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self toDate:beforeDay options:0];
    //    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    NSInteger month = [components month];//两个日历之间相差多少月//    NSInteger days = [components day];//两个之间相差几天
    return month;
}

-(NSInteger)getMinutesNumberbeforeDay:(NSDate *)beforeDay{
    NSCalendar *calendar = [[self class] sharedCalendar];//日历控件对象
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:beforeDay toDate:self options:0];
    //    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    NSInteger minute = [components minute];//两个日历之间相差多少月//    NSInteger days = [components day];//两个之间相差几天
    return minute;
}

-(NSInteger)getMinutesNumberafterDay:(NSDate *)afterDay{
    NSCalendar *calendar = [[self class] sharedCalendar];//日历控件对象
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:self toDate:afterDay options:0];
    NSInteger minute = [components minute];
    return minute;
}

#pragma mark -
#pragma mark 获取某天的星期不同形式
+(NSString*)dayOfWeek:(NSDate*)date{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond|NSCalendarUnitWeekOfYear;
    comps = [calendar components:unitFlags fromDate:date];
    int week = (int)[comps weekday];
    return [arrWeek objectAtIndex:week-1];
}

+(NSString*)dayOfWeekJX:(NSDate *)date{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond|NSCalendarUnitWeekOfYear;
    comps = [calendar components:unitFlags fromDate:date];
    int week = (int)[comps weekday];
    return [arrWeek objectAtIndex:week-1];
}

//根据日期获取该日期对应星期几英文缩写
+(NSString*)dayOfWeekEnglishAbbr:(NSDate *)date{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"SU",@"MO",@"TU",@"WE",@"TH",@"FR",@"SA", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond|NSCalendarUnitWeekOfYear;
    comps = [calendar components:unitFlags fromDate:date];
    int week = (int)[comps weekday];
    return [arrWeek objectAtIndex:week-1];
}

/*************************************   股市日历用到 END*****************************************************************/
+(BOOL)bissextile:(NSInteger)year {
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
@end
