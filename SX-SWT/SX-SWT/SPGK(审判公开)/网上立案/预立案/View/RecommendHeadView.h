//
//  RecommendHeadView.h
//  DouYU
//
//  Created by Alesary on 15/11/2.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecommendHeadView;
@protocol recommedDelegate <NSObject>

- (void)clickAddBtn:(RecommendHeadView *)view atSectionTag:(NSInteger)sectionTag;

@end

@interface RecommendHeadView : UIView

@property (strong, nonatomic) IBOutlet UIButton *chooseBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *addPartyBtn;

@property (nonatomic, weak) id<recommedDelegate> delegate;

@end
