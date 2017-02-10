//
//  SWTAddPlaintiffViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/26.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTDsrInfo.h"

@interface SWTAddPlaintiffViewController : UIViewController
@property (nonatomic, copy) NSString *ylaIndoId;
@property (nonatomic, strong) SWTDsrInfo *myDsrInfoModel;
@property (nonatomic, strong) SWTDsrInfo *checkStatusInfoModel;
@end
