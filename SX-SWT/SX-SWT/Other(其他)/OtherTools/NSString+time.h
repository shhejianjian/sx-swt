//
//  NSString+time.h
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/12.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (time)

// 播放器_时间转换
+ (NSString *)convertTime:(CGFloat)second;
//判断手机号码
+ (BOOL)valiMobile:(NSString *)mobile;
//判断身份证号码
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;
@end
