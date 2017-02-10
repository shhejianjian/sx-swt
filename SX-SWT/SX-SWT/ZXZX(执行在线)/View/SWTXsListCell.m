//
//  SWTXsListCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXsListCell.h"

@implementation SWTXsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setXsListModel:(SWTXsList *)xsListModel {
    _xsListModel = xsListModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"案号：%@",xsListModel.ahqc];
    self.bjbrxmLabel.text = [NSString stringWithFormat:@"被举报人姓名：%@",xsListModel.bjbrmc];
    self.zxfymcLabel.text = [NSString stringWithFormat:@"执  行   法  院：%@",xsListModel.fymc];
    self.hfztLabel.text = [NSString stringWithFormat:@"回  复   状  态：%@",xsListModel.hfztmc];
    self.jbsjLabel.text = [NSString stringWithFormat:@"举报时间：%@",[self covertToDateStringFromString:xsListModel.systime]];
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
