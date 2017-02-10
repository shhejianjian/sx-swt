//
//  SWTAjListViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/8.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAjListViewController.h"
#import "SWTCpwsCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTSpcxList.h"
#import "SWTWSDetailMainViewController.h"
#import "SWTBase.h"

static NSString *ID=@"CpwsCell";
@interface SWTAjListViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) NSMutableArray *spcxArr;
@property (strong, nonatomic) IBOutlet UITableView *mytableView;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation SWTAjListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.mytableView registerNib:[UINib nibWithNibName:@"SWTCpwsCell" bundle:nil] forCellReuseIdentifier:ID];
    self.mytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.mytableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.mytableView.mj_header beginRefreshing];
}
- (void)loadNewData
{
    [self.spcxArr removeAllObjects];
    self.currentPage = 1;
    [self loadAjList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadAjList];
}


- (void)loadAjList {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"page"] = @(self.currentPage);
    params[@"pageSize"] = @5;
    params[@"ndh"] = self.ndhStr;
    params[@"ahqc"] = self.ahqcStr;
    params[@"fymc"] = self.fymcStr;
    params[@"laaymc"] = self.laayStr;
    if (self.ajlbStr) {
        params[@"ajlb"] = @"8";
    }
    [SVProgressHUD showWithStatus:@"正在加载..."];

    [SWTHttpTool post:GetSpcxListUrl params:params success:^(id json) {
        [SVProgressHUD dismiss];

       
        NSArray *arr = [SWTSpcxList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        for (SWTSpcxList *spcxlistModel in arr) {
            [self.spcxArr addObject:spcxlistModel];
        }
        
        self.totalCount = [json[@"total"] integerValue];

        [self.mytableView reloadData];
        [self.mytableView.mj_header endRefreshing];
        [self.mytableView.mj_footer endRefreshing];
        NSLog(@"--%@",json);
    } failure:^(NSError *error) {
        [self.mytableView.mj_header endRefreshing];
        [self.mytableView.mj_footer endRefreshing];
        NSLog(@"--%@",error);
    }];
    
}



#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.spcxArr.count == self.totalCount) {
        [self.mytableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        self.mytableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.spcxArr.count;    
}


- (SWTCpwsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTCpwsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[SWTCpwsCell alloc]init];
    }
    cell.spcxListModel = self.spcxArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  160;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
            if ([self.checkTypeStr isEqualToString:@"审判查询"]) {
                SWTWSDetailMainViewController *detailVC = [[SWTWSDetailMainViewController alloc]init];
                SWTSpcxList *spcxListModel = self.spcxArr[indexPath.row];
                detailVC.ajbsStr = spcxListModel.ajbs;
                detailVC.checkTypeStr = @"审判查询";
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                
                params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
                
                params[@"outusername"] = [userDefault objectForKey:@"name"];
                
                params[@"flag"] = @1;
                params[@"userid"] = alertController.textFields[0].text;
                params[@"password"] = alertController.textFields[1].text;
                params[@"ajbs"] = spcxListModel.ajbs;
                [SWTHttpTool post:GetAjDsrByUserUrl params:params success:^(id json) {
                    SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
                    if ([baseModel.flag isEqualToString:@"1"]) {
                        [SVProgressHUD showSuccessWithStatus:@"查询成功"];
                        [self.navigationController pushViewController:detailVC animated:YES];
                    } else {
                        [SVProgressHUD showErrorWithStatus:@"查询失败，请检查用户名密码"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });

                    }
                    NSLog(@"++%@",json);
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"网络不稳定，请稍后再试"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    NSLog(@"--%@",error);
                }];
                

            } else if ([self.checkTypeStr isEqualToString:@"执行在线"]) {
                SWTWSDetailMainViewController *detailVC = [[SWTWSDetailMainViewController alloc]init];
                SWTSpcxList *spcxListModel = self.spcxArr[indexPath.row];
                detailVC.ajbsStr = spcxListModel.ajbs;
                detailVC.checkTypeStr = @"执行在线";
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                
                params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
                
                params[@"outusername"] = [userDefault objectForKey:@"name"];
                
                params[@"flag"] = @1;
                params[@"userid"] = alertController.textFields[0].text;
                params[@"password"] = alertController.textFields[1].text;
                params[@"ajbs"] = spcxListModel.ajbs;
                [SWTHttpTool post:GetAjDsrByUserUrl params:params success:^(id json) {
                    SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
                    if ([baseModel.flag isEqualToString:@"1"]) {
                        [SVProgressHUD showSuccessWithStatus:@"查询成功"];
                        [self.navigationController pushViewController:detailVC animated:YES];
                    } else {
                        [SVProgressHUD showErrorWithStatus:@"查询失败，请检查用户名密码"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        
                    }
                    NSLog(@"++%@",json);
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"网络不稳定，请稍后再试"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    NSLog(@"--%@",error);
                }];
            }
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
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    self.checkTypeStr = nil;
    self.ajlbStr = nil;
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)spcxArr {
	if(_spcxArr == nil) {
		_spcxArr = [[NSMutableArray alloc] init];
	}
	return _spcxArr;
}

@end
