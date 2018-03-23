//
//  CounterDetailViewController.m
//  BKFinancial
//
//  Created by GQ-JK on 2018/3/22.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "CounterDetailViewController.h"
#import "CounterBottomCell.h"
#import "CounterTopCell.h"

@interface CounterDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *titleArray;
@property(nonatomic, strong)NSMutableArray *detailArray;

@end

@implementation CounterDetailViewController

- (NSMutableArray *)detailArray {
    if (!_detailArray) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSMutableArray arrayWithArray:@[@"等额本息",@"等本等息",@"按月付息、到期还本",@"到期还本付息",@"等额本金"]];
    [self startCounter];
    self.title = @"计算器";
    
    
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}

- (void)startCounter{
    double HasalsoAmount = 0.0;

    switch (_index) {
        case 0:
            for (int i = 0; i < [_Duration intValue]; i++) {
                [self.detailArray addObjectsFromArray:[HeaperClass calculatePrincipalAndInterestBidByEachMouthWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount bid:[_Duration doubleValue] Hasalso:HasalsoAmount]];
                HasalsoAmount += [self.detailArray[2 + i * 3] doubleValue];
                
            }
            break;
        case 1:
            
            for (int i = 0; i < [_Duration intValue]; i++) {
                [self.detailArray addObjectsFromArray:[HeaperClass PayInterestPrincipalEachMouthAndInterestBidWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount AndMonth:[_Duration doubleValue]]];
                
            }
            break;
        case 2:
            
            for (int i = 0; i < [_Duration intValue]; i++) {
                [self.detailArray addObjectsFromArray:[HeaperClass PayInterestPrincipal1EachMouthAndInterestBidWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount AndMonth:[_Duration doubleValue] isLast:i == [_Duration intValue] - 1 ? YES : NO]];
            }
            break;
        case 3:
            
            for (int i = 0; i < [_Duration intValue]; i++) {
                [self.detailArray addObjectsFromArray:[HeaperClass PayInterestPrincipal2EachMouthAndInterestBidWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount AndMonth:[_Duration doubleValue] isLast:i == [_Duration intValue] - 1 ? YES : NO]];
                                                       
            }
            break;
        case 4:
            
            for (int i = 0; i < [_Duration intValue]; i++) {
                [self.detailArray addObjectsFromArray:[HeaperClass PrinciplePrincipal1AndInterestBidWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount AndMonth:[_Duration doubleValue] Hasalso:HasalsoAmount]];
                                                       
                    HasalsoAmount += [self.detailArray[2 + i * 3] doubleValue];

            }
            break;
        default:
            
            
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (!indexPath.section) {
        CounterTopCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CounterTopCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CounterTopCell class]) owner:self options:nil] objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLabel.text = _titleArray[_index];
        cell.investAmountLabel.text = [NSString stringWithFormat:@"%@元", _inviestAmount];
        cell.durationLabel.text = [NSString stringWithFormat:@"%@个月", _Duration];
        cell.yearReatLabel.text = [NSString stringWithFormat:@"%@%%", _yearReat];
        cell.dateLabel.text = [[_DateStr substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        return cell;
        
    }{
        if (!indexPath.row) {
            CounterBottomCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CounterBottomCell1"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CounterBottomCell class]) owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            switch (_index) {
                case 0:
                    cell.AnticipatedIncome.text = [NSString stringWithFormat:@"%.2f",[HeaperClass calculatePrincipalAndInterestBidWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount bid:[_Duration doubleValue]]];

                    break;
                case 1:
                    cell.AnticipatedIncome.text = [NSString stringWithFormat:@"%.2f",[HeaperClass PrinciplePrincipalAndInterestBidWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount AndMonth:[_Duration doubleValue]]];
                                                                                      

                    break;
                default:
                    cell.AnticipatedIncome.text = [NSString stringWithFormat:@"%.2f",[HeaperClass PayInterestPrincipalAndInterestBidWithInvestInterest:[_yearReat doubleValue] amount:_inviestAmount AndMonth:[_Duration doubleValue]]];

                    break;
            }
            return cell;
        }else{
            CounterBottomCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CounterBottomCell2"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CounterBottomCell class]) owner:self options:nil] objectAtIndex:1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            //设置时间格式
            NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

            NSString *timeStr=[formatter stringFromDate:[HeaperClass getPriousorLaterDateFromDate:_Date withMonth:indexPath.row]];
            cell.DateListLabel.text = [[timeStr substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"."];
            cell.AmountLabel.text = [NSString stringWithFormat:@"%.2f", [_detailArray[3*(indexPath.row - 1)] doubleValue]];
            cell.DetailLabel.text = [NSString stringWithFormat:@"含本金 %.2f + 利息 %.2f", [_detailArray[2 + 3*(indexPath.row - 1)] doubleValue], [_detailArray[1 + 3*(indexPath.row - 1)] doubleValue]];
            if (indexPath.row == [_Duration intValue]) {
                cell.MarkView.hidden = YES;
            }
            return cell;
        }
        
    }
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 1 + [_Duration intValue] : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section ? 0.0001 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    footer.backgroundColor = BK_BG_COLOR;
    return section ? nil :footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section) {
        return 240;
    }else if(!indexPath.row){
        return 135;
    }else{
        return 60;
    }
}

@end
