//
//  UIDefines.h
//  ContactsExpert
//
//  Created by 肖聪 on 14-12-4.
//  Copyright (c) 2014年 LotusPlumule. All rights reserved.
//

//类目

#import <UIKit/UIKit.h>


@interface UIImageView (MyImageView)

+ (UIImageView *)imageViewWithFrame:(CGRect)aRect backgroundColor:(UIColor *)aBackgroundColor;

+ (UIImageView *)imageViewWithFrame:(CGRect)aRect backgroundColor:(UIColor *)aBackgroundColor image:(UIImage *)aImage tag:(NSInteger)aTag;


@end

@interface UILabel (MyLable)

+ (UILabel *)lableWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;

+(UILabel *)lableWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize textFont:(NSString *)textFont lableText:(NSString *)textString backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment textColor:(UIColor *)textColor;
@end

@interface UIButton (MyButton)

+ (UIButton *)buttonWithType:(UIButtonType)type frame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage target:(id)target action:(SEL)action;

@end

@interface UIViewController (CustomNavgationBar)

- (void)customNavgationBarWithTitle:(NSString *)title;

@end

@interface NSString (GetFilePath)

+ (NSString *)getFilePath:(NSString *)str;

@end




