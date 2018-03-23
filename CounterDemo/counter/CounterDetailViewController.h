//
//  CounterDetailViewController.h
//  BKFinancial
//
//  Created by GQ-JK on 2018/3/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "ViewController.h"

@interface CounterDetailViewController : ViewController
@property(nonatomic, assign)int index;

@property(nonatomic, copy)NSString *inviestAmount;
@property(nonatomic, copy)NSString *yearReat;
@property(nonatomic, copy)NSString *Duration;
@property(nonatomic, copy)NSString *DateStr;
@property(nonatomic, strong)NSDate *Date;


@end
