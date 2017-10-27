//
//  NSDate+LCCalendar.m
//  日历
//
//  Created by 李策 on 16/3/16.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "NSDate+LCCalendar.h"

@implementation NSDate (LCCalendar)
-(NSInteger)numberOfDaysInCurrentMonth{
    return [[NSCalendar currentCalendar]rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}
/**当前月的第一天是星期几**/
- (NSUInteger)weekDayOfFirstDayInCurrentMonth{
    
    return [[NSCalendar currentCalendar]ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:[self firstDayInCurrenMonth]];
}
- (NSDate *)firstDayInCurrenMonth{
    NSDate *startDate = nil;
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    BOOL ok = [[NSCalendar currentCalendar]rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"计算这个月的第一天失败 %@", self);
    startDate = [startDate  dateByAddingTimeInterval: interval];
    return startDate;
}
- (NSDate *)lastDayOfCurrentMonth
{
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysInCurrentMonth];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}
//获取当前日期之后的几个月
- (NSDate *)dayInTheFollowingMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = month;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}
//获取当前日期之后的几个天
- (NSDate *)dayInTheFollowingDay:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = day;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}
//获取当前日期之前的几个月
- (NSDate *)dayInThePrebiousMonth:(int)month
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -month;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}
//获取当前日期之前的某天
- (NSDate *)dayInThePerviousDay:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -day;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSInteger)numberOFWeeksInCurrentMonth{
    NSUInteger weekday = [self weekDayOfFirstDayInCurrentMonth];
    NSInteger days = [self numberOfDaysInCurrentMonth];

    NSUInteger weeks = 0;
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    weeks += days/7;

    weeks += (days%7 > 0) ? 1 : 0;

    return weeks;
}
//周日是“1”，周一是“2”...
-(int)getWeekIntValueWithDate
{
    int weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps= [calendar components:(NSCalendarUnitYear |
                                                   NSCalendarUnitMonth |
                                                   NSCalendarUnitDay |
                                                   NSCalendarUnitWeekday) fromDate:self];
    return weekIntValue = (int)[comps weekday];
}

//获取年月日星期小时对象
- (NSDateComponents *)YMDComponents
{
    return [[NSCalendar currentCalendar] components:
            NSCalendarUnitYear|
            NSCalendarUnitMonth|
            NSCalendarUnitDay|
            NSCalendarUnitWeekday |NSCalendarUnitHour
            fromDate:self];
}


//-----------------------------------------
//
//NSString转NSDate
- (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    /**
     *  获取系统时区的时间
     */
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: destDate];
    
    NSDate *localeDate = [destDate  dateByAddingTimeInterval: interval];
    

    return localeDate;
    
}



//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//日历控件对象
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:today toDate:beforday options:0];
    //    NSDateComponents *components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today toDate:beforday options:0];
    NSInteger day = [components day];//两个日历之间相差多少月//    NSInteger days = [components day];//两个之间相差几天
    return day;
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
    int weekIntValue = [self getWeekIntValueWithDate];
    
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



//通过数字返回星期几
+(NSString *)getWeekStringFromInteger:(int)week
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

#pragma mark - 判断时间段
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}


#pragma mark - 获取某个日期所在年份的天数
+ (NSUInteger)getNumberOfDaysOneYear:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange range = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate: date];
     return range.length;
}

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

@end
