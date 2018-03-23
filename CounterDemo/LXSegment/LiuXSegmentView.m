//
//  LiuXSegmentView.m
//  LiuXSegment
//
//  Created by liuxin on 16/3/18.
//  Copyright © 2016年 liuxin. All rights reserved.
//


#import "LiuXSegmentView.h"


@interface LiuXSegmentView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *selectLine;
//@property (nonatomic,strong) UIView *backView;

@property (nonatomic,assign) CGFloat btn_w;
@end

@implementation LiuXSegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.layer.shadowColor=[UIColor blackColor].CGColor;
//        self.layer.shadowOffset=CGSizeMake(2, 2);
//        self.layer.shadowRadius=2;
//        self.layer.shadowOpacity=.2;
        
        _btn_w=0.0;
        if (titleArray.count<MAX_TitleNumInWindow+1) {
            _btn_w=windowContentWidth/titleArray.count;
        }else{
            _btn_w=windowContentWidth/MAX_TitleNumInWindow;
        }
        _titles=titleArray;

        
        _defaultIndex=0;
        _titleFont=[UIFont systemFontOfSize:14];
        _btns=[[NSMutableArray alloc] initWithCapacity:0];
        _titleNomalColor=BK_TextField_TextColor;
        _titleSelectColor=BK_ORGCOLOR;

        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 55)];
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count, self.frame.size.height);
        [self addSubview:_bgScrollView];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , titleArray.count >= 5 ? windowContentWidth/4*titleArray.count : windowContentWidth, 55)];
        [_bgScrollView addSubview:backView];

        
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake(0, _bgScrollView.bottom - 1, _btn_w, 1)];
        _selectLine.backgroundColor=_titleSelectColor;
        [_bgScrollView addSubview:_selectLine];
        
        UILabel * bottomLab = [UILabel lableWithFrame:CGRectMake(0, _bgScrollView.bottom - 0.5, BK_SCREEN_WIDTH, 0.5) backgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:0.9] textAliment:NSTextAlignmentCenter textColor:[UIColor clearColor] fontSize:0];
        [backView addSubview:bottomLab];
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, 53);
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [btn setBackgroundColor:[UIColor clearColor]];
            btn.titleLabel.font=_titleFont;
            //分割线
            UILabel * lineLab = [UILabel lableWithFrame:CGRectMake(btn.right, _bgScrollView.top + 12, 0.5, 30) backgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:0.7] textAliment:NSTextAlignmentCenter textColor:[UIColor clearColor] fontSize:10];
            
            [_bgScrollView addSubview:lineLab];
            
            
            [backView addSubview:btn];
            [_btns addObject:btn];
            if (i==0) {
                _titleBtn=btn;
                btn.selected=YES;
            }
            self.block=block;
            
        }
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.block) {
        self.block(btn.tag);
        
//        BKLog(@"++++%ld",btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
    }
    
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.width-windowContentWidth;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height-2, btn.frame.size.width, 1);
        
    } completion:^(BOOL finished) {
        
    }];
    
}



-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}

-(void)updateView{
    if (_defaultIndex == 1 || _defaultIndex == 5) {
        if (_titles.count >= 4) {
            
            [_bgScrollView setContentOffset:CGPointMake(_defaultIndex == 1 ? 0 : windowContentWidth/4, 0) animated:YES];

        }

    }
    
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
            _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height-2, btn.frame.size.width, 1);
        }else{
            btn.selected=NO;
        }
    }
}

@end
