//
//  SWTFeedBackCell.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/19.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTFeedBackCell.h"
#import "SWTConst.h"
#define MaxWidth [UIScreen mainScreen].bounds.size.width - 2 *20
#define sFont [UIFont systemFontOfSize:15]
#define bFont [UIFont systemFontOfSize:15]
@implementation SWTFeedBackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 10;
    
    // Initialization code
}

- (void)setSszxListModel:(SWTSSzxList *)sszxListModel {
    _sszxListModel = sszxListModel;
    self.questionLabel.text = sszxListModel.question;
    if ([sszxListModel.answer isEqualToString:@"<null>"] || sszxListModel.answer == NULL) {
        self.markImageView.hidden = YES;
        self.hfsjLabel.hidden = YES;
        self.replayLabel.text = @"您的咨询我们已经收到，24小时内给予答复。";
        CGSize requestSize = [self sizeWithText:self.questionLabel.text Font:sFont MaxW:MaxWidth];
        CGSize replySize = [self sizeWithText:self.replayLabel.text Font:sFont MaxW:MaxWidth];
        self.cellHeight = 100 + requestSize.height +  replySize.height ;
    }else{
        self.replayLabel.font = bFont;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复:%@",sszxListModel.answer]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0,3)];
        [str addAttribute:NSForegroundColorAttributeName value:SWTRedColor range:NSMakeRange(0,3)];
        self.replayLabel.attributedText = str;
        
        self.markImageView.hidden = NO;
        self.hfsjLabel.hidden = NO;
        self.hfsjLabel.text = sszxListModel.answer_time;
        CGSize requestSize = [self sizeWithText:self.questionLabel.text Font:sFont MaxW:MaxWidth -20];
        CGSize replySize = [self sizeWithText:self.replayLabel.text Font:bFont MaxW:MaxWidth];
        self.cellHeight = 100 + requestSize.height + replySize.height ;
    }
    self.cjsjLabel.text = sszxListModel.ques_time;
    
    
}
- (CGSize)sizeWithText:(NSString *)text Font:(UIFont *)font MaxW:(CGFloat)maxW
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
