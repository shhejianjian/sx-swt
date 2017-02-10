//
//  SWTDYNewsCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTDYNewsCell.h"

@implementation SWTDYNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)selectedClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)setNewsColum:(SWTNewsColum *)newsColum {
    _newsColum = newsColum;
    self.titleLabel.text = newsColum.columnname;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
