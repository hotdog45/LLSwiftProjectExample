//
//  NSDate+LCCalendar.h
//  日历
//
//  Created by 李策 on 16/3/16.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCCalendar)
/**
 *  获取某个日期所在年份的天数
 */
+ (NSUInteger)getNumberOfDaysOneYear:(NSDate *)date;
/**当前月的天数**/
- (NSInteger)numberOfDaysInCurrentMonth;
/**当前月有几个星期**/
- (NSInteger)numberOFWeeksInCurrentMonth;
/**当前月的第一天**/
- (NSDate *)firstDayInCurrenMonth;
/**当前月的最后一天**/
- (NSDate *)lastDayOfCurrentMonth;
/**当前月的第一天是星期几**/
- (NSUInteger)weekDayOfFirstDayInCurrentMonth;
/**计算某天是星期几**/
-(int)getWeekIntValueWithDate;
/**计算当前日期的之后几个月**/
- (NSDate *)dayInTheFollowingMonth:(int)month;
/**计算当前日期的之后几天**/
- (NSDate *)dayInTheFollowingDay:(int)day;
/**计算当前日期的之前几个月**/
- (NSDate *)dayInThePrebiousMonth:(int)month;
/**计算当前日期的之前几个天**/
- (NSDate *)dayInThePerviousDay:(int)day;
//获取年月日对象
- (NSDateComponents *)YMDComponents;
//NSString转NSDate
- (NSDate *)dateFromString:(NSString *)dateString;
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;
/**判断日期是今天,明天,后天,周几**/
-(NSString *)compareIfTodayWithDate;
/**判断时间段**/
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
