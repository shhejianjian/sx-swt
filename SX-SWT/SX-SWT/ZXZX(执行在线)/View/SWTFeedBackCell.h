//
//  SWTFeedBackCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/19.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTSSzxList.h"
@interface SWTFeedBackCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cjsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet UILabel *replayLabel;
@property (strong, nonatomic) IBOutlet UILabel *hfsjLabel;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (nonatomic, strong) SWTSSzxList *sszxListModel;
@property (nonatomic, assign) CGFloat cellHeight;
@property (strong, nonatomic) IBOutlet UIImageView *markImageView;

@end
