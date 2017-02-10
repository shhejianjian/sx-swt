//
//  SWTBaseInfoViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWTBaseInfoViewControllerDelegate <NSObject>

- (void)didClickDownFileBtn:(NSString *)username andpwd:(NSString *)pwd andAjbs:(NSString *)ajbsStr;

@end


@class SWTWSDetailMainViewController;
@interface SWTBaseInfoViewController : UIViewController
@property (nonatomic, weak)SWTWSDetailMainViewController *parentController;
@property (strong, nonatomic) IBOutlet UITextField *downPwdTextField;
@property (strong, nonatomic) IBOutlet UITextField *downZjhmTextField;
@property (strong, nonatomic) IBOutlet UIButton *downBtn;

@property (nonatomic, weak) id <SWTBaseInfoViewControllerDelegate> delegate;

@end
