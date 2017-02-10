//
//  SWTZXDetailViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/30.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTZXDetailViewController.h"
#import "SWTAddPartyViewController.h"
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface SWTZXDetailViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConst;


@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lxdhLabel;
@property (strong, nonatomic) IBOutlet UILabel *sjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *zjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *ydsrgxLabel;
@property (strong, nonatomic) IBOutlet UILabel *zxyjLabel;
@property (strong, nonatomic) IBOutlet UILabel *yjjgLabel;
@property (strong, nonatomic) IBOutlet UILabel *yjwhLabel;
@property (strong, nonatomic) IBOutlet UILabel *bdeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ssqqLabel;
@property (strong, nonatomic) IBOutlet UILabel *sslyLabel;



@end

@implementation SWTZXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    if (ScreenHeight == 568) {
        self.bottomViewConst.constant = 170;
    } else if (ScreenHeight == 667) {
        self.bottomViewConst.constant = 120;
    } else if (ScreenHeight == 736) {
        self.bottomViewConst.constant = 90;
    }
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
    self.nameLabel.text = self.MSAjlbModel.sqrmc;
    self.lxdhLabel.text = self.MSAjlbModel.sqrdh;
    self.sjhmLabel.text = self.MSAjlbModel.sqryddh;
    self.zjhmLabel.text = self.MSAjlbModel.sqrzjhm;
    self.ydsrgxLabel.text = self.MSAjlbModel.ydsrgxmc;
    self.yjjgLabel.text = self.MSAjlbModel.yjjg;
    self.yjwhLabel.text = self.MSAjlbModel.yjwh;
    self.ssqqLabel.text = self.MSAjlbModel.ssqq;
    self.sslyLabel.text = self.MSAjlbModel.ssly;
    self.bdeLabel.text = self.MSAjlbModel.ajbd;
    
    
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
