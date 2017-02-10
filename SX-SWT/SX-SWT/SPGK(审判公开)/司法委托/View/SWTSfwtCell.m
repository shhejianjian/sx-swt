//
//  SWTSfwtCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSfwtCell.h"

@implementation SWTSfwtCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)detailClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelect:atIndexPath:)]) {
        [self.delegate didSelect:self atIndexPath:sender.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
