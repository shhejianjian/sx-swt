//
//  SWTAJLBViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAJLBViewController.h"
#import "SWTFyTypeViewController.h"
#import "SWTAJLBCell.h"
#import "SWTAJDetailViewController.h"
#import "ZYLAlert.h"
#import "SWTChangeInfoViewController.h"
#import "SWTAJLB.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTMSDetailViewController.h"
#import "SWTXZDetailViewController.h"
#import "SWTZXDetailViewController.h"
#import "SWTMSViewController.h"
#import "SWTXZViewController.h"
#import "SWTZXViewController.h"
#import "SVProgressHUD.h"


static NSString *ID=@"ajlbCell";


@interface SWTAJLBViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *AJLBTableView;

@property (nonatomic, strong) NSMutableArray *ajlbArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

extern NSString *checkAjlbStr;

@implementation SWTAJLBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.AJLBTableView registerNib:[UINib nibWithNibName:@"SWTAJLBCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.AJLBTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.AJLBTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];    
    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.ajlbArr removeAllObjects];
    self.currentPage = 1;
    [self loadAJInfo];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadAJInfo];
}
- (void)viewWillAppear:(BOOL)animated {
//    if (checkAjlbStr) {
        [self.AJLBTableView.mj_header beginRefreshing];
//    }
}
- (void)viewWillDisappear:(BOOL)animated {
    checkAjlbStr = nil;
    [SVProgressHUD dismiss];

}
- (void)loadAJInfo {
    [SVProgressHUD showWithStatus:@"正在加载，请稍等"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *zjhStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
    if (zjhStr.length > 0) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        params[@"loginname"] = [userDefault objectForKey:@"apploginname"];
        params[@"flag"] = @1;
        params[@"page"] = @(self.currentPage);
        params[@"pageSize"] = @5;
        [SWTHttpTool post:GetAJInfoUrl params:params success:^(id json) {
            
            NSArray *arr = [SWTAJLB mj_objectArrayWithKeyValuesArray:json[@"rows"]];
            
            for (SWTAJLB *ajlbModel in arr) {
                [self.ajlbArr addObject:ajlbModel];
            }
            
            self.totalCount = [json[@"total"] integerValue];
            [self.AJLBTableView reloadData];
            [SVProgressHUD dismiss];
            NSLog(@"++%@++%@",json,params);
        } failure:^(NSError *error) {
            NSLog(@"++%@",error);
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后查看"];
        
    }
    [self.AJLBTableView.mj_header endRefreshing];
    [self.AJLBTableView.mj_footer endRefreshing];

}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addNewAJ:(id)sender {
    NSString *zjhStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
    if (zjhStr.length > 0) {
        SWTFyTypeViewController *fyTypeVC = [[SWTFyTypeViewController alloc]init];
        [self.navigationController pushViewController:fyTypeVC animated:YES];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后添加"];
    }
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.ajlbArr.count == self.totalCount) {
        self.AJLBTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.AJLBTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.ajlbArr.count;
}

- (SWTAJLBCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWTAJLBCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[SWTAJLBCell alloc]init];
    }
    cell.AJLBModel = self.ajlbArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTAJLB *ajlbModel = self.ajlbArr[indexPath.row];
    SWTAJLBCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZYLAlert *zylAlert = [[ZYLAlert alloc] initWithTitle:@"提示" message:@"请选择您的操作"];
    [zylAlert addBtnAlertTitle:@"查看" action:^{
        if ([cell.typeLabel.text isEqualToString:@"民事"]) {
            SWTMSDetailViewController *msDetailVC = [[SWTMSDetailViewController alloc]init];
            msDetailVC.MSAjlbModel = ajlbModel;
            
            [self.navigationController pushViewController:msDetailVC animated:YES];
        } else if ([cell.typeLabel.text isEqualToString:@"行政"]) {
            SWTXZDetailViewController *xzDetailVC = [[SWTXZDetailViewController alloc]init];
            xzDetailVC.MSAjlbModel = ajlbModel;

            [self.navigationController pushViewController:xzDetailVC animated:YES];
        } else if ([cell.typeLabel.text isEqualToString:@"执行"]) {
            SWTZXDetailViewController *zxDetailVC = [[SWTZXDetailViewController alloc]init];
            zxDetailVC.MSAjlbModel = ajlbModel;

            [self.navigationController pushViewController:zxDetailVC animated:YES];
        }
        
//        SWTAJDetailViewController *ajDetailVC = [[SWTAJDetailViewController alloc]init];
////        SWTAJLB *ajlbModel = self.ajlbArr[indexPath.row];
////        ajDetailVC.ajlbModel = ajlbModel;
//        [self.navigationController pushViewController:ajDetailVC animated:YES];
        
    }];
    
    [zylAlert addBtnAlertTitle:@"修改" action:^{
        
        
        if ([cell.typeLabel.text isEqualToString:@"民事"]) {
            SWTMSViewController *msVC = [[SWTMSViewController alloc]init];
            msVC.ajlbModel = ajlbModel;
            [self.navigationController pushViewController:msVC animated:YES];
        } else if ([cell.typeLabel.text isEqualToString:@"行政"]) {
            SWTXZViewController *xzVC = [[SWTXZViewController alloc]init];
            xzVC.ajlbModel = ajlbModel;
            [self.navigationController pushViewController:xzVC animated:YES];
        } else if ([cell.typeLabel.text isEqualToString:@"执行"]) {
            SWTZXViewController *zxVC = [[SWTZXViewController alloc]init];
            zxVC.ajlbModel = ajlbModel;
            [self.navigationController pushViewController:zxVC animated:YES];
        }
        
        
//        SWTChangeInfoViewController *changeInfoVC = [[SWTChangeInfoViewController alloc]init];
//        [self.navigationController pushViewController:changeInfoVC animated:YES];
        
    }];
    
    [zylAlert addBtnAlertTitle:@"删除" action:^{
        NSMutableDictionary *params  = [NSMutableDictionary dictionary];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        
        params[@"flag"] = @1;
        params[@"ylainfoid"] = ajlbModel.ajbs;
        [SWTHttpTool post:DeleteYlaInfoUrl params:params success:^(id json) {
            
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            NSLog(@"删除成功：%@",json);
            [self.AJLBTableView.mj_header beginRefreshing];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            NSLog(@"删除失败：%@",error);
        }];
        [self.AJLBTableView.mj_header endRefreshing];
        
        
    }];
    [zylAlert addBtnAlertTitle:@"取消" action:^{
        
        NSLog(@"取消");
        
    }];
    [zylAlert showAlertWithSender:self];
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

- (NSMutableArray *)ajlbArr {
	if(_ajlbArr == nil) {
		_ajlbArr = [[NSMutableArray alloc] init];
	}
	return _ajlbArr;
}

@end
