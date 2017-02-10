//
//  SWTVideoCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/18.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTVideoCell.h"

@implementation SWTVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.playBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:30];
    [self.playBtn setTitle:@"\uf3aa" forState:UIControlStateNormal];
    // Initialization code
}
- (IBAction)playBtnClick:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
