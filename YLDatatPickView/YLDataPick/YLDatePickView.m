//
//  LeBangPickView.m
//  LeBangUser
//
//  Created by YL on 16/5/3.
//  Copyright © 2016年 APP. All rights reserved.
//


#define pickerViewHeight 216.0

#import "YLDatePickView.h"
#import "NSDate+Extension.h"

@interface YLDatePickView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSInteger  _oldselectsection;
}
@property(nonatomic,strong)UIPickerView * Pick;
@property(nonatomic,strong)UIView * BgView;
@property (nonatomic,retain)NSMutableArray *firstData,*secondData,*thirdData;
@property (nonatomic,copy)NSString *firstStr,*secondStr,*thirdStr;


@end

@implementation YLDatePickView

- (UIView *)BgView{
    if (_BgView == nil) {
        
        _BgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , self.frame.size.width, 44)];
        _BgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_BgView];
    }
    return _BgView;
}
- (UIPickerView *)Pick{
    
    if (_Pick == nil) {
        _Pick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, pickerViewHeight )];
        _Pick.delegate = self;
        _Pick.dataSource = self;
        _Pick.showsSelectionIndicator=YES;
        _Pick.backgroundColor = [UIColor whiteColor];
        [self addSubview:_Pick];
        [self sendSubviewToBack:_Pick];
    }
    return _Pick;
}

