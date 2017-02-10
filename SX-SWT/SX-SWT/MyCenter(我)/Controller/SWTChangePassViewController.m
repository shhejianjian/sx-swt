//
//  SWTChangePassViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/3.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTChangePassViewController.h"
#import "SVProgressHUD.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "SWTHttpTool.h"
#import "SWTBase.h"
#import "SWTMyCenterViewController.h"

@interface SWTChangePassViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITextField *oldPwdTextField;
@property (strong, nonatomic) IBOutlet UITextField *NewPwdTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondNewPwdTextField;

@end

@implementation SWTChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];

    // Do any additional setup after loading the view.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)changePwdBtn:(id)sender {
    if (self.oldPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"原密码不得为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.NewPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"新密码密码不得为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.secondNewPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次确认新密码"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([self.secondNewPwdTextField.text isEqualToString:self.NewPwdTextField.text]) {
        params[@"apppwd"] = self.NewPwdTextField.text;
    }  else {
        [SVProgressHUD showErrorWithStatus:@"请确认您输入的两次新密码保持一致"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginId"];
    params[@"id"] = userId;
    
    [SWTHttpTool get:ChangePwdUrl params:params success:^(id json) {
        SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
        if ([baseModel.flag isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
            [UserDefaults setObject:self.NewPwdTextField.text forKey:@"password"];
            [UserDefaults synchronize];
            [self jumpToVC];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"当前网络不稳定，请稍后再试"];
    }];
}
- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SWTMyCenterViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
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
