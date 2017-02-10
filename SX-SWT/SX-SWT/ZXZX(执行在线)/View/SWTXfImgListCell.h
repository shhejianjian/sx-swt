//
//  SWTXfImgListCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTXFImgList.h"
#import "SWTXsFjList.h"
@interface SWTXfImgListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *mlmcLabel;

@property (nonatomic, strong) SWTXsFjList *fjListModel;
@property (nonatomic, strong) SWTXFImgList *ssclListModel;

@property (nonatomic, strong) SWTXFImgList *xfImgListModel;
@end
