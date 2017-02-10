//
//  SWTThirdCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTThirdCell.h"


#define sFont [UIFont systemFontOfSize:15]
#define MaxWidth [UIScreen mainScreen].bounds.size.width - 10 -30
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@implementation SWTThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSubNewsModel:(SWTSubNews *)subNewsModel {
    _subNewsModel = subNewsModel;
//    if ([subNewsModel.column_name isEqualToString:@"法院新闻"]) {
    if (ScreenHeight == 736) {
        self.cellHeight = 500;
    } else {
        self.cellHeight = 400;
    }
//    } else {
        self.contentLabel.hidden = YES;
//        self.contentLabel.text = subNewsModel.content;
//        CGSize addressLabelSize = [self sizeWithText:self.contentLabel.text Font:sFont MaxW:MaxWidth];
//        self.cellHeight = 35 + addressLabelSize.height + 10 ;
//    }
}
- (CGSize)sizeWithText:(NSString *)text Font:(UIFont *)font MaxW:(CGFloat)maxW
{
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    attr[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
