//
//  ViewController.m
//  YLDatatPickView
//
//  Created by IOS_MAC PRO on 2017/3/3.
//  Copyright © 2017年 com.ASS. All rights reserved.
//

#import "ViewController.h"
#import "YLDatePickView.h"

@interface ViewController ()<UITextFieldDelegate,YLDatePickViewdelegate>

@property(nonatomic,strong)YLDatePickView * datePickView;//时间选择器
@property(nonatomic,weak)UITextField * textField;

@end

@implementation ViewController
- (YLDatePickView *)datePickView{
    
    if (_datePickView == nil) {
        _datePickView = [YLDatePickView PickView];
        _datePickView.delegate = self;
        _datePickView.frame = CGRectMake(0, 0, self.view.frame.size.width, 216);
    }
    return _datePickView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UITextField * textf = [[UITextField alloc]initWithFrame:CGRectMake(20, 150, self.view.frame.size.width - 40, 44)];
    textf.delegate = self;
    textf.placeholder = @"点击选择时间";
    textf.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textf];
    self.textField = textf;
}

#pragma mark -  监听textfienld delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.inputView = self.datePickView;
    return YES;
}

- (void)pickerView:(YLDatePickView *)pickerView didSelectbutton:(NSInteger )btntag Datestr:(NSString *)str{
    
    if (btntag == 1) {
        
        self.textField.text = str;
        NSLog(@"当前选中的的时间戳------%f",self.datePickView.currentimestamp);
    }
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
