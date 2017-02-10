//
//  SWTxiansuoViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWTxiansuoViewControllerDelegate <NSObject>

- (void)didSelectXianSuo:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end


@class SWTZXZXMainViewController;
@interface SWTxiansuoViewController : UIViewController
@property (nonatomic, weak)SWTZXZXMainViewController *parentController;
@property (nonatomic, weak) id<SWTxiansuoViewControllerDelegate> delegate;
@end
