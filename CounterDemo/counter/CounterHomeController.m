//
//  CounterHomeController.m
//  BKFinancial
//
//  Created by GQ-JK on 2018/3/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "CounterHomeController.h"
#import "CounterView.h"
#define HomeTitle_offset_X 13

@interface CounterHomeController ()
@property (nonatomic,strong)LXSegmentScrollView *scView;

@end

@implementation CounterHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backBtn.hidden = YES;
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [titleButton setTitle:@"计算器" forState:UIControlStateNormal];
    [titleButton sizeToFit];
    [titleButton setTitleColor:BK_TextField_TextColor forState:UIControlStateNormal];
    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithCustomView:titleButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = HomeTitle_offset_X;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_left, nil];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self loadSegmentView];
}



- (void)loadSegmentView{
    NSArray *titleArray = @[@"等额本息",@"等本等息",@"按月付息",@"到期还本付息",@"等额本金"];
    NSMutableArray *array=[NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        CounterView *counterView = [[[NSBundle mainBundle] loadNibNamed:@"CounterView" owner:self options:nil] lastObject];
        counterView.index = i;
        [array addObject:counterView];
    }
    
    _scView = [[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH + 100, BK_SCREEN_HEIGHT - BKStatusBarAndNavigationBarHeight) titleArray:titleArray contentViewArray:array];
    _scView.backgroundColor = [UIColor clearColor];
__weak typeof(self) weakSelf = self;
    _scView.indexBlock = ^(NSInteger tag) {
            [weakSelf.view endEditing:YES];
        };
    [self.view addSubview:_scView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
