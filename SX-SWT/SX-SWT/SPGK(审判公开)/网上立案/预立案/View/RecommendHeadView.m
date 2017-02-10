//
//  RecommendHeadView.m
//  DouYU
//
//  Created by Alesary on 15/11/2.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "RecommendHeadView.h"

@interface RecommendHeadView ()





@end

@implementation RecommendHeadView

-(id)init
{
    self=[[[NSBundle mainBundle]loadNibNamed:@"RecommendHeadView" owner:nil options:nil] firstObject];
    
    if (self) {
        self.addPartyBtn.layer.borderWidth = 1;
        self.addPartyBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.addPartyBtn.layer.cornerRadius = 5;
//        self.chooseBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:20];
//        [self.chooseBtn setTitle:@"\uf3aa" forState:UIControlStateNormal];
//        [self.chooseBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [self.chooseBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];

    }
    
    return self;
}
- (IBAction)addPartyBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickAddBtn:atSectionTag:)]) {
        [self.delegate clickAddBtn:self atSectionTag:sender.tag];
    }
    
}

@end
