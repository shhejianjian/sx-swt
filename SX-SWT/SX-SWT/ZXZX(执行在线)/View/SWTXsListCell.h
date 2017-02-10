//
//  SWTXsListCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTXsList.h"
@interface SWTXsListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *bjbrxmLabel;
@property (strong, nonatomic) IBOutlet UILabel *zxfymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *jbsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *hfztLabel;
@property (nonatomic, strong) SWTXsList *xsListModel;
@end
