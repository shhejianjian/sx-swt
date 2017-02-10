//
//  SWTAddInfoViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWTAddInfoViewControllerDelegate <NSObject>

- (void)didSelectWithLdhmStr:(NSString *)ldhm andXbStr:(NSString *)xb andAgeStr:(NSString *)age andZyStr:(NSString *)zy andWhcdStr:(NSString *)whcd andJjdzStr:(NSString *)jzdz andNrzyStr:(NSString *)nrzy;

@end

@class SWTRXMainViewController;

@interface SWTAddInfoViewController : UIViewController
@property (nonatomic, weak)SWTRXMainViewController *parentController;

@property (nonatomic, weak) id<SWTAddInfoViewControllerDelegate> delegate;

@end
