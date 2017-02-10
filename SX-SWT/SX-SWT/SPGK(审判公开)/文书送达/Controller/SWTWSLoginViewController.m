//
//  SWTWSLoginViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/4.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTWSLoginViewController.h"
#import "SWTBookArriveViewController.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SVProgressHUD.h"
#import "SWTDZWS.h"
#import "SWTBase.h"

@interface SWTWSLoginViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITextField *wsUsernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *wsPwdTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation SWTWSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)loginToWs:(id)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"userid"] = self.wsUsernameTextField.text;
    params[@"password"] = self.wsPwdTextField.text;
    
    [SWTHttpTool post:LoginToGetWsListUrl params:params success:^(id json) {
        NSLog(@"%@",json);
        SWTBookArriveViewController *bookVC = [[SWTBookArriveViewController alloc]init];
        bookVC.zjhStr = self.wsUsernameTextField.text;
        bookVC.pwdStr = self.wsPwdTextField.text;
        [self.navigationController pushViewController:bookVC animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
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
