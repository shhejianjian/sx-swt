//
//  SWTbaoguangViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWTBgtList.h"
@protocol SWTbaoguangViewControllerDelegate <NSObject>

- (void)didSelectRow:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath andmdetailModel:(SWTBgtList *)mdetailModel;;

@end


@class SWTZXZXMainViewController;
@interface SWTbaoguangViewController : UIViewController
@property (nonatomic, weak)SWTZXZXMainViewController *parentController;
@property (nonatomic, weak) id<SWTbaoguangViewControllerDelegate> delegate;
@end
