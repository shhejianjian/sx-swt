//
//  SWTZXRZCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/17.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTZxrzList.h"
@interface SWTZXRZCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *zxrLabel;
@property (strong, nonatomic) IBOutlet UILabel *ajztLabel;
@property (strong, nonatomic) IBOutlet UILabel *kssjLabel;
@property (strong, nonatomic) IBOutlet UILabel *jssjLabel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (nonatomic, strong) SWTZxrzList *zxrzListModel;
@end
