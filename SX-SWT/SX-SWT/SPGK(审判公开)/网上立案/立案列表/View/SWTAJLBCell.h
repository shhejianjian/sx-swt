//
//  SWTAJLBCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWTAJLB;
@interface SWTAJLBCell : UITableViewCell
@property (nonatomic, strong) SWTAJLB *AJLBModel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@end
