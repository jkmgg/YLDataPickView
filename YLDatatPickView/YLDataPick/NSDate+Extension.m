//
//  NSDate+Extension.m
//  LeBang
//
//  Created by IOS_MAC PRO on 2017/1/4.
//  Copyright © 2017年 qinglin. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 时间是否为昨天的时间

 @param date 比较时间
 @return 是否为昨天时间
 */
+ (BOOL)isYesterday:(NSDate *)date{
    
    // 比较时间差
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:[NSDate date] options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}


/**
 根据时间返回时间字符串

 @param date 要转化的时间
 @param type 时间转化格式
 @return 时间字符串
 */
+ (NSString *)Detailedstringwithdate:(NSDate *)date type:(NSString *)type{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:type];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString * datestr = [formatter stringFromDate:date];
    return datestr;
}

/**
 根据时间戳转换时间字符串
 
 @param Interval 时间戳
 @return 返回的时间字符串
 */
+ (NSString *)DateInterval:(NSTimeInterval )Interval{
    
    return  [self Detailedstringwithdate:[NSDate dateWithTimeIntervalSince1970:Interval] type:@"yyyy-MM-dd  HH:mm"];;
}
/**
 根据时间字符串计算当前时间间隔
 
 @param datestr 时间字符串
 @return 时间间隔
 */
+ (NSInteger)computeage:(NSString *) datestr{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[datestr floatValue]];
    
    NSTimeInterval time =[date timeIntervalSinceDate:[NSDate date]];
    
    return -((NSInteger)time)/(3600*24*365);
}

+(NSString *)timeStr:(long long)timestamp{
    //返回时间格式
    
    
    //currentDate 2015-09-28 16:28:09 +0000
    //msgDate 2015-09-28 10:36:22 +0000
    NSCalendar   *calendar = [NSCalendar currentCalendar];
    //1.获取当前的时间
    NSDate *currentDate = [NSDate date];
    
    // 获取年，月，日
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    
    
    //2.获取消息发送时间
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    // 获取年，月，日
    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYead = components.year;
    CGFloat msgMonth = components.month;
    CGFloat msgDay = components.day;
    
    
    
    //3.判断:
    /*今天：(HH:mm)
     *昨天: (昨天 HH:mm)
     *昨天以前:（2015-09-26 15:27）
     */
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYead
        && currentMonth == msgMonth
        && currentDay == msgDay) {//今天
        dateFmt.dateFormat= @"HH:mm";
    }else if(currentYear == msgYead
             && currentMonth == msgMonth
             && currentDay - 1 == msgDay){//昨天
        dateFmt.dateFormat= @"昨天 HH:mm";
    }else{//昨天以前
        dateFmt.dateFormat= @"yyy-MM-dd HH:mm";
    }
    
    
    return [dateFmt stringFromDate:msgDate];
}


@end
