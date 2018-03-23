//
//  CounterTopCell.h
//  BKFinancial
//
//  Created by GQ-JK on 2018/3/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterTopCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *investAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearReatLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
