//
//  SWTNewsTableViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol mainNewsTableDidSelectDelegate <NSObject>

- (void)didSelect:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end

@class SWTNewsViewController;
@interface SWTNewsTableViewController : UIViewController
@property (nonatomic, weak)SWTNewsViewController *parentController;
@property (nonatomic, weak)id<mainNewsTableDidSelectDelegate> delegate;

@property (nonatomic, copy)NSString *MyIdStr;

@end
