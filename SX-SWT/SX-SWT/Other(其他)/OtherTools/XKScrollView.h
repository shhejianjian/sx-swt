//
//  XKScrollView.h
//  MyScrollViewTest
//
//  Created by Apple on 16/7/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XKScrollView : UIView<UIScrollViewDelegate>
/**
 *  滚动视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  pageControl小圆点
 */
@property (nonatomic, strong) UIPageControl *pageControl;
/**
 *  当前显示的图片
 */
@property (nonatomic, strong)UIImageView *currentImgView;
/**
 *  上一张图片
 */

@property (nonatomic,strong)UIImageView *preImgView;
/**
 *  下一张图片
 */

@property (nonatomic,strong)UIImageView *nexImgView;
/**
 *  图片数据源
 */
@property (nonatomic,strong)NSMutableArray *picModles;
/**
 *  Block 回调点击图片
 */
@property (nonatomic ,copy) void (^myTapCurrentImgBlock) (NSInteger index);
/**
 *  计时器
 */
@property (nonatomic, strong)NSTimer *timer;

/**
 *  初始化方法
 * @param frame  
 * @param 滚动视图的高度
 */
-(instancetype)initWithFrame:(CGRect)frame withScrollHeight:(CGFloat)aheight;

-(void)removTimer;

-(void)startTimer;

@end

