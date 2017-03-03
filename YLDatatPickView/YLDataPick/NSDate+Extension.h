//
//  NSDate+Extension.h
//  LeBang
//
//  Created by IOS_MAC PRO on 2017/1/4.
//  Copyright © 2017年 qinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 时间是否为昨天的时间
 
 @param date 比较时间
 @return 是否为昨天时间
 */
+ (BOOL)isYesterday:(NSDate *)date;

/**
 根据时间返回时间字符串
 
 @param date 要转化的时间
 @param type 时间转化格式
 @return 时间字符串
 */
+ (NSString *)Detailedstringwithdate:(NSDate *)date type:(NSString *)type;

///**
// 
// *聊天时间戳 转时间
// 
// */
//+(NSString *)timeStr:(long long)timestamp;


/**
 根据时间戳转换时间字符串

 @param Interval 时间戳
 @return 返回的时间字符串
 */
+ (NSString *)DateInterval:(NSTimeInterval )Interval;

/**
 根据时间字符串计算当前时间间隔

 @param datestr 时间字符串
 @return 时间间隔
 */
+ (NSInteger)computeage:(NSString *) datestr;
@end
