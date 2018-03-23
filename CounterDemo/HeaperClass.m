//
//  HeaperClass.m
//  CounterDemo
//
//  Created by GQ-JK on 2018/3/23.
//  Copyright © 2018年 GQ. All rights reserved.
//

#import "HeaperClass.h"

@implementation HeaperClass
+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
//判断是否为浮点形：
+(BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

//1、判断输入的字符串是否有中文
+(BOOL)IsChineseStr:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            return YES;
        }
    }
    return NO;
}


//1、判断不能输入中文
+(BOOL)cantInputChineseStr:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)//判断输入的是否是中文
        {
            return NO;
        }
    }
    return YES;
}

// 全汉字
+ (BOOL)inputShouldChinese:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}



//判断仅输入数字：

+ (BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

// 全字母
+ (BOOL)inputShouldLetter:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}


// 是否包含字母获数字
+ (BOOL)isStringContainNumberOrLetterWith:(NSString *)str {
    
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"A-Za-z0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    //count是str中包含[A-Za-z0-9]数字的个数，只要count>0，说明str中包含数字
    
    if (count > 0) {
        
        return YES;
        
    }
    
    return NO;
    
}

#pragma mark - 判断字符串是否包含字母

+ (BOOL)isStringContainLetterWith:(NSString *)str {
    
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    //count是str中包含[A-Za-z]数字的个数，只要count>0，说明str中包含数字
    
    if (count > 0) {
        
        return YES;
        
    }
    
    return NO;
    
}


#pragma mark - 判断字符串是否包含数字

+ (BOOL)isStringContainNumberWith:(NSString *)str {
    
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    
    if (count > 0) {
        
        return YES;
        
    }
    
    return NO;
    
}




// 判断输入字母或数字
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}


// 判断输入数字小数点
+ (BOOL)inputShouldNumOrPoint:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[0-9.]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

/**
 *  获取父视图的控制器
 *
 *  @return 父视图的控制器
 */
+ (UIViewController *)viewController:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+(NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%.2lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

//+ (void)saveToLocalData:(id)value key:(NSString *)key{
//    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
//
//}
//
//
//+ (id)readDataFromLocal:(NSString *)key{
//   return [[NSUserDefaults standardUserDefaults] objectForKey:key];
//
//}


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
                                                         bid:(double)month{
    
    // 初始化运算 NSDecimalNumberHandler (数据格式)
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    
    // 将数值转化为更为精确的 NSDecimalNumber类型
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];//投资金额
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];//月利率
    
    //    double month = selectBid.creditPeriod;//标的募集期数
    //    if (selectBid.creditType == CreditType_DaylyOneOffPayment) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month]];//还款月数
    
    // 开始计算
    //    *  公式： 每月本息还款额=(投资金额*月利率*(1+月利率)^还款月数)/(((1+月利率)^还款月数)-1)
    // (每月本息还款额=(投资金额*月利率*(1+月利率)^还款月数))
    NSDecimalNumber *decNum1 = [[[[[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]] decimalNumberByAdding:monthInterestDec] decimalNumberByRaisingToPower:month] decimalNumberByMultiplyingBy:monthInterestDec] decimalNumberByMultiplyingBy:investAmountDec];
    
    // (((1+月利率)^还款月数)-1)
    NSDecimalNumber *decNum2 = [[[[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]] decimalNumberByAdding:monthInterestDec] decimalNumberByRaisingToPower:month] decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]]];
    
    // 两个值相除 decNum1/decNum2 = 月本息还款额
    NSDecimalNumber *monthIncomeDec = [decNum1 decimalNumberByDividingBy:decNum2];
    
    //总还款额 - 本金 = 总收益
    // 月本息还款额 * 还款月数 - 本金 = 总收益
    NSDecimalNumber *totalIncomeDec = [[monthDec decimalNumberByMultiplyingBy:monthIncomeDec] decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker];
    return [totalIncomeDec doubleValue] > 0 ? [totalIncomeDec doubleValue] : 0;
}

/**
 * 等额本息每月的收益
 **/
