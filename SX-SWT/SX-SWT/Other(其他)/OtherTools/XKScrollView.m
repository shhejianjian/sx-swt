//
//  XKScrollView.m
//  MyScrollViewTest
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "XKScrollView.h"

#import "UIImageView+WebCache.h"
static NSInteger currentIndex;

static NSInteger preIndex;

static NSInteger nextIndex;

#define  ScreenWidth [UIScreen mainScreen].bounds.size.width

#define  ScreenSize [UIScreen mainScreen].bounds.size

@implementation XKScrollView

{
    CGFloat scrollHeight;
}

#pragma mark-初始化方法

-(instancetype)initWithFrame:(CGRect)frame withScrollHeight:(CGFloat)aheight
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scrollHeight = aheight;
        
        [self addSubview:self.scrollView];
        self.scrollView.backgroundColor = [UIColor blackColor];
        
        _scrollView.frame = CGRectMake(0, 64, ScreenWidth, scrollHeight);
        
        _scrollView.pagingEnabled = YES;
        [self addSubview:self.pageControl];
        
        self.scrollView.delegate = self;
        
        [self.pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        
        self.pageControl.frame = (CGRect){0,scrollHeight+44,ScreenWidth,20};
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        
        self.pageControl.tintColor = [UIColor blackColor];
        
        self.pageControl.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        
        [self creatUIwithSize:frame.size];
    }
    return self;
}

-(void)creatUIwithSize:(CGSize)size
{
    self.scrollView.contentSize = (CGSize){3*ScreenWidth,scrollHeight};
    
    self.preImgView.frame = (CGRect){0.0f,0.0f,ScreenWidth,scrollHeight};
    self.currentImgView.frame = (CGRect){ScreenWidth,0.0f,ScreenWidth,scrollHeight};
    self.nexImgView.frame = (CGRect){2*ScreenWidth,0.0f,ScreenWidth,scrollHeight};
    //让偏移量一直处在中间的位置上
    self.scrollView.contentOffset = CGPointMake(ScreenWidth, 0.0f);
    
    //添加触摸的手势
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewWithFocusImg)];
    
    self.currentImgView.userInteractionEnabled = YES;
    
    [self.currentImgView addGestureRecognizer:tapGesture];

}

-(void)tapImageViewWithFocusImg
{
    //调用方法

    if (_myTapCurrentImgBlock)
    {
        _myTapCurrentImgBlock(currentIndex);
    }
    
}
#pragma mark -pageControl改变

-(void)pageChange:(id)sender
{

    [self removTimer];
    currentIndex = _pageControl.currentPage;
    // 设置图片
    [self doWithImage];
    
    // 重新启动
    [self startTimer];

}
#pragma mark-移除定时器

-(void)removTimer
{
    if (!_timer)
    {
        return;
    }
    [self.timer invalidate];
     self.timer = nil;
}
#pragma mark-开启定时器
-(void)startTimer
{
    [self removTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(doWithTimer) userInfo:nil repeats:YES];
    
}

#pragma mark-定时器调用方法
-(void)doWithTimer
{
    //使用初始值为0 每次+1的算法 然后
    currentIndex = (currentIndex + 1 + self.picModles.count) % self.picModles.count;

    [self doWithImage];
    if(self.picModles.count > 1){
    /* 宏定义效果
         kCATransitionFade   交叉淡化过渡
         kCATransitionMoveIn 新视图移到旧视图上面
         kCATransitionPush   新视图把旧视图推出去
         kCATransitionReveal 将旧视图移开,显示下面的新视图 
    */
    /*  字符串效果
     pageCurl            向上翻一页
     pageUnCurl          向下翻一页
     rippleEffect        滴水效果
     suckEffect          收缩效果，如一块布被抽走
     cube                立方体效果
     oglFlip             上下翻转效果
     */
/**
 * @param 要执行动画的对象
 * @param 执行动画的类型
 * @param 从左或者从右开始
 * @param 动画的时间
 */
    // 设置动画
    [self addAnimationView:self.currentImgView WithType:@"cube" subType:kCATransitionFromRight duration:0.5];
    }
    self.scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
    
    self.pageControl.currentPage = currentIndex;
    
}
#pragma mark setter方法
-(void)setPicModles:(NSMutableArray *)picModles
{
    _picModles = picModles;
    
    [self doWithInitData];
    
}
-(void)doWithInitData
{
    if (!self.picModles.count)
    {
        return;
    }
    
    currentIndex =0;
    
    self.pageControl.numberOfPages = _picModles.count;
    //设置图片
    
    [self doWithImage];
    

}

