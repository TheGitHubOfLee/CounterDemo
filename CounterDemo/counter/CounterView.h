//
//  CounterView.h
//  BKFinancial
//
//  Created by GQ-JK on 2018/3/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterView : UIView

@property(nonatomic, assign)int index;
@property (strong, nonatomic) IBOutlet UITextField *investAmountText;
@property (strong, nonatomic) IBOutlet UITextField *yearReatText;
@property (strong, nonatomic) IBOutlet UITextField *DurationText;
@property (strong, nonatomic) IBOutlet UIView *gestureView;
//@property (nonatomic, copy)void (^selectDateBlock)(void);
@property (strong, nonatomic) IBOutlet UILabel *DatedDateLabel;
@property(nonatomic,strong)UIDatePicker*DatePikerView;
//@property(nonatomic, assign)int index;
@end
