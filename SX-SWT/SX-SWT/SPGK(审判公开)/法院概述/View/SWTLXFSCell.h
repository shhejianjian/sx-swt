//
//  SWTLXFSCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWTLXFSCell;
@protocol SWTLXFSCellDelegate <NSObject>

- (void)didSelect:(SWTLXFSCell *)cell atIndexPath:(NSInteger)index;

@end


@interface SWTLXFSCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *fydzLabel;
@property (strong, nonatomic) IBOutlet UIButton *lxdhBtn;
@property (strong, nonatomic) IBOutlet UIImageView *mapImg;
@property (nonatomic, weak)id<SWTLXFSCellDelegate> delegate;

@end
