//
//  XYCenterButton.m
//  busale
//
//  Created by 谢琰 on 16/1/11.
//  Copyright © 2016年 busale. All rights reserved.
//  自定义控件 使UIButton中的图片和文字 垂直显示

#import "XYCenterButton.h"
#import "UIView+Extension.h"
@implementation XYCenterButton
-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.centerX = self.frame.size.width/2+5;
    self.imageView.centerY = self.frame.size.height/2 - 17;
    self.imageView.width = self.frame.size.width/3;
    self.imageView.height = self.frame.size.height/2;
    self.titleLabel.centerX = self.frame.size.width/2;
    self.titleLabel.centerY = self.frame.size.height/2 + 25;
}
@end
