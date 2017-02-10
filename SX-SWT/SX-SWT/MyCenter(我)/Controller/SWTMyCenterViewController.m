//
//  SWTMyCenterViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/1.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTMyCenterViewController.h"
#import "SWTLoginViewController.h"
#import "SWTRegistViewController.h"
#import "SWTChangePassViewController.h"
#import "SWTChooseMapViewController.h"

@interface SWTMyCenterViewController ()

@property (strong, nonatomic) IBOutlet UILabel *loginOrChangPwdLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@end




@implementation SWTMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
        NSString *locationStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
        self.locationLabel.text = [NSString stringWithFormat:@"当前位置: %@",locationStr];
        NSString *sfzStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
        if (sfzStr.length > 0) {
            self.loginOrChangPwdLabel.text = @"修改密码";
            self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];;

        } else {
            self.loginOrChangPwdLabel.text = @"登录/注册";
            self.nameLabel.text = @"我的姓名";
        }
}

- (IBAction)loginOrChangePwd:(id)sender {
//    NSString *sfzStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
    if ([self.loginOrChangPwdLabel.text isEqualToString:@"修改密码"]) {
        SWTChangePassViewController *registVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"change"];
        [registVC setHidesBottomBarWhenPushed:YES];

        [self.navigationController pushViewController:registVC animated:YES];
    } else if ([self.loginOrChangPwdLabel.text isEqualToString:@"登录/注册"]) {
        SWTRegistViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
        [loginVC setHidesBottomBarWhenPushed:YES];

        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}
- (IBAction)upDateAppBtn:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认注销此账号？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
        [UserDefaults setObject:@"" forKey:@"username"];
        [UserDefaults setObject:@"" forKey:@"password"];
        [UserDefaults setObject:@"" forKey:@"sfzhm"];
        [UserDefaults setObject:@"" forKey:@"name"];
        [UserDefaults setObject:@"" forKey:@"birthday"];
        [UserDefaults setObject:@"" forKey:@"lxdh"];
        [UserDefaults setObject:@"" forKey:@"sjhm"];
        [UserDefaults setObject:@"" forKey:@"sex"];
        [UserDefaults setObject:@"" forKey:@"mz"];
        [UserDefaults setObject:@"" forKey:@"xl"];
        [UserDefaults setObject:@"" forKey:@"loginId"];
        self.loginOrChangPwdLabel.text = @"登录/注册";
        self.nameLabel.text = @"我的姓名";
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"退出登录");
}

- (IBAction)changeLocationBtn:(id)sender {
    SWTChooseMapViewController *chooseMapVC = [[SWTChooseMapViewController alloc]init];
    [chooseMapVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseMapVC animated:YES];
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
