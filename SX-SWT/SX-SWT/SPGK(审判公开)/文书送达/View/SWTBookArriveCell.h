//
//  SWTBookArriveCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTDZWS.h"

@class SWTBookArriveCell;
@protocol SWTBookArriveCellDelegate <NSObject>

- (void)didSelect:(SWTBookArriveCell *)cell atIndexPath:(NSInteger)index;

@end

@interface SWTBookArriveCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (nonatomic, weak)id<SWTBookArriveCellDelegate> delegate;

@property (nonatomic, strong) SWTDZWS *dzwsModel;

@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;

@property (strong, nonatomic) IBOutlet UILabel *wjmcLabel;
@property (strong, nonatomic) IBOutlet UILabel *wjlxLabel;
@property (strong, nonatomic) IBOutlet UILabel *sdrqlabel;
@property (strong, nonatomic) IBOutlet UILabel *ssdrLabel;

@property (strong, nonatomic) IBOutlet UIButton *ckxqBtn;

@end
