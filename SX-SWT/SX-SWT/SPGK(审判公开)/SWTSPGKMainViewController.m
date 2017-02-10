//
//  SWTSPGKMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSPGKMainViewController.h"
#import "SWTBookArriveViewController.h"
#import "SWTSFWTViewController.h"
#import "SWTTSGGViewController.h"
#import "SWTspcxMainViewController.h"
#import "SWTWSLoginViewController.h"
#import "SWTTSZBViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTBase.h"
#import "SWTGgListViewController.h"
#import "SWTFYGSMainViewController.h"

@interface SWTSPGKMainViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTSPGKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell=[[UITableViewCell alloc]init];
        
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"庭审直播";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"案件查询";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"文书送达";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"庭审公告";
    }
    cell.backgroundColor = SWTGlobalColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        SWTTSZBViewController *zbVC = [[SWTTSZBViewController alloc]init];
        [self.navigationController pushViewController:zbVC animated:YES];
    } else if (indexPath.row == 1) {
        SWTspcxMainViewController *spcxVC = [[SWTspcxMainViewController alloc]init];
        [self.navigationController pushViewController:spcxVC animated:YES];
        
    } else if (indexPath.row == 2) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"需输入正确的用户名和密码才可查看哦" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (alertController.textFields[0].text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"用户名不得为空"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            } else if (alertController.textFields[1].text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"密码不得为空"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }else {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                
                params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
                
                params[@"outusername"] = [userDefault objectForKey:@"name"];
                
                params[@"flag"] = @1;
                params[@"userid"] = alertController.textFields[0].text;
                params[@"password"] = alertController.textFields[1].text;
                
                [SWTHttpTool post:LoginToGetWsListUrl params:params success:^(id json) {
                    NSLog(@"%@（）（）%@",json,params);
                    
                    SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
                    
                    if ([baseModel.flag isEqualToString:@"1"]) {
                        SWTBookArriveViewController *bookVC = [[SWTBookArriveViewController alloc]init];
                        bookVC.zjhStr = alertController.textFields[0].text;
                        bookVC.pwdStr = alertController.textFields[1].text;
                        [self.navigationController pushViewController:bookVC animated:YES];
                    } else {
                        [SVProgressHUD showErrorWithStatus:@"验证失败"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                    }
                    
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    NSLog(@"%@",error);
                }];
            }
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入用户名";
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.secureTextEntry = YES;
            textField.placeholder = @"请输入密码";
        }];
        [self presentViewController:alertController animated:YES completion:nil];
//        SWTBookArriveViewController *bookArriveVC = [[SWTBookArriveViewController alloc]init];
//        [self.navigationController pushViewController:bookArriveVC animated:YES];
       
    } else if (indexPath.row == 3) {
        SWTGgListViewController *tsggVC = [[SWTGgListViewController alloc]init];
        [self.navigationController pushViewController:tsggVC animated:YES];
    }
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