- (NSMutableArray *)secondData{
    if (_secondData == nil) {
        _secondData = [NSMutableArray array];
        for (int i = 0; i<24; i++) {
            [_secondData addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _secondData;
}
- (NSMutableArray *)thirdData{
    if (_thirdData == nil) {
        _thirdData = [NSMutableArray arrayWithObjects:@"00",@"15",@"30",@"45", nil];
    }
    return _thirdData;
}

- (void)setNumberofDays:(NSInteger)NumberofDays{
    
    _NumberofDays = NumberofDays;
    [self.firstData removeAllObjects];
    [self dealFirstDataArray];
}

- (void)setDateType:(ENUM_DateType)dateType{
    
    _dateType = dateType;
    [self.firstData removeAllObjects];
    [self dealFirstDataArray];
}

- (void)dealFirstDataArray{
    
    NSString * DateFormattype = @"yyyy-MM-dd";
    NSMutableArray * dateArray = [NSMutableArray array];
    NSDate * date;
    for (int i = 0; i<self.NumberofDays ; i++) {
        
        if (i == 0) {
            date = [NSDate date];
        }else{
            date = [[NSDate date] initWithTimeIntervalSinceNow:60*60*24*i];
        }
        
        if (self.dateType == ENUM_DateTypeofNoWeake) {
            [dateArray addObject:[NSString stringWithFormat:@"%@",[NSDate Detailedstringwithdate:date type:DateFormattype]]];
        }else if (self.dateType == ENUM_DateTypeofNoYears){
            NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
            NSArray * weekday = @[@"六",@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
            [dateArray addObject:[NSString stringWithFormat:@"星期%@",weekday[comps.weekday%7]]];
        }else{
            NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
            NSArray * weekday = @[@"六",@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
            [dateArray addObject:[NSString stringWithFormat:@"%@ 星期%@",[NSDate Detailedstringwithdate:date type:DateFormattype],weekday[comps.weekday%7]]];
        }
    }
    self.firstData = dateArray;
    [self handleDate:dateArray[0]];
    [self.Pick reloadAllComponents];
}

+ (instancetype)PickView{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    frame = [UIApplication sharedApplication].keyWindow.bounds;
    if (self = [super initWithFrame:frame]) {
        
        [self initbgView];
        if (self.NumberofDays == 0) {
            self.NumberofDays = 3;
        }
    }
    return self;
}
- (void)initbgView{
    
    UILabel * linelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, 0.4)];
    linelab.backgroundColor = [UIColor lightGrayColor];
    [self.BgView addSubview:linelab];
    
    for (int i = 0 ; i<2; i++) {
        
        UIButton * btn = [[UIButton alloc]init];
        btn.tag = i;
        
        if (i == 0) {
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(13, 0, 44, 44);
            
        }else{
            [btn setTitle:@"确认" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(self.frame.size.width - 13 - 44, 0, 44, 44);
            
        }
        
        [btn addTarget:self action:@selector(PickViewbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.BgView addSubview:btn];
    }
    UILabel * titlelab = [[UILabel alloc]init];
    titlelab.text = @"请选择时间";
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.frame = CGRectMake(0, 0, self.BgView.frame.size.width, self.BgView.frame.size.height);
    [self.BgView addSubview:titlelab];
}


# pragma mark - pickview 代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.dateType == ENUM_DateTypeofNoHours) {
        return 1;
    }else  if (self.dateType == ENUM_DateTypeofNoYears) {
        return 2;
    }else{
        return 3;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        return [self.firstData count];
    }else if (component==1){
        return [self.secondData count];
    }else{
        return [self.thirdData count];
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    if (component == 0) {
        if (self.dateType == ENUM_DateTypeofNoWeake) {
            return 180;
        }else{
            return 220;
        }
    }
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0) {
        return [self.firstData objectAtIndex:row];
    }else if (component==1){
        return [self.secondData objectAtIndex:row];
    }else{
        return [self.thirdData objectAtIndex:row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            self.firstStr = self.firstData[row];
            
            [self handleDate:self.firstData[row]];
            if (row == 0) {
                
                self.thirdData = [NSMutableArray arrayWithObjects:@"00",@"15",@"30",@"45", nil];
            }
            
            [self.Pick selectRow:0 inComponent:1 animated:YES];
            
            [self.Pick selectRow:0 inComponent:2 animated:YES];
            
        }
            break;
        case 1:
        {
            self.secondStr = self.secondData[row];
            if (self.firstStr != nil){
                
                if ([self.firstStr isEqualToString:self.firstData[0]]) {
                    
                    if (row == 0) {
                        [self handleDate:self.firstData[0]];
                    }else{
                        self.thirdData = [NSMutableArray arrayWithObjects:@"00",@"15",@"30",@"45", nil];
                    }
                    
                }else{
                    
                    self.thirdData = [NSMutableArray arrayWithObjects:@"00",@"15",@"30",@"45", nil];
                }
                
            }else{
                
                if (row == 0) {
                    [self handleDate:self.firstData[0]];
                }else{
                    self.thirdData = [NSMutableArray arrayWithObjects:@"00",@"15",@"30",@"45", nil];
                }
                
            }
            [self.Pick reloadComponent:2];
            
            [self.Pick selectRow:0 inComponent:2 animated:YES];
            
        }
            break;
        case 2:
        {
            self.thirdStr = self.thirdData[row];
        }
            break;
        default:
            break;
    }
    
}

- (void)handleDate:(NSString*)firstdate{
    
    if ([firstdate isEqualToString:self.firstData[0]]) {
        
        
        NSString * dataste = [NSDate Detailedstringwithdate:[NSDate date] type:@"HH:mm"];
        int nowF = [[[dataste componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
        int nowH = [[[dataste componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
        
        NSMutableArray * thitarray = [NSMutableArray arrayWithObjects:@"00",@"15",@"30",@"45", nil];
        if (nowH  == 23) {
            
            if (nowF >45) {
                [self.firstData removeObjectAtIndex:0];
                _secondData = [NSMutableArray array];
                for (int i = 0; i<24; i++) {
                    [_secondData addObject:[NSString stringWithFormat:@"%d",i]];
                }
                _thirdData = thitarray;
                [self.Pick reloadAllComponents];
            }
        }
        NSMutableArray * secondarray = [NSMutableArray array];
        
        for (int i = 0; i<24; i++) {
            [secondarray addObject:[NSString stringWithFormat:@"%d",i]];
            if (i< nowH) {
                [secondarray removeObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        
        if (nowF+15>45) {
            [secondarray removeObjectAtIndex:0];
            
            if (nowF+15>60) {
                [self.thirdData removeObjectAtIndex:0];
            }
        }else{
            
            for (NSString * str in thitarray) {
                if ([str intValue] < nowF+15) {
                    [self.thirdData removeObject:str];
                }
            }
            
        }
        
        self.secondData = secondarray;
        
    }else{
        NSMutableArray * secondarray = [NSMutableArray array];
        
        for (int i = 0; i<24; i++) {
            [secondarray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        self.secondData = secondarray;
        
        self.thirdData = [NSMutableArray arrayWithObjects:@"00",@"15",@"30",@"45", nil];
    }
    [self.Pick reloadAllComponents];
    self.secondStr = self.secondData[0];
}

# pragma mark - 点击确定
- (void)PickViewbtnclick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectbutton:Datestr:)]) {
        
        if (self.firstStr==nil) {
            self.firstStr = self.firstData[0];
        }
        if (self.secondStr==nil) {
            self.secondStr = self.secondData[0];
        }
        if (self.thirdStr==nil) {
            self.thirdStr = self.thirdData[0];
        }
        
        NSString * selectdatestr;
        
        if (self.dateType == ENUM_DateTypeofNoHours) {
            selectdatestr = [NSString stringWithFormat:@"%@",self.firstStr];
        }else{
            selectdatestr = [NSString stringWithFormat:@"%@ %@:%@",self.firstStr,self.secondStr,self.thirdStr];
        }
        
        //NSString转NSDate
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString * datestr = [NSString stringWithFormat:@"%@ %@:%@",self.firstStr,self.secondStr,self.thirdStr];
        NSString * detalstr = [NSString stringWithFormat:@"%@ %@",[datestr componentsSeparatedByString:@" "][0],[datestr componentsSeparatedByString:@" "][2]];
        NSDate *date = [formatter dateFromString:detalstr];
        self.currentimestamp =  [date timeIntervalSince1970];

        [self.delegate pickerView:self didSelectbutton:btn.tag Datestr:selectdatestr];
    }
}


- (NSString *)timestrfoDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:date]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    NSString * datastr = [NSString stringWithFormat:@"%ld-%ld-%ld 00:00",(long)currentYear,(long)currentMonth,(long)currentDay];
    
    return datastr;
}

- (long long)Dateofdatestr:(NSString *)datestr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate * date = [formatter dateFromString:datestr];
    return [date timeIntervalSince1970];
    
}

/**
 根据时间戳返回格式字符串
 
 @param timestamp 时间戳
 @return 格式字符串
 */
- (NSString *)timeStr:(long long)timestamp{
    //返回时间格式
    
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
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    if (currentYear == msgYead
        && currentMonth == msgMonth
        && currentDay == msgDay) {//今天
        dateFmt.dateFormat= @"MM月dd HH:mm";
    }else if(currentYear == msgYead
             && currentMonth == msgMonth
             && currentDay + 1 == msgDay){//明天
        dateFmt.dateFormat= @"MM月dd HH:mm";
    }else{//后天以前
        dateFmt.dateFormat= @"MM月dd HH:mm";
    }
    return [dateFmt stringFromDate:msgDate];
}


@end
