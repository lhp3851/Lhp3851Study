//
//  DateTool.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/6/14.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject
//转化成系统时间,本地时间为GMT
+ (NSDate *)getLocaleDateFromUTCDate:(NSDate *)date;
//根据时间字符串获取时间
+(NSString *)friendTimeFromString:(NSString *)timeString;
//根据时间戳获取时间
+(NSString *)friendTimeFromStamp:(NSString *)timeStamp;
//根据时间间隔获取时间
+(NSString *)friendTimeFromInterVal:(NSString *)timeInterVal;
@end


@interface DateFormatter : NSDateFormatter
+(void)dateFormatterInfo;

+(NSDateFormatter *)defaultDateFormatter;
@end

@interface TimeZone : NSTimeZone

+(void)timeZoneInfo;//timeZoneInfo

+(NSTimeZone *)defaultTimeZone;
@end

@interface TimeLocale : NSLocale
+(void)timeLocalInfo;

+(NSLocale *)defaultTimeLocal;
@end

@interface Date : NSDate
+(void)dateInfo;

+(NSDate *)curruntDate;
@end

@interface Calendar : NSCalendar
+(void)calendarIfo;

+(NSCalendar *)defaultCalendar;
@end