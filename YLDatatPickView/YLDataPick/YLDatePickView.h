//
//  LeBangPickView.h
//  LeBangUser
//
//  Created by YL on 16/5/3.
//  Copyright © 2016年 APP. All rights reserved.
//



#import <UIKit/UIKit.h>
@class YLDatePickView;

@protocol YLDatePickViewdelegate<NSObject>


/**
 DataPick 的代理事件

 @param pickerView 当前的DataPickView
 @param btntag 按钮的索引 0 取消。1确认
 @param str 返回的选择的格式时间字符串
 */
- (void)pickerView:(YLDatePickView *)pickerView didSelectbutton:(NSInteger )btntag Datestr:(NSString *)str;
@end



@interface YLDatePickView : UIView

typedef NS_ENUM(NSInteger,ENUM_DateType){
    ENUM_DateTypeofNormal, // 默认都显示
    ENUM_DateTypeofNoWeake, // 不显示星期
    ENUM_DateTypeofNoHours, // 不显示时分秒
    ENUM_DateTypeofNoYears, // 不显示年月日
};

@property(nonatomic,weak)id <YLDatePickViewdelegate>delegate;

/**
 从当前时间选择几天时间
 */
@property (nonatomic,assign)NSInteger NumberofDays;
/**
 显示时间的样式
 */
@property (nonatomic,assign)ENUM_DateType dateType;

/**
 当前选择的时间戳
 */
@property (nonatomic,assign)CGFloat currentimestamp;

+ (instancetype)PickView;

@end
