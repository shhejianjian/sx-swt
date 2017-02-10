//
//  SWTLXFSCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTLXFSCell.h"

@interface SWTLXFSCell ()



@end

@implementation SWTLXFSCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)lxdhBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelect:atIndexPath:)]) {
        [self.delegate didSelect:self atIndexPath:sender.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
