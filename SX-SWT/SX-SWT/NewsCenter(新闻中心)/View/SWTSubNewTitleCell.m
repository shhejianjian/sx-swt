//
//  SWTSubNewTitleCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSubNewTitleCell.h"

@implementation SWTSubNewTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.columlabel.layer.cornerRadius = 5;
    self.columlabel.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSubNewsModel:(SWTSubNews *)subNewsModel {
    _subNewsModel = subNewsModel;
    self.titleLabel.text = subNewsModel.New_title;
    self.columlabel.text = subNewsModel.column_name;
    self.timeLabel.text = [self covertToDateStringFromString:subNewsModel.create_date];
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
