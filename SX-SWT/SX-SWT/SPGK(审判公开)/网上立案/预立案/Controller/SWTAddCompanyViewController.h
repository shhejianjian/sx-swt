//
//  SWTAddCompanyViewController.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTDsrInfo.h"
@interface SWTAddCompanyViewController : UIViewController
@property (nonatomic, copy) NSString *ylaIndoId;
@property (nonatomic, strong) SWTDsrInfo *companyDsrInfoModel;
@property (nonatomic, strong) SWTDsrInfo *checkStatusInfoModel;

@end
