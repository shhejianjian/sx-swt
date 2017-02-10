//
//  SWTXFListCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXFListCell.h"

@interface SWTXFListCell ()
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *namelabel;
@property (strong, nonatomic) IBOutlet UILabel *sflabel;
@property (strong, nonatomic) IBOutlet UILabel *fymclabel;
@property (strong, nonatomic) IBOutlet UILabel *xfmdLabel;
@property (strong, nonatomic) IBOutlet UILabel *hfztLabel;

@end

@implementation SWTXFListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setXfListModel:(SWTXFList *)xfListModel {
    _xfListModel = xfListModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"案号：%@",xfListModel.ahqc];
    self.namelabel.text = [NSString stringWithFormat:@"姓        名：%@",xfListModel.mc];
    self.sflabel.text = [NSString stringWithFormat:@"信访身份：%@",xfListModel.xfrsfmc];
    self.fymclabel.text = [NSString stringWithFormat:@"信访法院：%@",xfListModel.fymc];
    self.xfmdLabel.text = [NSString stringWithFormat:@"信访目的：%@",xfListModel.xfmdmc];
    self.hfztLabel.text = [NSString stringWithFormat:@"回复状态：%@",xfListModel.clztmc];
}

//- (void)setFjListModel:(SWTXsFjList *)fjListModel {
//    _fjListModel = fjListModel;
//    self.ahqcLabel.text = [NSString stringWithFormat:@"线索类型：%@",fjListModel.mlmc];
//    self.namelabel.text = [NSString stringWithFormat:@"文件名称：%@",fjListModel.ywjm];
////    self.sflabel.text = [NSString stringWithFormat:@"内容：%@",fjListModel.content];
//    self.sflabel.text = [NSString stringWithFormat:@"创建时间：%@",[self covertToDateStringFromString:fjListModel.systime]];
//    self.fymclabel.hidden = YES;
//    self.xfmdLabel.hidden = YES;
//    self.hfztLabel.hidden = YES;
////    self.xfmdLabel.text = [NSString stringWithFormat:@"信访目的：%@",fjListModel.xfmd];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSString *)covertToDateStringFromString:(NSString *)Str
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[[Str substringWithRange:NSMakeRange(0, 13)]longLongValue]/1000.0];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [dateFormatter stringFromDate:date];
}

@end
