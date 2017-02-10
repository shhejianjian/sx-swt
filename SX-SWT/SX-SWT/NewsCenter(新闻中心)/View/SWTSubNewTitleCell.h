//
//  SWTSubNewTitleCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTSubNews.h"
@interface SWTSubNewTitleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *columlabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) SWTSubNews *subNewsModel;

@end
