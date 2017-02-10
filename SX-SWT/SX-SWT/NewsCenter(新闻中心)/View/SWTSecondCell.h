//
//  SWTSecondCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTSubNews.h"




@interface SWTSecondCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (nonatomic, strong) SWTSubNews *subNewsModel;
@property (nonatomic, strong) SWTSubNews *newsInfoModel;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property(strong, nonatomic)UIButton *videoBackButton;

@property(strong, nonatomic)NSString *videoPath;
@end
