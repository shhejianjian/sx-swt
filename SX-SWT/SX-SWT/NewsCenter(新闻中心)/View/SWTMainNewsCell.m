//
//  SWTMainNewsCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTMainNewsCell.h"
#import "SWTMainNews.h"
#import "UIImageView+WebCache.h"
#import "SWTConst.h"
@interface SWTMainNewsCell ()
@property (strong, nonatomic) IBOutlet UIImageView *showNewsImg;
@property (strong, nonatomic) IBOutlet UILabel *newsTitle;
@property (strong, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation SWTMainNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMainNews:(SWTMainNews *)mainNews {
    _mainNews = mainNews;
    self.newsTitle.text = mainNews.New_title;
    self.detailLabel.text = mainNews.column_name;
    self.creatTimeLabel.text = [self covertToDateStringFromString:mainNews.create_date];
    [self.showNewsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageUrl,mainNews.save_name]]];
    if ([mainNews.column_name isEqualToString:@"法院新闻"]) {
        [self.showNewsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/swt/newinfo/appShowImg?imgpath=%@",FyNewsImageUrl,mainNews.path]]];
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
