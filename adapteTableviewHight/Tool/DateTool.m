//
//  DateTool.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/6/14.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool
//转化成系统时间,本地时间为GMT
+ (NSDate *)getLocaleDateFromUTCDate:(NSDate *)date
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [TimeZone defaultTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    return  destinationDateNow;
}

//根据时间字符串获取时间
+(NSString *)friendTimeFromString:(NSString *)timeString{
    return nil;
}
//根据时间戳获取时间
+(NSString *)friendTimeFromStamp:(NSString *)timeStamp{
    return nil;
}
//根据时间间隔获取时间
+(NSString *)friendTimeFromInterVal:(NSString *)timeInterVal{
    return nil;
}

@end

#pragma mark DefaultDateFormatter
@implementation DateFormatter
+(void)dateFormatterInfo{
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate *date = [NSDate date];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"Formatted date string for locale :%@, %@", [[dateFormatter locale] localeIdentifier], formattedDateString);
    //en_US, June 14, 2016<--NSDateFormatterBehavior10_4|NSDateFormatterBehaviorDefault
    //NSDateFormatterBehaviorDefault (TARGET_OS_MAC && !(TARGET_OS_EMBEDDED || TARGET_OS_IPHONE))
}


+(NSDateFormatter *)defaultDateFormatter{
    if (self) {
        //NSDateFormatterNoStyle     = kCFDateFormatterNoStyle,
        //NSDateFormatterShortStyle  = kCFDateFormatterShortStyle,//“11/23/37” or “3:30pm”
        //NSDateFormatterMediumStyle = kCFDateFormatterMediumStyle,//"Nov 23, 1937"
        //NSDateFormatterLongStyle   = kCFDateFormatterLongStyle,//"November 23, 1937” or “3:30:32pm"
        //NSDateFormatterFullStyle   = kCFDateFormatterFullStyle//“Tuesday, April 12, 1952 AD” or “3:30:42pm PST”
        NSDateFormatter *dateFormatter=[NSDateFormatter new];
        dateFormatter.locale    =[TimeLocale defaultTimeLocal];
        dateFormatter.timeZone  =[TimeZone defaultTimeZone];
        dateFormatter.calendar  =[Calendar defaultCalendar];
        dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss z EEEE";
        return dateFormatter;
    }
    return nil;
}
@end

@implementation TimeZone
+(void)timeZoneInfo{
    NSLog(@"当前iOS系统已知的时区名称：%@",[NSTimeZone knownTimeZoneNames]);
    
    NSLog(@"abbreviationDictionary:%@",[NSTimeZone abbreviationDictionary]);
    
    NSLog(@"systemTimeZone:%@",[NSTimeZone systemTimeZone]);
    
    NSLog(@"defaultTimeZone:%@",[NSTimeZone defaultTimeZone]);
    
    NSLog(@"localTimeZone:%@",[NSTimeZone localTimeZone]);
    
    NSLog(@"timeZoneDataVersion:%@",[NSTimeZone timeZoneDataVersion]);
    
    NSLog(@"systemTimeZone secondsFromGMT:%ld and daylightSavingTimeOffset:%f",[NSTimeZone systemTimeZone].secondsFromGMT,[NSTimeZone systemTimeZone].daylightSavingTimeOffset);
    
    NSLog(@"systemTimeZone daylightSavingTime:%d",[NSTimeZone systemTimeZone].daylightSavingTime);
    
    NSLog(@"systemTimeZone description:%@",[NSTimeZone systemTimeZone].description);
    
    NSLog(@"systemTimeZone data and name:%@,%@",[NSTimeZone systemTimeZone].data,[NSTimeZone systemTimeZone].name);
}

+(NSTimeZone *)defaultTimeZone{
    return [NSTimeZone systemTimeZone];
}
@end

