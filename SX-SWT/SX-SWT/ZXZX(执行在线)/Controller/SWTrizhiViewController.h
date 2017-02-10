//
//  SWTrizhiViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWTrizhiViewControllerDelegate <NSObject>

- (void)didSelect;
- (void)clickCXBtnWithAhqc:(NSString *)ahqc andNdh:(NSString *)ndh andFymc:(NSString *)fymc andLaay:(NSString *)laay;
@end



@class SWTZXZXMainViewController;
@interface SWTrizhiViewController : UIViewController
@property (nonatomic, weak)SWTZXZXMainViewController *parentController;
@property (nonatomic, weak)id<SWTrizhiViewControllerDelegate> delegate;

@end
