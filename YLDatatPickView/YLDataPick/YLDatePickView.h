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

@property(nonatomic,weak)id <YLDatePickViewdelegate>delegate;
@property (nonatomic,assign)CGFloat currentimestamp;

+ (instancetype)PickView;

- (NSString *)defaulttime;//默认时间字符串
- (long long)defaultttimestamp;//默认时间戳

@end
