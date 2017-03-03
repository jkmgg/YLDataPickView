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
 根据时间返回时间字符串
 
 @param date 要转化的时间
 @param type 时间转化格式
 @return 时间字符串
 */
+ (NSString *)Detailedstringwithdate:(NSDate *)date type:(NSString *)type;

@end
