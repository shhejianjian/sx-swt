//
//  SWTXFDetailViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXFDetailViewController.h"
#import "SWTXFImgListViewController.h"


#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface SWTXFDetailViewController ()

@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *zjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *lxdhLabel;
@property (strong, nonatomic) IBOutlet UILabel *sjhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *dzyjLabel;
@property (strong, nonatomic) IBOutlet UILabel *yzbmLabel;
@property (strong, nonatomic) IBOutlet UILabel *xfrsfLabel;
@property (strong, nonatomic) IBOutlet UILabel *grdzLabel;
@property (strong, nonatomic) IBOutlet UILabel *xffyLabel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *xfmdLabel;
@property (strong, nonatomic) IBOutlet UILabel *fyqkLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewBottomConstraint;
@property (strong, nonatomic) IBOutlet UILabel *hfsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *hfnrLabel;



@end

@implementation SWTXFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    if (ScreenHeight == 568) {
        self.viewBottomConstraint.constant = 120;
    } else if (ScreenHeight == 667) {
        self.viewBottomConstraint.constant = 180;
    } else if (ScreenHeight == 736) {
        self.viewBottomConstraint.constant = 130;
    }
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
    self.nameLabel.text = self.xfListModel.mc;
    self.zjhmLabel.text = self.xfListModel.sfzjhm;
    self.lxdhLabel.text = self.xfListModel.dhhm;
    self.sjhmLabel.text = self.xfListModel.mobile;
    self.dzyjLabel.text = self.xfListModel.dzyj;
    self.yzbmLabel.text = self.xfListModel.yzbm;
    self.xfrsfLabel.text = self.xfListModel.xfrsfmc;
    self.grdzLabel.text = self.xfListModel.xfrdz;
    self.xffyLabel.text = self.xfListModel.fymc;
    self.ahqcLabel.text = self.xfListModel.ahqc;
    self.xfmdLabel.text = self.xfListModel.xfmdmc;
    self.fyqkLabel.text = self.xfListModel.fyqk;
    if (_xfListModel.hfsj) {
        self.hfsjLabel.text = [NSString stringWithFormat:@"回复时间：%@",_xfListModel.hfsj];
    } else {
        self.hfnrLabel.text = @"回复时间：";
    }
    if (_xfListModel.hfnr) {
        self.hfnrLabel.text = [NSString stringWithFormat:@"回复内容：%@",_xfListModel.hfnr];
    } else {
        self.hfnrLabel.text = @"回复内容：";
    }
//    self.hfsjLabel.text = [NSString stringWithFormat:@"回复时间：%@",self.xfListModel.hfsj];
    self.hfnrLabel.text = self.xfListModel.hfnr;
}
- (IBAction)checkImgList:(id)sender {
    SWTXFImgListViewController *xfImgListVC = [[SWTXFImgListViewController alloc]init];
    xfImgListVC.xfIdStr = self.xfListModel.id;
    xfImgListVC.checkStatusStr = @"查看";
    [self.navigationController pushViewController:xfImgListVC animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
