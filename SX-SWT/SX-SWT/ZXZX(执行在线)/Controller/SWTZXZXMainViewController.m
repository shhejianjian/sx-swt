//
//  SWTZXZXMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTZXZXMainViewController.h"
#import "SWTzhiyinViewController.h"
#import "SWTrizhiViewController.h"
#import "SWTxiansuoViewController.h"
#import "SWTbaoguangViewController.h"
#import "SWTCsAndGfViewController.h"
#import "SWTZxGfViewController.h"
#import "SWTZXLCViewController.h"
#import "SWTBGTDetailViewController.h"
#import "SWTXFListViewController.h"
#import "SWTXsListViewController.h"
#import "SWTAjListViewController.h"
#import "SWTAyTreeViewController.h"
#import "SWTBgtList.h"
#import "SWTFeedbackViewController.h"
#import "SWTWSDetailMainViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTBase.h"
@interface SWTZXZXMainViewController ()<FJSlidingControllerDataSource,FJSlidingControllerDelegate,SWTzhiyinViewControllerDelegate,SWTbaoguangViewControllerDelegate,SWTxiansuoViewControllerDelegate,SWTrizhiViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *controllers;
@end

@implementation SWTZXZXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.datasouce = self;
    self.delegate = self;
    
    SWTzhiyinViewController *v1 = [[SWTzhiyinViewController alloc]init];
    v1.delegate = self;
    v1.parentController = self;
    SWTrizhiViewController *v2 = [[SWTrizhiViewController alloc]init];
    v2.delegate = self;
    v2.parentController = self;
    SWTxiansuoViewController *v3 = [[SWTxiansuoViewController alloc]init];
    v3.delegate = self;
    v3.parentController = self;
    SWTbaoguangViewController *v4 = [[SWTbaoguangViewController alloc]init];
    v4.delegate = self;
    v4.parentController = self;
    self.titles      = @[@"执行指引",@"执行日志",@"提供线索",@"曝光台"];
    self.controllers = @[v1,v2,v3,v4];
    [self addChildViewController:v1];
    [self addChildViewController:v2];
    [self addChildViewController:v3];
    [self addChildViewController:v4];
    //self.title = self.titles[0];
    
    [self reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (void)didSelect {
    SWTAyTreeViewController *ayTreeVC = [[SWTAyTreeViewController alloc]init];
    [self.navigationController pushViewController:ayTreeVC animated:YES];
}

- (void)clickCXBtnWithAhqc:(NSString *)ahqc andNdh:(NSString *)ndh andFymc:(NSString *)fymc andLaay:(NSString *)laay {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"userid"] = ndh;
    params[@"password"] = ahqc;
    params[@"ajlb"] = @"8";
    [SVProgressHUD showWithStatus:@"正在查询"];
    [SWTHttpTool post:GetAjDsrByUserUrl params:params success:^(id json) {
        SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
        if ([baseModel.flag isEqualToString:@"1"]) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"查询成功"];
            SWTWSDetailMainViewController *detailVC = [[SWTWSDetailMainViewController alloc]init];
            detailVC.ajbsStr = baseModel.ajbs;
            detailVC.checkTypeStr = @"执行在线";
            [self.navigationController pushViewController:detailVC animated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"查询失败，请检查用户名密码"];
        }
        NSLog(@"++%@",json);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不稳定，请稍后再试"];
        
        NSLog(@"--%@--params:%@",error,params);
    }];
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark dataSouce
- (NSInteger)numberOfPageInFJSlidingController:(FJSlidingController *)fjSlidingController{
    return self.titles.count;
}
- (UIViewController *)fjSlidingController:(FJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index{
    return self.controllers[index];
}
- (NSString *)fjSlidingController:(FJSlidingController *)fjSlidingController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
/*
 - (UIColor *)titleNomalColorInFJSlidingController:(FJSlidingController *)fjSlidingController;
 - (UIColor *)titleSelectedColorInFJSlidingController:(FJSlidingController *)fjSlidingController;
 - (UIColor *)lineColorInFJSlidingController:(FJSlidingController *)fjSlidingController;
 - (CGFloat)titleFontInFJSlidingController:(FJSlidingController *)fjSlidingController;
 */

#pragma mark delegate
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedIndex:(NSInteger)index{
    // presentIndex
    NSLog(@"%ld",index);
    self.title = [self.titles objectAtIndex:index];
}
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedController:(UIViewController *)controller{
    // presentController
}
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedTitle:(NSString *)title{
    // presentTitle
}


- (void)didSelect:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        SWTZXLCViewController *zxlcVC = [[SWTZXLCViewController alloc]init];
        [self.navigationController pushViewController:zxlcVC animated:YES];
    } else if (indexPath.row == 1) {
        SWTCsAndGfViewController *csAndGfVC = [[SWTCsAndGfViewController alloc]init];
        [self.navigationController pushViewController:csAndGfVC animated:YES];
    } else if (indexPath.row == 2) {
        SWTZxGfViewController *zxgfVC = [[SWTZxGfViewController alloc]init];
        [self.navigationController pushViewController:zxgfVC animated:YES];    }
}

- (void)didSelectRow:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath andmdetailModel:(SWTBgtList *)mdetailModel {
    
    SWTBGTDetailViewController *bgtDetailVC = [[SWTBGTDetailViewController alloc]init];
    bgtDetailVC.bgtListModel = mdetailModel;
    [self.navigationController pushViewController:bgtDetailVC animated:YES];
}
- (void)didSelectXianSuo:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SWTXsListViewController *tgxsListVC = [[SWTXsListViewController alloc]init];
        [self.navigationController pushViewController:tgxsListVC animated:YES];
    } else if (indexPath.row == 1) {
        SWTXFListViewController *xftsListVC = [[SWTXFListViewController alloc]init];
        [self.navigationController pushViewController:xftsListVC animated:YES];
    }else if (indexPath.row == 2) {
        SWTFeedbackViewController *CondetailVC = [[SWTFeedbackViewController alloc]init];
        [self.navigationController pushViewController:CondetailVC animated:YES];
    }
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
