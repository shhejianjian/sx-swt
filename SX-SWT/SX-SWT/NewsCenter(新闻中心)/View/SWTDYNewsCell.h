//
//  SWTDYNewsCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTNewsColum.h"


@interface SWTDYNewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectedBtn;
@property (nonatomic, strong) SWTNewsColum *newsColum;
@end
