//
//  SWTTSGGCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTTSGGCell.h"

@interface SWTTSGGCell () 
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *slfyLabel;
@property (strong, nonatomic) IBOutlet UILabel *slftLabel;
@property (strong, nonatomic) IBOutlet UILabel *aymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *zsfgLabel;
@property (strong, nonatomic) IBOutlet UILabel *ktsjLabel;

@end


@implementation SWTTSGGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setTsggListModel:(SWTTsggList *)tsggListModel {
    _tsggListModel = tsggListModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"案号：%@",tsggListModel.ahqc];
    self.slftLabel.text = [NSString stringWithFormat:@"审理法庭：%@",tsggListModel.ftmc];
    self.slfyLabel.text = [NSString stringWithFormat:@"审理法院：%@",tsggListModel.fymc];
    self.aymcLabel.text = [NSString stringWithFormat:@"案       由：%@",tsggListModel.laaymc];
    self.zsfgLabel.text = [NSString stringWithFormat:@"主审法官：%@",tsggListModel.zsfg];
    self.ktsjLabel.text = [NSString stringWithFormat:@"开庭时间：%@",[self covertToDateStringFromString:tsggListModel.kssj]];

}

-(void)setBgtListModel:(SWTBgtList *)bgtListModel {
    _bgtListModel = bgtListModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"案号：%@",bgtListModel.ahqc];
    self.slftLabel.text = [NSString stringWithFormat:@"姓               名：%@",bgtListModel.xm];
    self.slfyLabel.text = [NSString stringWithFormat:@"法   院  名   称：%@",bgtListModel.fymc];
    self.aymcLabel.text = [NSString stringWithFormat:@"被执行人类型：%@",bgtListModel.bzxrlxmc];
    self.zsfgLabel.text = [NSString stringWithFormat:@"身 份 证 号 码：%@",bgtListModel.sfzjhm];
    self.ktsjLabel.text = [NSString stringWithFormat:@"立案日期：%@",[self covertToDateStringFromString:bgtListModel.systime]];
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
