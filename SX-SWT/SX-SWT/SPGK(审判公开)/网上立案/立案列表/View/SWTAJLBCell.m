//
//  SWTAJLBCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAJLBCell.h"
#import "SWTAJLB.h"
#import "SWTConst.h"
@interface SWTAJLBCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;


@end

@implementation SWTAJLBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.detailView.layer.cornerRadius = 5.0f;
    self.detailView.layer.borderWidth = 1.0f;
    self.detailView.layer.borderColor = SWTRedColor.CGColor;
    // Initialization code
}

- (void)setAJLBModel:(SWTAJLB *)AJLBModel {
    _AJLBModel = AJLBModel;
    self.fymcLabel.text = AJLBModel.fymc;
    self.typeLabel.text = AJLBModel.ajlbmc;
    self.dateLabel.text = [self covertToDateStringFromString:AJLBModel.sysTime];
    self.statusLabel.text = AJLBModel.sqrmc;
    self.titleLabel.text = [NSString stringWithFormat:@"案件全称：%@",AJLBModel.ajbhqc];
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
