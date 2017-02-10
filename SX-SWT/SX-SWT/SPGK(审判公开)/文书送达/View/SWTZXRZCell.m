//
//  SWTZXRZCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/17.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTZXRZCell.h"

@implementation SWTZXRZCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setZxrzListModel:(SWTZxrzList *)zxrzListModel {
    _zxrzListModel = zxrzListModel;
    self.zxrLabel.text = [NSString stringWithFormat:@"执  行  人：%@", zxrzListModel.username];
    self.ajztLabel.text = [NSString stringWithFormat:@"办理状态：%@", zxrzListModel.nodename];
    self.kssjLabel.text = [NSString stringWithFormat:@"开始时间：%@", [self covertToDateStringFromString:zxrzListModel.kssj]];
    self.jssjLabel.text = [NSString stringWithFormat:@"法院名称：%@",zxrzListModel.fymc];
    if (!zxrzListModel.jssj) {
        self.fymcLabel.hidden = YES;
    }else {
        self.fymcLabel.text = [NSString stringWithFormat:@"结束时间：%@", [self covertToDateStringFromString:zxrzListModel.jssj]];
    }
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
