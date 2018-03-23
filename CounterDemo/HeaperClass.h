//
//  HeaperClass.h
//  CounterDemo
//
//  Created by GQ-JK on 2018/3/23.
//  Copyright © 2018年 GQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HeaperClass : NSObject

//1、判断输入的字符串是否有中文
+(BOOL)IsChineseStr:(NSString *)str;

// 判断输入字母或数字
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString;

// 全字母
+ (BOOL)inputShouldLetter:(NSString *)inputString;
//判断仅输入数字：

+(BOOL)inputShouldNumber:(NSString *)inputString ;

// 全汉字
+ (BOOL)inputShouldChinese:(NSString *)inputString;

//1、判断不能输入中文
+(BOOL)cantInputChineseStr:(NSString *)str;

// 是否包含字母获数字
+ (BOOL)isStringContainNumberOrLetterWith:(NSString *)str;
// 是否包含字母
+ (BOOL)isStringContainLetterWith:(NSString *)str;

// 是否包含数字
+ (BOOL)isStringContainNumberWith:(NSString *)str;

// 判断输入数字小数点
+ (BOOL)inputShouldNumOrPoint:(NSString *)inputString;

// 获取父试图
+ (UIViewController *)viewController:(UIView *)view;


/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+(NSString *)reviseString:(NSString *)str;

/**
 *  按月付息、到期还本
 *  到期还本付息
 *  等本等息
 *  公式： 预期收益=投资金额*年利率/12*投资期限
 *  @param interest     年化收益
 *  @param investAmount 投资金额
 *  @param month 投资期限
 *
 *  @return 收益
 */
+ (double)PayInterestPrincipalAndInterestBidWithInvestInterest:(double)interest
                                                        amount:(NSString *)investAmount
                                                      AndMonth:(double )month;

/**
 *  等额本金标的收益计算
 *  公式： 预期收益=(投资期限+1)*投资金额*年利率/12/2
 *  @param interest     年化收益
 *  @param investAmount 投资金额
 *  @param month 投资期限
 *
 *  @return 收益
 */
+ (double) PrinciplePrincipalAndInterestBidWithInvestInterest:(double)interest
                                                       amount:(NSString *)investAmount
                                                     AndMonth:(double )month;

/**
 *  等额本息标的收益计算
 *  公式： 每月本息还款额=(投资金额*月利率*(1+月利率)^还款月数)/(((1+月利率)^还款月数)-1)
 *  @param interest     年化收益
 *  @param investAmount 投资金额
 *  @param month    期限
 *
 *  @return 收益
 */
+ (double)calculatePrincipalAndInterestBidWithInvestInterest:(double)interest
                                                      amount:(NSString *)investAmount
                                                         bid:(double)month;

/**
 * 等额本息每月的收益
 **/
+ (NSArray *)calculatePrincipalAndInterestBidByEachMouthWithInvestInterest:(double)interest
                                                                    amount:(NSString *)investAmount
                                                                       bid:(double)month
                                                                   Hasalso:(double)hasAlso;
/**
 *  等本等息
 */
+ (NSArray *)PayInterestPrincipalEachMouthAndInterestBidWithInvestInterest:(double)interest
                                                                    amount:(NSString *)investAmount
                                                                  AndMonth:(double )month;

/**
 *  按月付息、到期还本
 */
+ (NSArray *)PayInterestPrincipal1EachMouthAndInterestBidWithInvestInterest:(double)interest
                                                                     amount:(NSString *)investAmount
                                                                   AndMonth:(double )month
                                                                     isLast:(BOOL)last;

/**
 *  等额本金标的收益计算
 *
 每月还本付息金额=(本金/还款月数)+(本金-累计已还本金)× 年利率/12
 每月本金=总本金/还款月数
 每月利息=(本金-累计已还本金)× 年利率/12
 
 *  @param interest     年化收益
 *  @param investAmount 投资金额
 *  @param month 投资期限
 */
+ (NSArray *) PrinciplePrincipal1AndInterestBidWithInvestInterest:(double)interest
                                                           amount:(NSString *)investAmount
                                                         AndMonth:(double )month
                                                          Hasalso:(double)hasAlso;
/**
 *  到期还本付息
 到期还本息 = 贷款金额*年利率/12*期限+贷款金额
 
 */
+ (NSArray *)PayInterestPrincipal2EachMouthAndInterestBidWithInvestInterest:(double)interest
                                                                     amount:(NSString *)investAmount
                                                                   AndMonth:(double )month
                                                                     isLast:(BOOL)last;


// 加减月
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;



@end
