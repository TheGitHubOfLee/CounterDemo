//
//  ViewController.m
//  BKFinancial
//
//  Created by MC on 2017/11/20.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = BK_BG_COLOR;
    [self.navigationController.navigationBar setTranslucent:NO];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = BK_LINE_COLOR;
    [self.view addSubview:lineView];
    
    //隐藏导航栏底部分割线
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //隐藏系统返回
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    [self backAction];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view from its nib.
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

//全局自定义返回按钮
-(void)backAction{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(0, 0, BK_BACKBTN_WIDTH, BK_BACKBTN_HEIGHT ) backgroundImage:nil target:self action:@selector(LoginBackAction)];
    _backBtn.backgroundColor = [UIColor clearColor];
    [_backBtn setImage:[UIImage imageNamed:BK_BACK_BTN] forState:UIControlStateNormal];
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(11, 2, 11, 30);
    _backBtn.contentMode=UIViewContentModeLeft;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}

//返回上一个页面
-(void)LoginBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

