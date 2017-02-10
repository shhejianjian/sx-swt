//
//  SWTBookArriveCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTBookArriveCell.h"
#import "SWTConst.h"
@implementation SWTBookArriveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ckxqBtn.layer.borderWidth = 1;
    self.ckxqBtn.layer.borderColor = SWTRedColor.CGColor;
    self.detailView.layer.borderWidth = 1;
    self.detailView.layer.borderColor = SWTRedColor.CGColor;
    
    // Initialization code
}

- (void)setDzwsModel:(SWTDZWS *)dzwsModel {
    _dzwsModel = dzwsModel;
    self.ahqcLabel.text = dzwsModel.ahqc;
    self.wjmcLabel.text = dzwsModel.wjmc;
    self.wjlxLabel.text = dzwsModel.wjlx;
    self.sdrqlabel.text = [self covertToDateStringFromString:dzwsModel.sjsdrq];
    self.ssdrLabel.text = dzwsModel.ssdr;
}

- (IBAction)clickToDetail:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelect:atIndexPath:)]) {
        [self.delegate didSelect:self atIndexPath:sender.tag];
    }
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
