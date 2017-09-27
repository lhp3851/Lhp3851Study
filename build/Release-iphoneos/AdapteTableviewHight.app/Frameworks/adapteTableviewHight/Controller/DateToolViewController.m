//
//  DateToolViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/6/14.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "DateToolViewController.h"

@implementation DateToolViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setThePannel];
    [self dateInfo];
    [self outputCurrentTime];
}

-(void)setThePannel{
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)dateInfo{
    [TimeZone timeZoneInfo];//时区信息
    [TimeLocale timeLocalInfo];//本地信息
    [DateFormatter dateFormatterInfo];//格式信息
    [Calendar calendarIfo];//日历信息
    [Date dateInfo];//日期信息
}

-(void)outputCurrentTime{
    NSCalendar *currentCalendar=[Calendar defaultCalendar];
    NSDate *currentDate=[Date curruntDate];
    //日期成员
    NSDateComponents *calendarComponents=[currentCalendar components:(NSCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay|NSCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekOfYear| NSCalendarUnitQuarter|NSCalendarUnitYearForWeekOfYear|NSCalendarUnitNanosecond|NSCalendarUnitCalendar|NSCalendarUnitTimeZone) fromDate:currentDate];
    NSString *componnentString=[NSString stringWithFormat:@"year:%ld,\nmonth:%ld,\nday:%ld,\nhour:%ld,\nminute:%ld,\nsecond:%ld,\nWeekday:%ld,\nWeekdayOrdinal:%ld,\nWeekOfMonth:%ld,\nWeekOfYear:%ld,\nQuarter:%ld,\nYearForWeekOfYear:%ld",(long)calendarComponents.year,calendarComponents.month,calendarComponents.day,calendarComponents.hour,calendarComponents.minute,calendarComponents.second,calendarComponents.weekday,calendarComponents.weekdayOrdinal,calendarComponents.weekOfMonth,calendarComponents.weekOfYear,calendarComponents.quarter,calendarComponents.yearForWeekOfYear];
    NSLog(@"componnentString:%@",componnentString);
    
    NSDateFormatter *defaultDateFormatter=[DateFormatter defaultDateFormatter];
    NSString *currentTimeString=[defaultDateFormatter stringFromDate:currentDate];
    self.timeLabel.text=[NSString stringWithFormat:@"%@\n%@",currentTimeString,componnentString];
}



-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
