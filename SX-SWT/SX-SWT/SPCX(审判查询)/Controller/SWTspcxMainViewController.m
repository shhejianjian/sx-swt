//
//  SWTspcxMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTspcxMainViewController.h"
#import "SWTcxFirstViewController.h"
#import "SWTcxSecondViewController.h"
#import "SWTcxThirdViewController.h"
#import "SWTAyTreeViewController.h"
#import "SWTAjListViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTBase.h"
#import "SWTWSDetailMainViewController.h"
@interface SWTspcxMainViewController ()<FJSlidingControllerDataSource,FJSlidingControllerDelegate,SWTspcxMainViewControllerDelegate>
@property (nonatomic, strong)NSArray *titles;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong)NSArray *controllers;

@end

@implementation SWTspcxMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.datasouce = self;
    self.delegate = self;
    SWTcxFirstViewController *v1 = [[SWTcxFirstViewController alloc]init];
    v1.delegate = self;
    v1.parentController = self;
    SWTcxSecondViewController *v2 = [[SWTcxSecondViewController alloc]init];
    v2.parentController = self;
//    SWTcxThirdViewController *v3 = [[SWTcxThirdViewController alloc]init];
//    v3.parentController = self;
    
    self.titles      = @[@"案件查询",@"裁判文书查询"];
    self.controllers = @[v1,v2];
    [self addChildViewController:v1];
    [self addChildViewController:v2];
//    [self addChildViewController:v3];
    //self.title = self.titles[0];
    
    [self reloadData];
    // Do any additional setup after loading the view from its nib.
}
- (void) viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [SVProgressHUD showWithStatus:@"正在查询"];
    [SWTHttpTool post:GetAjDsrByUserUrl params:params success:^(id json) {
        SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
        if ([baseModel.flag isEqualToString:@"1"]) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"查询成功"];
            SWTWSDetailMainViewController *detailVC = [[SWTWSDetailMainViewController alloc]init];
            detailVC.ajbsStr = baseModel.ajbs;
            detailVC.checkTypeStr = @"审判查询";

            [self.navigationController pushViewController:detailVC animated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"查询失败，请检查用户名密码"];
        }
        NSLog(@"++%@",json);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不稳定，请稍后再试"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        NSLog(@"--%@--params:%@",error,params);
    }];
    
    
//    SWTAjListViewController *ajlistVC = [[SWTAjListViewController alloc]init];
//    ajlistVC.ndhStr = ndh;
//    ajlistVC.ahqcStr = ahqc;
//    ajlistVC.laayStr = laay;
//    ajlistVC.fymcStr = fymc;
//    ajlistVC.checkTypeStr = @"审判查询";
//    [self.navigationController pushViewController:ajlistVC animated:YES];
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
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

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


@end
