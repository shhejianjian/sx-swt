//
//  SWTPartyCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTDsrInfo.h"
#import "SWTSscl.h"
@interface SWTPartyCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *ssdwLabel;
@property (strong, nonatomic) IBOutlet UILabel *xzOrxbLabel;
@property (nonatomic, strong) SWTDsrInfo *dsrInfoModel;
@property (nonatomic, strong) SWTDsrInfo *companyDsrInfoModel;
@property (strong, nonatomic) IBOutlet UILabel *nameLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *ssdwLeftLabel;
@property (nonatomic, strong) SWTSscl *ssclModel;
@end
