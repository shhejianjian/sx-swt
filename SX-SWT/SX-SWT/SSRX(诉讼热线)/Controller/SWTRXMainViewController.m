//
//  SWTRXMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTRXMainViewController.h"
#import "SWTOnlineKFViewController.h"
#import "SWTAddInfoViewController.h"
#import "SWTConsultViewController.h"
#import "SWTConDetailViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTBase.h"
@interface SWTRXMainViewController ()<FJSlidingControllerDataSource,FJSlidingControllerDelegate,SWTAddInfoViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *controllers;
@end


@implementation SWTRXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    self.datasouce = self;
    self.delegate = self;
    
    SWTOnlineKFViewController *v1 = [[SWTOnlineKFViewController alloc]init];
    v1.parentController = self;
    SWTAddInfoViewController *v2 = [[SWTAddInfoViewController alloc]init];
    v2.delegate = self;
    v2.parentController = self;
    SWTConsultViewController *v3 = [[SWTConsultViewController alloc]init];
    v3.parentController = self;
    
    self.titles      = @[@"在线客服",@"诉讼信息录入",@"诉讼咨询"];
    self.controllers = @[v1,v2,v3];
    [self addChildViewController:v1];
    [self addChildViewController:v2];
    [self addChildViewController:v3];
    //self.title = self.titles[0];
    
    [self reloadData];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectWithLdhmStr:(NSString *)ldhm andXbStr:(NSString *)xb andAgeStr:(NSString *)age andZyStr:(NSString *)zy andWhcdStr:(NSString *)whcd andJjdzStr:(NSString *)jzdz andNrzyStr:(NSString *)nrzy {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *loginIdStr = [userDefault objectForKey:@"loginId"];
    if (loginIdStr.length > 0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认提交？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"取消");
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
            
            params[@"outusername"] = [userDefault objectForKey:@"name"];
            
            params[@"flag"] = @1;
            params[@"lxdh"] = ldhm;
            params[@"sex"] = xb;
            params[@"age"] = age;
            params[@"address"] = jzdz;
            params[@"content"] = nrzy;
            params[@"zy"] = zy;
            params[@"whcd"] = whcd;
            [SWTHttpTool post:SaveSsInfoUrl params:params success:^(id json) {
                SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
                
                if ([baseModel.flag isEqualToString:@"1"]) {
                    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                    
                    //创建一个消息对象
                    NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":@"123"}];
                    //发送消息
                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                } else {
                    [SVProgressHUD showErrorWithStatus:@"提交失败"];
                    
                }
                NSLog(@"++%@",json);
            } failure:^(NSError *error) {
                NSLog(@"--%@",error);
            }];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后录入"];
    }

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
