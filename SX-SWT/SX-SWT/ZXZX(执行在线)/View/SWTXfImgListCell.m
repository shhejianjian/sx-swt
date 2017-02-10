//
//  SWTXfImgListCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXfImgListCell.h"
#import "UIImageView+WebCache.h"
#import "SWTConst.h"

@implementation SWTXfImgListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setXfImgListModel:(SWTXFImgList *)xfImgListModel {
    _xfImgListModel = xfImgListModel;
    [self.showImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/xfinfo/appGetshowImg?wjmc=%@",BaseUrl,xfImgListModel.wjmc]]];
    self.nameLabel.text = xfImgListModel.ywjm;
    self.mlmcLabel.text = xfImgListModel.mlmc;
    self.timeLabel.text = [self covertToDateStringFromString:xfImgListModel.systime];
}

- (void)setSsclListModel:(SWTXFImgList *)ssclListModel {
    _ssclListModel = ssclListModel;
    [self.showImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/xfinfo/appGetshowImg?wjmc=%@",BaseUrl,ssclListModel.wjmc]]];
    self.nameLabel.text = ssclListModel.ywjm;
    self.mlmcLabel.text = ssclListModel.mlmc;
    self.timeLabel.text = [self covertToDateStringFromString:ssclListModel.sysTime];
}

- (void)setFjListModel:(SWTXsFjList *)fjListModel {
    _fjListModel = fjListModel;
    [self.showImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/xfinfo/appGetshowImg?wjmc=%@",BaseUrl,fjListModel.wjmc]]];
    self.nameLabel.text = fjListModel.ywjm;
    self.mlmcLabel.text = fjListModel.mlmc;
    self.timeLabel.text = [self covertToDateStringFromString:fjListModel.systime];
}

- (NSString *)covertToDateStringFromString:(NSString *)Str
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[[Str substringWithRange:NSMakeRange(0, 13)]longLongValue]/1000.0];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [dateFormatter stringFromDate:date];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