+ (NSArray *)calculatePrincipalAndInterestBidByEachMouthWithInvestInterest:(double)interest
                                                                    amount:(NSString *)investAmount
                                                                       bid:(double)month
                                                                   Hasalso:(double)hasAlso
{
    
    // 初始化运算 NSDecimalNumberHandler (数据格式)
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    
    // 将数值转化为更为精确的 NSDecimalNumber类型
    // 已还金额
    NSDecimalNumber *hasAlso1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", hasAlso]];
    
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];//投资金额
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];//月利率
    
    //    double month = selectBid.creditPeriod;//标的募集期数
    //    if (selectBid.creditType == CreditType_DaylyOneOffPayment) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    //    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month]];//还款月数
    
    // 开始计算
    //    *  公式： 每月本息还款额=(投资金额*月利率*(1+月利率)^还款月数)/(((1+月利率)^还款月数)-1)
    // ((投资金额*月利率*(1+月利率)^还款月数))
    NSDecimalNumber *decNum1 = [[[[[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]] decimalNumberByAdding:monthInterestDec] decimalNumberByRaisingToPower:month] decimalNumberByMultiplyingBy:monthInterestDec] decimalNumberByMultiplyingBy:investAmountDec];
    
    // (((1+月利率)^还款月数)-1)
    NSDecimalNumber *decNum2 = [[[[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]] decimalNumberByAdding:monthInterestDec] decimalNumberByRaisingToPower:month] decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]]];
    
    // 两个值相除 decNum1/decNum2 = 月本息还款额
    NSDecimalNumber *monthIncomeDec = [decNum1 decimalNumberByDividingBy:decNum2];
    
    //总还款额 - 本金 = 总收益
    // 月本息还款额 * 还款月数 - 本金 = 总收益
    //    NSDecimalNumber *totalIncomeDec = [[monthDec decimalNumberByMultiplyingBy:monthIncomeDec] decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker];
    
    // 本月还息   （贷款本金-已还）×年利率/12
    
    // 本月还息
    NSDecimalNumber *monthInterest =  [[investAmountDec decimalNumberBySubtracting:hasAlso1] decimalNumberByMultiplyingBy:monthInterestDec withBehavior:roundBanker];
    // 还款本金
    NSDecimalNumber *monthapitalInterest =  [monthIncomeDec decimalNumberBySubtracting:monthInterest withBehavior:roundBanker];
    
    // 月还款额, 月利息
    NSArray *array = [NSArray arrayWithObjects:monthIncomeDec ,monthInterest, monthapitalInterest, nil];
    
    return array;
}


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
                                                     AndMonth:(double )month {
    
    
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    //投资金额
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];
    
    //月利率
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];
    
    //    if (!isMonth) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    NSDecimalNumber *num1           = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"2"]];
    
    //还款月数
    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month + 1.0]];
    
    // 预期收益=(投资期限+1)*投资金额 * 年利率/12/2
    NSDecimalNumber *multiplyResult = [[[monthDec decimalNumberByMultiplyingBy:investAmountDec
                                                                  withBehavior:roundBanker] decimalNumberByMultiplyingBy:monthInterestDec
                                        withBehavior:roundBanker] decimalNumberByDividingBy:num1
                                       withBehavior:roundBanker] ;
    
    return [multiplyResult doubleValue] > 0 ? [multiplyResult doubleValue] : 0;
}


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
                                                      AndMonth:(double )month {
    
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    // 投资金额
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];
    
    // 月利率
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];
    
    //    if (!isMonth) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    
    // 还款月数
    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month]];
    
    // 预期收益=投资金额*年利率/12*投资期限
    NSDecimalNumber *monthIncomeDec = [[investAmountDec decimalNumberByMultiplyingBy:monthInterestDec
                                                                        withBehavior:roundBanker] decimalNumberByMultiplyingBy:monthDec withBehavior:roundBanker];
    
    //总还款额 - 本金 = 总收益
    //    NSDecimalNumber *totalIncomeDec = [[monthDec decimalNumberByMultiplyingBy:monthIncomeDec] decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker];
    return [monthIncomeDec doubleValue] > 0 ? [monthIncomeDec doubleValue] : 0;
}


/**
 *  等本等息
 */
+ (NSArray *)PayInterestPrincipalEachMouthAndInterestBidWithInvestInterest:(double)interest
                                                                    amount:(NSString *)investAmount
                                                                  AndMonth:(double )month {
    
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    // 投资金额
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];
    
    // 月利率
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];
    
    //    if (!isMonth) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    
    // 还款月数
    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month]];
    
    // 每月还款额 = 贷款金额/还款月数+贷款金额*年利率/12
    NSDecimalNumber *monthIncomeDec = [[investAmountDec decimalNumberByDividingBy:monthDec] decimalNumberByAdding:[investAmountDec decimalNumberByMultiplyingBy:monthInterestDec]
                                                                                                     withBehavior:roundBanker];
    // 本月利息
    NSDecimalNumber *interestMouth = [investAmountDec decimalNumberByMultiplyingBy:monthInterestDec withBehavior:roundBanker];
    
    // 还款本金
    NSDecimalNumber *monthapitalInterest =  [monthIncomeDec decimalNumberBySubtracting:interestMouth withBehavior:roundBanker];
    
    //总还款额 - 本金 = 总收益
    //    NSDecimalNumber *totalIncomeDec = [[monthDec decimalNumberByMultiplyingBy:monthIncomeDec] decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker];
    NSArray *array = [NSArray arrayWithObjects:monthIncomeDec, interestMouth, monthapitalInterest, nil];
    return array;
}

/**
 *  按月付息、到期还本
 */
