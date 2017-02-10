//
//  SWTSubNewsViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTNewsLunBo.h"

@class SWTMainNews;

@interface SWTSubNewsViewController : UIViewController
@property (nonatomic, strong) SWTNewsLunBo *mainLbModel;
@property (nonatomic, strong) SWTMainNews *NewsModel;
@end
