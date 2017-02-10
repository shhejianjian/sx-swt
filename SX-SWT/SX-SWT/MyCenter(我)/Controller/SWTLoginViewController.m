//
//  SWTLoginViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/3.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTLoginViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTLogin.h"
#import "SWTBase.h"
#import "SVProgressHUD.h"
#import "SWTMainViewController.h"


@interface SWTLoginViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end




@implementation SWTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    
    // Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender {
    
    if (self.userNameTextField.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    [SVProgressHUD showWithStatus:@"正在登录..."];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"appname"] = self.userNameTextField.text;
        params[@"apppwd"] = self.passwordTextField.text;
        params[@"flag"] = @1;
        [SWTHttpTool post:LoginUrl params:params success:^(id json) {
            SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
            if ([baseModel.flag isEqualToString:@"1"]) {
                [SVProgressHUD dismiss];

                NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
                SWTLogin *loginModel = [SWTLogin mj_objectWithKeyValues:json[@"userinfo"]];
                [UserDefaults setObject:loginModel.id forKey:@"loginId"];
                [UserDefaults setObject:self.userNameTextField.text forKey:@"username"];
                [UserDefaults setObject:self.passwordTextField.text forKey:@"password"];
                [UserDefaults setObject:loginModel.sfzhm forKey:@"sfzhm"];
                [UserDefaults setObject:loginModel.name forKey:@"name"];
                [UserDefaults setObject:loginModel.birthday forKey:@"birthday"];
                [UserDefaults setObject:loginModel.lxdh forKey:@"lxdh"];
                [UserDefaults setObject:loginModel.sjhm forKey:@"sjhm"];
                [UserDefaults setObject:loginModel.sex forKey:@"sex"];
                [UserDefaults setObject:loginModel.mz forKey:@"mz"];
                [UserDefaults setObject:loginModel.xl forKey:@"xl"];
                [UserDefaults setObject:loginModel.apploginname forKey:@"apploginname"];
                [UserDefaults synchronize];
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            NSLog(@"%@",json);
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
            NSLog(@"%@",error);
        }];
    
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
