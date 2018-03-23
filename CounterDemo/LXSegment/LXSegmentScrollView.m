//
//  LXSegmentScrollView.m
//  LiuXSegment
//
//  Created by liuxin on 16/5/17.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define MainScreen_W [UIScreen mainScreen].bounds.size.width

#import "LXSegmentScrollView.h"
#import "LiuXSegmentView.h"

@interface LXSegmentScrollView()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *bgScrollView;
@property (strong,nonatomic)LiuXSegmentView *segmentToolView;

@end
static NSInteger arrayCount;
@implementation LXSegmentScrollView


-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray
{
    if (self = [super initWithFrame:frame]) {
        
        arrayCount = titleArray.count;
        [self addSubview:self.bgScrollView];

        _segmentToolView=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 55) titles:titleArray clickBlick:^void(NSInteger index) {
//            BKLog(@"点击标题-----%ld",index - 1);
            
            if (self.indexBlock) {
                self.indexBlock(index - 1);
            }
            [_bgScrollView setContentOffset:CGPointMake(MainScreen_W*(index-1), 0) animated:YES];
        }];
        [self addSubview:_segmentToolView];
        for (int i = 0 ; i<2; i++) {
            UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, i * 54.5, BK_SCREEN_WIDTH, 0.5)];
            topLineView.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
            [_segmentToolView addSubview:topLineView];
        }
        for (int i=0;i<contentViewArray.count; i++ ) {
            
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame=CGRectMake(MainScreen_W * i, _segmentToolView.bounds.size.height, MainScreen_W, _bgScrollView.frame.size.height-_segmentToolView.bounds.size.height);
            [_bgScrollView addSubview:contentView];
        }
    }
    return self;
}
-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, MainScreen_W, self.bounds.size.height-_segmentToolView.bounds.size.height)];
        _bgScrollView.contentSize=CGSizeMake(MainScreen_W* arrayCount, self.bounds.size.height-_segmentToolView.bounds.size.height);
        _bgScrollView.backgroundColor=[UIColor clearColor];
        _bgScrollView.showsVerticalScrollIndicator=NO;
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.delegate=self;
        _bgScrollView.bounces=NO;
        _bgScrollView.pagingEnabled=YES;
    }
    return _bgScrollView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_bgScrollView)
    {
        NSInteger p=_bgScrollView.contentOffset.x/MainScreen_W;
        _segmentToolView.defaultIndex=p+1;
//        BKLog(@"滑动----%ld",(long)p);
        if (self.indexBlock) {
            self.indexBlock(p);
        }
    }
}

@end
