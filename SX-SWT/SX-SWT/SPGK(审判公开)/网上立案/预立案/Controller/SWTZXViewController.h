//
//  SWTZXViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTAJLB.h"
@interface SWTZXViewController : UIViewController
@property (nonatomic, copy) NSString *ajTypeStr;
@property (nonatomic, copy) NSString *lafymcStr;
@property (nonatomic, copy) NSString *lafyDMStr;
@property (nonatomic, strong) SWTAJLB *ajlbModel;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

@end
