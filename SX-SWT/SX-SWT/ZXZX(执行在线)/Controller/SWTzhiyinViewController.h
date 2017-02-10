//
//  SWTzhiyinViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol SWTzhiyinViewControllerDelegate <NSObject>

- (void)didSelect:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end


@class SWTZXZXMainViewController;
@interface SWTzhiyinViewController : UIViewController
@property (nonatomic, weak)SWTZXZXMainViewController *parentController;
@property (nonatomic, weak) id<SWTzhiyinViewControllerDelegate> delegate;
@end
