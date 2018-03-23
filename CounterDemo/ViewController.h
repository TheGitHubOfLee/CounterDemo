//
//  ViewController.h
//  CounterDemo
//
//  Created by GQ-JK on 2018/3/23.
//  Copyright © 2018年 GQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
/** 导航条View */
@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) UIButton * backBtn;



// 设置导航栏标题
//-(void)setNavigationBarTitle:(NSString *)title;
-(void)LoginBackAction;

@end