#pragma mark -设置图片
-(void)doWithImage
{
    preIndex = (currentIndex-1+self.picModles.count)%self.picModles.count;
    nextIndex = (currentIndex+1+self.picModles.count)%self.picModles.count;
    
    NSString *preImgStr     = self.picModles[preIndex];
    if ([preImgStr hasPrefix:@"http"])
    {
        [self.preImgView sd_setImageWithURL:[NSURL URLWithString:preImgStr]];
    }
    else
    {
        self.preImgView.image = [UIImage imageNamed:self.picModles[preIndex]];
    }
    NSString *currentImgStr =self.picModles[currentIndex];
    if ([currentImgStr hasPrefix:@"http"])
    {
        [self.currentImgView sd_setImageWithURL:[NSURL URLWithString:currentImgStr]];
 
    }
    else
    {
        self.currentImgView.image = [UIImage imageNamed:self.picModles[currentIndex]];
    }
    NSString *nexImgStr     = self.picModles[nextIndex];
    if ([nexImgStr hasPrefix:@"http"])
    {
        [self.nexImgView sd_setImageWithURL:[NSURL URLWithString:nexImgStr]];

    }
    else
    {
      self.nexImgView.image = [UIImage imageNamed:self.picModles[nextIndex]];
    }
}
#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 开始拖拽，移除计时器
    //这些代码我写的暂时有些问题
//    CGFloat arc = M_PI * 2.0f;
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1.0f/700.0f;
//    float x = _scrollView.contentOffset.x;
//
//    CGFloat radius = ScreenWidth/2/ tanf(arc/2.0f/self.picModles.count);
//    CGFloat angle = (currentIndex-x/ScreenWidth+1)/ self.picModles.count * arc;
//    transform = CATransform3DRotate(transform, angle, 0.0f, 1.0f, 0.0f);
//    transform = CATransform3DTranslate(transform, 0.f, 0.0f, radius);
//    self.currentImgView.layer.transform = transform;
    [self removTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offX = self.scrollView.contentOffset.x;
    // 偏移了
    
    if (offX  > ScreenWidth )
    {
        // 向左滚动
        currentIndex = (currentIndex + 1 + self.picModles.count) % self.picModles.count;
    }
    else if(offX  < ScreenWidth)
    {
        // 往右
        currentIndex = (currentIndex - 1 + self.picModles.count) % self.picModles.count;
    }
    
    // 设置图片
    
    [self doWithImage];
    
    self.scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
    
    self.pageControl.currentPage  = currentIndex;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 拖拽结束，重启timer
    
    [self startTimer];
}

#pragma mark -懒加载

-(UIPageControl *)pageControl
{
    if (_pageControl)
    {
        return _pageControl;
    }
    
    _pageControl = [[UIPageControl alloc]init];
    
    return _pageControl;
    
}

-(UIScrollView *)scrollView
{
    if (_scrollView)
    {
        return _scrollView;
    }
    
    _scrollView = [[UIScrollView alloc]init];
    
    return _scrollView;

}

-(UIImageView *)preImgView
{
    if (_preImgView) {
        return _preImgView;
    }
    _preImgView = [UIImageView new];
    [self.scrollView addSubview:_preImgView];

    return _preImgView;
}

-(UIImageView *)nexImgView
{
    if (_nexImgView)
    {
        return _nexImgView;
    }
    _nexImgView = [UIImageView new];
    
    [self.scrollView addSubview:_nexImgView];

    return _nexImgView;
}
-(UIImageView *)currentImgView
{
    if (_currentImgView)
    {
        return _currentImgView;
    }
    _currentImgView = [UIImageView new];

    [self.scrollView addSubview:_currentImgView];
    
    return _currentImgView;
}

#pragma mark - 过渡动画

- (void)addAnimationView:(UIView *)view WithType:(NSString *)type subType:(NSString *)subType duration:(CGFloat)duration
{
    CATransition *transition = [CATransition animation];
    transition.subtype = subType;
    transition.type = type;
    transition.duration = duration;
    [view.layer addAnimation:transition forKey:@"layerAnimation"];
}


@end
