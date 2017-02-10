//
//  SWTSfwtCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWTSfwtCell;
@protocol SWTSfwtCellDelegate <NSObject>

- (void)didSelect:(SWTSfwtCell *)cell atIndexPath:(NSInteger)index;

@end

@interface SWTSfwtCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *detailBtn;
@property (strong, nonatomic) IBOutlet UILabel *isSuccessLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak)id<SWTSfwtCellDelegate> delegate;
@end
