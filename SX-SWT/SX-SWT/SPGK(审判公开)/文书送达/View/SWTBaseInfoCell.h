//
//  SWTBaseInfoCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/3.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTWsDetail.h"
#import "SWTDsrDetail.h"
#import "SWTSpzzDetail.h"
@interface SWTBaseInfoCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *spcxLabel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *larLabel;
@property (strong, nonatomic) IBOutlet UILabel *larqLabel;
@property (strong, nonatomic) IBOutlet UILabel *laayLabel;
@property (strong, nonatomic) IBOutlet UILabel *labmLabel;
@property (strong, nonatomic) IBOutlet UILabel *lbLabel;
@property (strong, nonatomic) IBOutlet UILabel *eightLabel;
@property (strong, nonatomic) IBOutlet UILabel *nineLabel;
@property (strong, nonatomic) IBOutlet UILabel *tenLabel;
@property (strong, nonatomic) IBOutlet UILabel *elevenLabel;
@property (strong, nonatomic) IBOutlet UILabel *twlveLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirteenLabel;
@property (strong, nonatomic) IBOutlet UILabel *forteenLabel;
@property (strong, nonatomic) IBOutlet UILabel *fifteenLabel;
@property (strong, nonatomic) IBOutlet UILabel *sixTeenLabel;
@property (strong, nonatomic) IBOutlet UILabel *jieduanLabel;

@property (nonatomic, strong) SWTWsDetail *wsDetailModel;
@property (nonatomic, strong) SWTDsrDetail *dsrDetailModel;
@property (nonatomic, strong) SWTSpzzDetail *spzzDetailModel;

@end