+ (NSArray *)PayInterestPrincipal1EachMouthAndInterestBidWithInvestInterest:(double)interest
                                                                     amount:(NSString *)investAmount
                                                                   AndMonth:(double )month
                                                                     isLast:(BOOL)last{
    
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    // 投资金额
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];
    
    // 月利率
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];
    
    //    if (!isMonth) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    
    // 还款月数
    //    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month]];
    
    // 每月还款额 = 贷款金额/还款月数+贷款金额*年利率/12
    NSDecimalNumber *monthIncomeDec = [last ? investAmountDec : [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",0.0]] decimalNumberByAdding:[investAmountDec decimalNumberByMultiplyingBy:monthInterestDec]
                                                  withBehavior:roundBanker];
    // 本月利息
    NSDecimalNumber *interestMouth = [investAmountDec decimalNumberByMultiplyingBy:monthInterestDec withBehavior:roundBanker];
    
    // 还款本金
    NSDecimalNumber *monthapitalInterest =  last ? investAmountDec : [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",0.0]];
    
    //总还款额 - 本金 = 总收益
    //    NSDecimalNumber *totalIncomeDec = [[monthDec decimalNumberByMultiplyingBy:monthIncomeDec] decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker];
    //    NSLog(@"monthIncomeDec : %@", monthIncomeDec);
    NSArray *array = [NSArray arrayWithObjects:monthIncomeDec, interestMouth, monthapitalInterest, nil];
    return array;
}

/**
 *  到期还本付息
 到期还本息 = 贷款金额*年利率/12*期限+贷款金额
 
 */
+ (NSArray *)PayInterestPrincipal2EachMouthAndInterestBidWithInvestInterest:(double)interest
                                                                     amount:(NSString *)investAmount
                                                                   AndMonth:(double )month
                                                                     isLast:(BOOL)last{
    
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    // 投资金额
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];
    
    // 月利率
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];
    
    //    if (!isMonth) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    
    // 还款月数
    //    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month]];
    
    
    // 预期收益
    NSDecimalNumber *monthIncomeDec1 = [[NSDecimalNumber alloc]initWithString:[NSString stringWithFormat:@"%f", [HeaperClass PayInterestPrincipalAndInterestBidWithInvestInterest:interest amount:investAmount AndMonth:month]]];
    
    
    // 到期还本息 = 贷款金额*年利率/12*期限+贷款金额
    NSDecimalNumber *monthIncomeDec = last ? [investAmountDec decimalNumberByAdding:monthIncomeDec1] : [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",0.0]];
    // 本月利息
    NSDecimalNumber *interestMouth = last ? [monthIncomeDec decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker] : [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",0.0]];
    
    
    
    // 还款本金
    NSDecimalNumber *monthapitalInterest =  last ? investAmountDec : [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",0.0]];
    
    //总还款额 - 本金 = 总收益
    //    NSDecimalNumber *totalIncomeDec = [[monthDec decimalNumberByMultiplyingBy:monthIncomeDec] decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker];
    //    NSLog(@"monthIncomeDec : %@", monthIncomeDec);
    NSArray *array = [NSArray arrayWithObjects:monthIncomeDec, interestMouth, monthapitalInterest, nil];
    return array;
}

/**
 *  每月等额本金标的收益计算
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
                                                          Hasalso:(double)hasAlso{
    
    
    NSDecimalNumberHandler *roundBanker = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                 scale:2.0f
                                                                                      raiseOnExactness:NO
                                                                                       raiseOnOverflow:NO
                                                                                      raiseOnUnderflow:NO
                                                                                   raiseOnDivideByZero:YES];
    
    // 将数值转化为更为精确的 NSDecimalNumber类型
    // 已还金额
    NSDecimalNumber *hasAlso1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", hasAlso]];
    
    NSDecimalNumber *investAmountDec = [[NSDecimalNumber alloc] initWithString:investAmount];//投资金额
    
    //月利率
    NSDecimalNumber *monthInterestDec = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",interest/100]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",12.00]]];
    
    //    if (!isMonth) {
    //        //按天标,转化为月份
    //        month = month/30.00;
    //    }
    //    NSDecimalNumber *num1           = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"2"]];
    
    //还款月数
    NSDecimalNumber *monthDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",month]];
    
    
    // 每月还本付息金额=(本金/还款月数)+(本金-累计已还本金)× 年利率/12
    NSDecimalNumber *monthIncomeDec = [[[investAmountDec decimalNumberBySubtracting:hasAlso1] decimalNumberByMultiplyingBy:monthInterestDec] decimalNumberByAdding:[investAmountDec decimalNumberByDividingBy:monthDec]
                                                                                                                                                      withBehavior:roundBanker];
    
    // 每月本金=总本金/还款月数
    
    NSDecimalNumber *monthapitalInterest =  [investAmountDec decimalNumberByDividingBy:monthDec withBehavior:roundBanker];
    
    
    // 每月利息=(本金-累计已还本金)× 年利率/12
    NSDecimalNumber *interestMouth = [monthIncomeDec decimalNumberBySubtracting:monthapitalInterest withBehavior:roundBanker];
    
    
    //总还款额 - 本金 = 总收益
    //    NSDecimalNumber *totalIncomeDec = [[monthDec decimalNumberByMultiplyingBy:monthIncomeDec] decimalNumberBySubtracting:investAmountDec withBehavior:roundBanker];
    //    NSLog(@"monthIncomeDec : %@", monthIncomeDec);
    NSArray *array = [NSArray arrayWithObjects:monthIncomeDec, interestMouth, monthapitalInterest, nil];
    return array;
    
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    
    return mDate;
    
}



@end
