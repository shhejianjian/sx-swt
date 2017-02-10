//
//  SWTPartyCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTPartyCell.h"

@implementation SWTPartyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDsrInfoModel:(SWTDsrInfo *)dsrInfoModel {
    _dsrInfoModel = dsrInfoModel;
    self.nameLabel.text = dsrInfoModel.mc;
    self.sexLabel.text = dsrInfoModel.xbmc;
    self.ssdwLabel.text = dsrInfoModel.ssdwmc;
}

- (void)setCompanyDsrInfoModel:(SWTDsrInfo *)companyDsrInfoModel {
    _companyDsrInfoModel = companyDsrInfoModel;
    self.nameLabel.text = companyDsrInfoModel.mc;
    self.sexLabel.text = companyDsrInfoModel.zzdz;
    self.ssdwLabel.text = companyDsrInfoModel.ssdwmc;
}

- (void)setSsclModel:(SWTSscl *)ssclModel {
    _ssclModel = ssclModel;
    self.nameLabel.text = ssclModel.clfilename;
    self.sexLabel.text = ssclModel.cllb;
    self.ssdwLabel.text = [self covertToDateStringFromString:ssclModel.createtime];
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
