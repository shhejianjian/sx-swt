//
//  SWTcxFirstViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWTspcxMainViewControllerDelegate <NSObject>

- (void)didSelect;
- (void)clickCXBtnWithAhqc:(NSString *)ahqc andNdh:(NSString *)ndh andFymc:(NSString *)fymc andLaay:(NSString *)laay;
@end


@class SWTspcxMainViewController;





@interface SWTcxFirstViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nianHaoTextField;
@property (strong, nonatomic) IBOutlet UITextField *fyqcTextField;
@property (strong, nonatomic) IBOutlet UITextField *zihaoTextField;
@property (strong, nonatomic) IBOutlet UITextField *ayqcTextField;
@property (nonatomic, weak)id<SWTspcxMainViewControllerDelegate> delegate;

@property (nonatomic, weak)SWTspcxMainViewController *parentController;

@end
