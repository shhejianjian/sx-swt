//
//  SWTSecondCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSecondCell.h"
#import "SWTConst.h"
#import "UIImageView+WebCache.h"
#define screen_width [UIScreen mainScreen].bounds.size.width

@implementation SWTSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
           
    // Initialization code
}
- (void)setSubNewsModel:(SWTSubNews *)subNewsModel {
    _subNewsModel = subNewsModel;
    if ([subNewsModel.raw_name isEqualToString:@""] || [subNewsModel.raw_name isEqualToString:@"null"]) {
        self.titleLabel.hidden = YES;
    } else {
        self.titleLabel.text = [NSString stringWithFormat:@"(%@)", subNewsModel.raw_name];
    }
    
    
        if ([subNewsModel.fj_type isEqualToString:@"0"]) {
            [self.showImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,subNewsModel.save_name]]];
        } else if ( [subNewsModel.fj_type isEqualToString:@"1"]) {
            if ([subNewsModel.save_name hasSuffix:@"txt"]) {
                self.showImg.image = [UIImage imageNamed:@"txt"];
            } else if ([subNewsModel.save_name hasSuffix:@"doc"]){
                self.showImg.image = [UIImage imageNamed:@"doc"];
            }
        } else if ( [subNewsModel.fj_type isEqualToString:@"2"]) {
            self.showImg.image = [UIImage imageNamed:@"形状-1"];
            self.showImg.backgroundColor = [UIColor blackColor];
        } else if ( [subNewsModel.fj_type isEqualToString:@"3"]) {
            self.showImg.image = [UIImage imageNamed:@"voice"];
        }
    
}

- (void)setNewsInfoModel:(SWTSubNews *)newsInfoModel {
    _newsInfoModel = newsInfoModel;
    if ([newsInfoModel.column_name isEqualToString:@"通知公告"]) {
        if ([self.subNewsModel.save_name isEqualToString:@""] || [self.subNewsModel.save_name isEqualToString:@"null"]) {
            self.titleLabel.hidden = YES;
        } else {
            self.showImg.image = [UIImage imageNamed:@"doc"];
            self.titleLabel.text = [NSString stringWithFormat:@"(%@)", self.subNewsModel.save_name];
        }
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
