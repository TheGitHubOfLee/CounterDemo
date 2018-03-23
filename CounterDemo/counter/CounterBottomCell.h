//
//  CounterBottomCell.h
//  BKFinancial
//
//  Created by GQ-JK on 2018/3/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterBottomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *AnticipatedIncome;
@property (strong, nonatomic) IBOutlet UILabel *DateListLabel;
@property (strong, nonatomic) IBOutlet UILabel *AmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *DetailLabel;

@property (strong, nonatomic) IBOutlet UIView *MarkView;

@end
