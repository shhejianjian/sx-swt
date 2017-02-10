//
//  SWTGSForthViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTFYGSMainViewController.h"

@protocol SWTGSForthViewControllerDelegate <NSObject>

- (void)didSelectForth:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end

@interface SWTGSForthViewController : UIViewController
@property (nonatomic, weak) SWTFYGSMainViewController *parentController;
@property (nonatomic, weak) id<SWTGSForthViewControllerDelegate> delegate;
@end
