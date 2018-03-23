//
//  CounterView.m
//  BKFinancial
//
//  Created by GQ-JK on 2018/3/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "CounterView.h"
#import "CounterDetailViewController.h"

@interface CounterView()<UITextFieldDelegate>
    
@property(nonatomic,strong)UIView *backView;
    
@property(nonatomic, copy)NSString *dateString;
@property(nonatomic, strong)NSDate *Date;

@end

@implementation CounterView
- (IBAction)StartCount:(UIButton *)sender {
    
    if (!_investAmountText.text.length || !_yearReatText.text.length || !_DurationText.text.length || !_dateString.length) {
        [UD_Window makeToast:@"请正确填写数据!" duration:1.5 Title:nil];
        return;
    }
    
    CounterDetailViewController *detailVC = [[CounterDetailViewController alloc]init];
    detailVC.index = _index;
    detailVC.inviestAmount = _investAmountText.text;
    detailVC.yearReat = _yearReatText.text;
    detailVC.Duration = _DurationText.text;
    detailVC.DateStr = _dateString;
    detailVC.Date = _Date;

    [HeaperClass viewController:self].hidesBottomBarWhenPushed = YES;
    [[HeaperClass viewController:self].navigationController pushViewController:detailVC animated:YES];
    [HeaperClass viewController:self].hidesBottomBarWhenPushed = NO;

    
}

#pragma UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger limitLenght = textField.text.length - range.length + string.length;
    
    
    
    if (textField.tag == 1000 && limitLenght > 11) {
        return NO;
    }
    
    if (textField.tag == 1001 && limitLenght > 11) {
        return NO;
    }
    
    if (textField.tag == 1002 && limitLenght > 11) {
        return NO;
    }
    
    if (textField.tag == 1000 && string.length != 0) {
        NSRange rang = [textField.text rangeOfString:@"."];
        if (rang.location!=NSNotFound) {
            return [HeaperClass inputShouldNumber:string];
        }else {
            return [HeaperClass inputShouldNumOrPoint:string];
        }
    }
    
    if (textField.tag == 1001 && string.length != 0) {
        
        NSRange rang = [textField.text rangeOfString:@"."];
        if (rang.location!=NSNotFound) {
            return [HeaperClass inputShouldNumber:string];
        }else {
            return [HeaperClass inputShouldNumOrPoint:string];
        }    }
    
    if (textField.tag == 1002 && string.length != 0) {
        NSRange rang = [textField.text rangeOfString:@"."];
        if (rang.location!=NSNotFound) {
            return [HeaperClass inputShouldNumber:string];
        }else {
            return [HeaperClass inputShouldNumOrPoint:string];
        }    }
    
    return YES;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    _investAmountText.delegate = self;
    _investAmountText.tag = 1000;
    _yearReatText.delegate = self;
    _yearReatText.tag = 1001;

    _DurationText.delegate = self;
    _DurationText.tag = 1002;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction)];
    [_gestureView addGestureRecognizer:tapGesture];
}

// 选择日期
- (void)tapGestureAction{
    [self endEditing:YES];
    [_backView resignFirstResponder];
    
    _backView = [[UIView alloc]init];
    [_backView setBackgroundColor:[UIColor clearColor]];
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    _backView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event_Cancel:)];
    
    [_backView addGestureRecognizer:tapGesture];
    UIView *pickerBgView = [[UIView alloc]init];
    [pickerBgView setBackgroundColor:[UIColor whiteColor]];
    [_backView addSubview:pickerBgView];
    [pickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_bottom).offset(-250);
        make.right.mas_equalTo(_backView.mas_right);
        make.left.mas_equalTo(_backView.mas_left);
        make.bottom.mas_equalTo(_backView.mas_bottom);
    }];
    
    UILabel *lb_line = [[UILabel alloc]init];
    [lb_line setBackgroundColor:[UIColor blackColor]];
    [pickerBgView addSubview:lb_line];
    [lb_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pickerBgView.mas_top);
        make.left.mas_equalTo(_backView.mas_left);
        make.right.mas_equalTo(_backView.mas_right);
        make.height.mas_equalTo(@1);
    }];
    
    UIButton *bt_Cancel = [[UIButton alloc]init];
    [bt_Cancel.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [bt_Cancel.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [bt_Cancel setTitle:@"取消" forState:UIControlStateNormal];
    [bt_Cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bt_Cancel setBackgroundColor:[UIColor clearColor]];
    [bt_Cancel addTarget:self action:@selector(event_Cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [pickerBgView addSubview:bt_Cancel];
    [bt_Cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb_line.mas_bottom).offset(5);
        make.left.mas_equalTo(pickerBgView.mas_left).offset(8);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton * bt_OK = [[UIButton alloc]init];
    [bt_OK.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [bt_OK.titleLabel setTextAlignment:NSTextAlignmentRight];
    [bt_OK setTitle:@"完成" forState:UIControlStateNormal];
    [bt_OK setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bt_OK setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bt_OK setBackgroundColor:[UIColor clearColor]];
    [bt_OK addTarget:self action:@selector(event_OK:) forControlEvents:UIControlEventTouchUpInside];
    [pickerBgView addSubview:bt_OK];
    
    [bt_OK mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb_line.mas_bottom).offset(5);
        make.right.mas_equalTo(pickerBgView.mas_right).offset(-8);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@30);
    }];
    
    _DatePikerView = [[UIDatePicker alloc]init];
    
    _DatePikerView.datePickerMode = UIDatePickerModeDate;
    NSDate* minDate = [[NSDate alloc] initWithTimeIntervalSinceNow:[[NSDate date] timeIntervalSinceNow]];
    _DatePikerView.minimumDate = minDate;
    NSDate* maxDate = [[NSDate alloc] initWithTimeIntervalSinceNow:[[NSDate date] timeIntervalSince1970]];
    _DatePikerView.maximumDate = maxDate;
    _DatePikerView.date = minDate;
//    NSLog(@"%@---%@", minDate, maxDate);
    [pickerBgView addSubview:_DatePikerView];
    
    [_DatePikerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bt_Cancel.mas_bottom);
        make.right.mas_equalTo(pickerBgView.mas_right);
        make.left.mas_equalTo(pickerBgView.mas_left);
        make.bottom.mas_equalTo(pickerBgView.mas_bottom);
    }];
    
    
    
}

- (void)event_Cancel:(id)sender
{
    [_backView removeFromSuperview];
}

- (void)event_OK:(id)sender
{
    _Date = _DatePikerView.date;
//    NSLog(@"%@---%@----%@", _DatePikerView.date, _DatePikerView.minimumDate, _DatePikerView.maximumDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:_DatePikerView.date];
    _dateString = str;

    _DatedDateLabel.text = [[str substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    _DatedDateLabel.textColor = [UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1];
    if (_backView) {
        [_backView removeFromSuperview];
    }
//    [self submitWithIndex:nil];
    
}

@end