@implementation TimeLocale
+(void)timeLocalInfo{
    NSLocale *currentLoacle=[NSLocale currentLocale];
    NSLog(@"currentLocale:%@",currentLoacle);
    
    NSLog(@"autoupdatingCurrentLocale:%@",[NSLocale autoupdatingCurrentLocale]);
    
    NSLog(@"systemLocale:%@",[NSLocale systemLocale]);
    
    NSLog(@"systemLocale localeIdentifier:%@",[NSLocale systemLocale].localeIdentifier);
    
    NSLog(@"availableLocaleIdentifiers:%@",[NSLocale availableLocaleIdentifiers]);
    
    NSLog(@"ISOLanguageCodes:%@",[NSLocale ISOLanguageCodes]);
    
    NSLog(@"ISOCountryCodes:%@",[NSLocale ISOCountryCodes]);
    
    NSLog(@"ISOCurrencyCodes:%@",[NSLocale ISOCurrencyCodes]);
    
    NSLog(@"commonISOCurrencyCodes:%@",[NSLocale commonISOCurrencyCodes]);
    
    NSLog(@"local preferredLanguages:%@  and preferredLocalizations:%@ localizedInfoDictionary:%@",[NSLocale preferredLanguages],[[NSBundle mainBundle] preferredLocalizations],[[NSBundle mainBundle] localizedInfoDictionary]);
    
    NSLog(@"NSLocale:description:%@",[NSLocale description]);
    
}

+(NSLocale *)defaultTimeLocal{
    return [NSLocale autoupdatingCurrentLocale];//实时更新的
}
@end

@implementation Date

+(void)dateInfo{
    NSDate *currentDate=[self curruntDate];
    NSLog(@"date timeIntervalSinceNow:%f",currentDate.timeIntervalSinceNow);

    NSLog(@"date timeIntervalSinceReferenceDate:%f",currentDate.timeIntervalSinceReferenceDate);

    NSLog(@"date timeIntervalSince1970:%f",currentDate.timeIntervalSince1970);
    
    NSLog(@"date description:%@",currentDate.description);
    
    NSLog(@"date distantPast:%@",[NSDate distantPast]);

    NSLog(@"date distantPast:%@",[NSDate distantFuture]);
}

+(NSDate *)curruntDate{
    return  [NSDate date];
}

@end


@implementation Calendar
+(void)calendarIfo{
    NSCalendar *defaultCalendar=[self defaultCalendar];
    NSLog(@"currentCalendar:%@",[NSCalendar currentCalendar]);
    
    NSLog(@"autoupdatingCurrentCalendar:%@",[NSCalendar autoupdatingCurrentCalendar]);
    
    NSLog(@"calendar Identifier:%@",defaultCalendar.calendarIdentifier);
    
    NSLog(@"calendar locale:%@",defaultCalendar.locale);
    
    NSLog(@"calendar timeZone:%@",defaultCalendar.timeZone);
    
    NSLog(@"calendar firstWeekday:%lui",(unsigned long)defaultCalendar.firstWeekday);
    
    NSLog(@"calendar minimumDaysInFirstWeek:%lui",(unsigned long)defaultCalendar.minimumDaysInFirstWeek);
    
    NSLog(@"calendar eraSymbols：%@,calendar longEraSymbols：%@",defaultCalendar.eraSymbols,defaultCalendar.longEraSymbols);
    
    NSLog(@"calendar monthSymbols:%@\n,calendar shortMonthSymbols:%@\n,calendar veryShortMonthSymbols:%@\n,calendar standaloneMonthSymbols:%@\n,calendar shortStandaloneMonthSymbols:%@\n,calendar veryShortStandaloneMonthSymbols:%@",defaultCalendar.monthSymbols,defaultCalendar.shortMonthSymbols,defaultCalendar.veryShortMonthSymbols,defaultCalendar.standaloneMonthSymbols,defaultCalendar.shortStandaloneMonthSymbols,defaultCalendar.veryShortStandaloneMonthSymbols);

    NSLog(@"calendar weekdaySymbols:%@",defaultCalendar.weekdaySymbols);
    
    NSLog(@"calendar quarterSymbols:%@",defaultCalendar.quarterSymbols);
    
    NSLog(@"calendar PMSymbol:%@",defaultCalendar.PMSymbol);
    
    NSLog(@"calendar AMSymbol:%@",defaultCalendar.AMSymbol);
    
}

+(NSCalendar *)defaultCalendar{
    return [NSCalendar autoupdatingCurrentCalendar];
}

@end

