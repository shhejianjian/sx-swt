//
//  SWTXFListCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTXFList.h"
#import "SWTXsFjList.h"

@interface SWTXFListCell : UITableViewCell
@property (nonatomic, strong) SWTXFList *xfListModel;
@property (nonatomic, strong) SWTXsFjList *fjListModel;
@end
