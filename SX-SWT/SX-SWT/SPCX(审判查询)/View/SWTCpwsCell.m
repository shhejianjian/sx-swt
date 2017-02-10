//
//  SWTCpwsCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTCpwsCell.h"

@interface SWTCpwsCell ()
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *aymcLabel;

@property (strong, nonatomic) IBOutlet UILabel *dsrLabel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *larqLabel;

@end

@implementation SWTCpwsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSpcxListModel:(SWTSpcxList *)spcxListModel {
    _spcxListModel = spcxListModel;
    self.fymcLabel.text = [NSString stringWithFormat:@"立案法院：%@",spcxListModel.fymc];
    self.aymcLabel.text = [NSString stringWithFormat:@"案        由：%@",spcxListModel.laaymc];
    self.dsrLabel.text = [NSString stringWithFormat:@"立  案  人：%@",spcxListModel.larmc];
    self.ahqcLabel.text = [NSString stringWithFormat:@"案号：%@",spcxListModel.ahqc];
    self.larqLabel.text = [NSString stringWithFormat:@"立案日期：%@",spcxListModel.larq];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
