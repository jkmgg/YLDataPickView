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




@end
