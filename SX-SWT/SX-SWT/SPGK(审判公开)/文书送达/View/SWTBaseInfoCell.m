//
//  SWTBaseInfoCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/3.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTBaseInfoCell.h"

@interface SWTBaseInfoCell ()


@end

@implementation SWTBaseInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setWsDetailModel:(SWTWsDetail *)wsDetailModel {
    _wsDetailModel = wsDetailModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"案号全称：%@",wsDetailModel.ahqc];
    self.larLabel.text = [NSString stringWithFormat:@"案件字号：%@",wsDetailModel.sabzzhmc];
    self.larqLabel.text = [NSString stringWithFormat:@"类别：%@",wsDetailModel.ajlbmc];
    self.laayLabel.text = [NSString stringWithFormat:@"案件来源：%@",wsDetailModel.ajlymc];
    self.labmLabel.text = [NSString stringWithFormat:@"收案日期：%@",wsDetailModel.szrq];
    self.lbLabel.text = [NSString stringWithFormat:@"立案日期：%@",wsDetailModel.larq];
    self.spcxLabel.text = [NSString stringWithFormat:@"立案案由：%@",wsDetailModel.laaymc];
    self.eightLabel.text = [NSString stringWithFormat:@"立案人：%@",wsDetailModel.larmc];
    self.nineLabel.text = [NSString stringWithFormat:@"立案部门：%@",wsDetailModel.labmmc];
    self.tenLabel.text = [NSString stringWithFormat:@"诉讼标的额：%@(元)",wsDetailModel.gsbd];
    self.elevenLabel.text = [NSString stringWithFormat:@"案件受理费：%@(元)",wsDetailModel.yzxdje];
    self.twlveLabel.text = [NSString stringWithFormat:@"承办部门：%@",wsDetailModel.cbbm];
    self.thirteenLabel.text = [NSString stringWithFormat:@"开庭时间："];
    self.forteenLabel.text = [NSString stringWithFormat:@"结案日期：%@",wsDetailModel.jarq];
    self.fifteenLabel.text = [NSString stringWithFormat:@"结案案由：%@",wsDetailModel.jaaymc];
    self.sixTeenLabel.text = [NSString stringWithFormat:@"结案方式：%@",wsDetailModel.jafsmc];
    self.jieduanLabel.text = [NSString stringWithFormat:@"案件阶段：%@",wsDetailModel.lcztmc];
}

- (void)setDsrDetailModel:(SWTDsrDetail *)dsrDetailModel {
    _dsrDetailModel = dsrDetailModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"当事人姓名：%@",dsrDetailModel.mc];
    [NSString stringWithFormat:@"类            型：%@",dsrDetailModel.lxmc];
    self.larLabel.text = [NSString stringWithFormat:@"诉 讼  地 位：%@",dsrDetailModel.ssdwmc];
    
    self.larqLabel.text = [NSString stringWithFormat:@"类            型：%@",dsrDetailModel.lxmc];
    self.laayLabel.text = [NSString stringWithFormat:@"法定代表人：%@",dsrDetailModel.fddbr];

//    self.laayLabel.text = [NSString stringWithFormat:@"国            籍：%@",dsrDetailModel.gjmc];
    self.labmLabel.text = [NSString stringWithFormat:@"国            籍：%@",dsrDetailModel.gjmc];
    self.lbLabel.text = [NSString stringWithFormat:@"民            族：%@",dsrDetailModel.mzmc];
    self.spcxLabel.text = [NSString stringWithFormat:@"性            别：%@",dsrDetailModel.xbmc];

}

- (void)setSpzzDetailModel:(SWTSpzzDetail *)spzzDetailModel {
    _spzzDetailModel = spzzDetailModel;
    self.ahqcLabel.text = [NSString stringWithFormat:@"姓        名：%@",spzzDetailModel.xm];
    self.larLabel.text = [NSString stringWithFormat:@"标准字号：%@",spzzDetailModel.bzzh];
    self.larqLabel.text = [NSString stringWithFormat:@"法院名称：%@",spzzDetailModel.fymc];
    self.laayLabel.text = [NSString stringWithFormat:@"担任角色：%@",spzzDetailModel.js];
//    self.labmLabel.text = [NSString stringWithFormat:@"结案方式：%@",spzzDetailModel.jafsmc];
//    self.lbLabel.text = [NSString stringWithFormat:@"案件来源：%@",spzzDetailModel.ajlymc];
//    self.spcxLabel.text = [NSString stringWithFormat:@"审判程序：%@",spzzDetailModel.spcxmc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
