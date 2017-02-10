//
//  SWTPlayVoiceViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/22.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTSubNews.h"
@interface SWTPlayVoiceViewController : UIViewController
@property (nonatomic, copy) NSString *myFilePath;
@property (nonatomic, strong) SWTSubNews *subNewsModel;
@end
