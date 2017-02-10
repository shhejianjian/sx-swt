//
//  SWTBgtDetailCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/18.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTBgtDetailCell.h"

@interface SWTBgtDetailCell ()
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *xmLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *sfzhmlabel;
@property (strong, nonatomic) IBOutlet UILabel *larqLabel;
@property (strong, nonatomic) IBOutlet UILabel *bzxrlxLabel;
@property (strong, nonatomic) IBOutlet UILabel *cjsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *zxyjwhLabel;
@property (strong, nonatomic) IBOutlet UILabel *yjwhdwlabel;
@property (strong, nonatomic) IBOutlet UILabel *fddbr;
@property (strong, nonatomic) IBOutlet UILabel *lxqkLabel;
@property (strong, nonatomic) IBOutlet UILabel *dyLabel;
@property (strong, nonatomic) IBOutlet UILabel *sxywLabel;


@end

@implementation SWTBgtDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailBgListModel:(SWTBgtList *)detailBgListModel {
    _detailBgListModel = detailBgListModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"案号全称：%@",detailBgListModel.ahqc];
    self.xmLabel.text = [NSString stringWithFormat:@"姓名：%@",detailBgListModel.xm];
    self.ageLabel.text = [NSString stringWithFormat:@"年龄：%@",detailBgListModel.age];
    self.fymcLabel.text = [NSString stringWithFormat:@"所属法院：%@",detailBgListModel.fymc];
    self.sfzhmlabel.text = [NSString stringWithFormat:@"身份证号码：%@",detailBgListModel.sfzjhm];
    self.larqLabel.text = [NSString stringWithFormat:@"立案日期：%@",[self covertToDateStringFromString:detailBgListModel.larq]];
    self.bzxrlxLabel.text = [NSString stringWithFormat:@"被执行人类型：%@",detailBgListModel.bzxrlxmc];
    self.cjsjLabel.text = [NSString stringWithFormat:@"创建时间：%@",[self covertToDateStringFromString:detailBgListModel.cjsj]];
    self.zxyjwhLabel.text = [NSString stringWithFormat:@"执行依据文号：%@",detailBgListModel.zxyjwh];
    self.yjwhdwlabel.text = [NSString stringWithFormat:@"执行依据文号单位：%@",detailBgListModel.zxyjwhdw];
    if ([detailBgListModel.fddbr isEqualToString:@"null"]) {
        self.fddbr.text = @"法定代表人：";
    } else {
        self.fddbr.text = [NSString stringWithFormat:@"法定代表人：%@",detailBgListModel.fddbr];
    }
    self.lxqkLabel.text = [NSString stringWithFormat:@"履行情况：%@",detailBgListModel.lxqkmc];
    self.dyLabel.text = [NSString stringWithFormat:@"地域：%@",detailBgListModel.dymc];
    self.sxywLabel.text = [NSString stringWithFormat:@"失信业务：%@",detailBgListModel.sxyw];

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
