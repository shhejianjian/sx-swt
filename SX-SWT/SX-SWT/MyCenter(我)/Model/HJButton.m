//
//  HJButton.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/31.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "HJButton.h"

@implementation HJButton
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.layer.cornerRadius = 5;
//        self.layer.masksToBounds = YES;
//    }
//    return self;
//}
+(id)buttonWithType:(UIButtonType)type{
    //    [super buttonWithType:type];
    //    self = [super buttonWithType:type];
    HJButton * btn = [super buttonWithType:type];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"Default.png"] forState:UIControlStateNormal];
    return btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
