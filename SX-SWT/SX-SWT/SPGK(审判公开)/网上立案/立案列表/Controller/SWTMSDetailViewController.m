//
//  SWTMSDetailViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/30.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTMSDetailViewController.h"
#import "SWTAddPartyViewController.h"



#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface SWTMSDetailViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConst;

@property (strong, nonatomic) IBOutlet UILabel *sqrNamelabel;
@property (strong, nonatomic) IBOutlet UILabel *lxdhLabel;
@property (strong, nonatomic) IBOutlet UILabel *sjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *zjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *ydsrgxLabel;
@property (strong, nonatomic) IBOutlet UILabel *bdeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ssqqLabel;
@property (strong, nonatomic) IBOutlet UILabel *sslyLabel;




@end

@implementation SWTMSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (ScreenHeight == 568) {
        self.bottomViewConst.constant = 110;
    } else if (ScreenHeight == 667) {
        self.bottomViewConst.constant = 60;
    } else if (ScreenHeight == 736) {
        self.bottomViewConst.constant = 30;
    }
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.sqrNamelabel.text = self.MSAjlbModel.sqrmc;
    self.lxdhLabel.text = self.MSAjlbModel.sqrdh;
    self.sjhmLabel.text = self.MSAjlbModel.sqryddh;
    self.zjhmLabel.text = self.MSAjlbModel.sqrzjhm;
    self.ydsrgxLabel.text = self.MSAjlbModel.ydsrgxmc;
    self.bdeLabel.text = self.MSAjlbModel.ajbd;
    self.ssqqLabel.text = self.MSAjlbModel.ssqq;
    self.sslyLabel.text = self.MSAjlbModel.ssly;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
