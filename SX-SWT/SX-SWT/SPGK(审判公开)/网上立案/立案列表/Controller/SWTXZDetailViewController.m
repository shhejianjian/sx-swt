//
//  SWTXZDetailViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/30.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXZDetailViewController.h"
#import "SWTAddPartyViewController.h"

#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface SWTXZDetailViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConst;

@property (strong, nonatomic) IBOutlet UILabel *sqrName;
@property (strong, nonatomic) IBOutlet UILabel *lxdhLabel;
@property (strong, nonatomic) IBOutlet UILabel *sjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *zjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *ydsrgxLabel;
@property (strong, nonatomic) IBOutlet UILabel *xzpcfslabel;
@property (strong, nonatomic) IBOutlet UILabel *pcjeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ssqqLabel;
@property (strong, nonatomic) IBOutlet UILabel *sslyLabel;




@end

@implementation SWTXZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (ScreenHeight == 568) {
        self.bottomViewConst.constant = 130;
    } else if (ScreenHeight == 667) {
        self.bottomViewConst.constant = 80;
    } else if (ScreenHeight == 736) {
        self.bottomViewConst.constant = 50;
    }
    
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.sqrName.text = self.MSAjlbModel.sqrmc;
    self.lxdhLabel.text = self.MSAjlbModel.sqrdh;
    self.sjhmLabel.text = self.MSAjlbModel.sqryddh;
    self.zjhmLabel.text = self.MSAjlbModel.sqrzjhm;
    self.ydsrgxLabel.text = self.MSAjlbModel.ydsrgxmc;
    self.xzpcfslabel.text = self.MSAjlbModel.tqxzpcfs;
    self.pcjeLabel.text = self.MSAjlbModel.sqxzpcje;
    self.ssqqLabel.text = self.MSAjlbModel.ssqq;
    self.sslyLabel.text = self.MSAjlbModel.ssly;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)jumpToDsr:(id)sender {
    SWTAddPartyViewController *partyVc = [[SWTAddPartyViewController alloc]init];
    partyVc.ylaInfoIdStr = self.MSAjlbModel.ajbs;
    partyVc.checkStatusStr = @"查看";

    [self.navigationController pushViewController:partyVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
