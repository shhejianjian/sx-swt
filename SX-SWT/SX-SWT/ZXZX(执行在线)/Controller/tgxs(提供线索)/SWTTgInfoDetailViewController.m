//
//  SWTTgInfoDetailViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/17.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTTgInfoDetailViewController.h"
#import "SWTXsFjListViewController.h"
@interface SWTTgInfoDetailViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *zjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *lxdhLabel;
@property (strong, nonatomic) IBOutlet UILabel *sjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *bjbrNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *zxfyLabel;
@property (strong, nonatomic) IBOutlet UILabel *zxahLabel;
@property (strong, nonatomic) IBOutlet UILabel *hfsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *hfnrLabel;

@end

@implementation SWTTgInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
        self.nameLabel.text = self.xsListModel.jbrmc;
        self.zjhmLabel.text = self.xsListModel.jbrsfzjhm;
        self.lxdhLabel.text = self.xsListModel.jbrlxdh;
        self.sjhmLabel.text = self.xsListModel.jbrlxsj;
        self.bjbrNameLabel.text = self.xsListModel.bjbrmc;
        self.zxfyLabel.text = self.xsListModel.fymc;
        self.zxahLabel.text = self.xsListModel.ahqc;
    if (_xsListModel.hfsj) {
        self.hfsjLabel.text = [NSString stringWithFormat:@"回复时间：%@",_xsListModel.hfsj];
    } else {
        self.hfnrLabel.text = @"回复时间：";
    }
    if (_xsListModel.hfnr) {
        self.hfnrLabel.text = [NSString stringWithFormat:@"回复内容：%@",_xsListModel.hfnr];
    } else {
        self.hfnrLabel.text = @"回复内容：";
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jumpToXsFjList:(id)sender {
    SWTXsFjListViewController *fjListVC = [[SWTXsFjListViewController alloc]init];
    fjListVC.jbxsidStr = self.xsListModel.id;
    fjListVC.checkStatusStr = @"查看";
    [self.navigationController pushViewController:fjListVC animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
