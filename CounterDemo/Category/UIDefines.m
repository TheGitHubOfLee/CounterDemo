//
//  UIDefines.m
//  ContactsExpert
//
//  Created by 肖聪 on 14-12-4.
//  Copyright (c) 2014年 LotusPlumule. All rights reserved.
//

#import "UIDefines.h"
#pragma mark UIImageView

@implementation UIImageView (MyImageView)

+ (UIImageView *)imageViewWithFrame:(CGRect)aRect
                    backgroundColor:(UIColor *)aBackgroundColor
{
    UIImageView * aImageView = [[UIImageView alloc] initWithFrame:aRect];
    aImageView.backgroundColor = aBackgroundColor;
    return [aImageView autorelease];
}

+ (UIImageView *)imageViewWithFrame:(CGRect)aRect
                    backgroundColor:(UIColor *)aBackgroundColor
                              image:(UIImage *)aImage
                                tag:(NSInteger)aTag
{
    UIImageView * aImageView = [[UIImageView alloc] initWithFrame:aRect];
    aImageView.backgroundColor = aBackgroundColor;
    aImageView.image = aImage;
    aImageView.tag = aTag;
    return [aImageView autorelease];
}
@end


#pragma mark UILable 类目
@implementation UILabel (MyLable)

+ (UILabel *)lableWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize
{
    UILabel * aLable = [[UILabel alloc] initWithFrame:frame];
    aLable.backgroundColor = backgroundColor;
    aLable.textAlignment = textAliment;
    aLable.textColor = textColor;
    aLable.font = [UIFont systemFontOfSize:fontSize];
    return [aLable autorelease];
}

+(UILabel *)lableWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize textFont:(NSString *)textFont lableText:(NSString *)textString backgroundColor:(UIColor *)backgroundColor textAliment:(NSTextAlignment)textAliment textColor:(UIColor *)textColor
{
    UILabel * aLable = [[UILabel alloc] initWithFrame:frame];
    aLable.backgroundColor = backgroundColor;
    aLable.textAlignment = textAliment;
    aLable.textColor = textColor;
    //    aLable.font = [UIFont systemFontOfSize:15];
    aLable.text=textString;
    aLable.font=[UIFont fontWithName:textFont size:fontSize];
    aLable.font = [UIFont systemFontOfSize:fontSize];
    //    label.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    
    return [aLable autorelease];
}

@end


#pragma mark UIButton
@implementation UIButton (MyButton)
+ (UIButton *)buttonWithType:(UIButtonType)type frame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage target:(id)target action:(SEL)action
{
    UIButton * aButton = [UIButton buttonWithType:type];
    aButton.frame = frame;
    [aButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [aButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return aButton;
}
@end


#pragma mark CustomNavgationBar
@implementation UIViewController (CustomNavgationBar)
- (void)customNavgationBarWithTitle:(NSString *)title
{
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.text = title;
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.shadowColor = [UIColor grayColor];
    titleLable.shadowOffset = CGSizeMake(0, 1);
    self.navigationItem.titleView = [titleLable autorelease];
}
@end


@implementation NSString (GetFilePath)

+ (NSString *)getFilePath:(NSString *)str
{
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [documentsPath stringByAppendingPathComponent:str];
    NSLog(@"%@", filePath);
    return filePath;
}
@end

