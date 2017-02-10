//
//  SWTXsListViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXsListViewController.h"
#import "SWTTgInfoViewController.h"
#import "SWTXsListCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTXsList.h"
#import "ZYLAlert.h"
#import "SWTTgInfoDetailViewController.h"
#import "SWTTgInfoViewController.h"
#import "SWTLogin.h"
static NSString *ID=@"SWTXsListCell";

@interface SWTXsListViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *xiansuoArr;
@property (nonatomic, strong) SWTLogin *usermapModel;

/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;

@end

@implementation SWTXsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTXsListCell" bundle:nil] forCellReuseIdentifier:ID];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.xiansuoArr removeAllObjects];
    self.currentPage = 1;
    [self loadXianSuoList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadXianSuoList];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadXianSuoList {
    [SVProgressHUD showWithStatus:@"正在加载，请稍等"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *zjhStr = [userDefault objectForKey:@"sfzhm"];
    if (zjhStr.length > 0) {
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
        params[@"outusername"] = [userDefault objectForKey:@"name"];
    
        params[@"flag"] = @1;
        params[@"page"] = @(self.currentPage);
        params[@"pageSize"] = @5;
        [SWTHttpTool post:GetXsInfoListUrl params:params success:^(id json) {
            
            NSArray *arr = [SWTXsList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
            for (SWTXsList *xslistModel in arr) {
                [self.xiansuoArr addObject:xslistModel];
            }
//            self.usermapModel = [SWTLogin mj_objectWithKeyValues:json[@"usermap"]];
        
            self.totalCount = [json[@"total"] integerValue];
            [self.myTableView reloadData];
            [SVProgressHUD dismiss];
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            NSLog(@"++%@++%@",json,params);
        } failure:^(NSError *error) {
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            NSLog(@"++%@",error);
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后查看"];
    }
    [self.myTableView.mj_header endRefreshing];

}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.xiansuoArr.count == self.totalCount) {
        self.myTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.xiansuoArr.count;
    
}


- (SWTXsListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTXsListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTXsListCell alloc]init];
        
    }
    cell.xsListModel = self.xiansuoArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 150;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTXsList *xfListModel = self.xiansuoArr[indexPath.row];
    
//    ZYLAlert *zylAlert = [[ZYLAlert alloc] initWithTitle:@"提示" message:@"请选择您的操作"];
//    [zylAlert addBtnAlertTitle:@"查看" action:^{
        SWTTgInfoDetailViewController *xfDetailVC = [[SWTTgInfoDetailViewController alloc]init];
        xfDetailVC.xsListModel = xfListModel;
        xfDetailVC.usermapModel = self.usermapModel;
        [self.navigationController pushViewController:xfDetailVC animated:YES];
        
        
//    }];
//    
//    [zylAlert addBtnAlertTitle:@"修改" action:^{
//        
//        SWTTgInfoViewController *xftsVC = [[SWTTgInfoViewController alloc]init];
//        xftsVC.xsListModel = xfListModel;
//        xftsVC.usermapModel = self.usermapModel;
//        [self.navigationController pushViewController:xftsVC animated:YES];
//        
//        
//        
//    }];
//    
//    [zylAlert addBtnAlertTitle:@"删除" action:^{
//        NSMutableDictionary *params  = [NSMutableDictionary dictionary];
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
//        params[@"outusername"] = [userDefault objectForKey:@"name"];
//        params[@"flag"] = @1;
//        params[@"xsid"] = xfListModel.id;
//        [SWTHttpTool post:DeleteXsListInfoUrl params:params success:^(id json) {
//            //
//            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//            NSLog(@"删除成功：%@",json);
//            [self.myTableView.mj_header beginRefreshing];
//        } failure:^(NSError *error) {
//            [SVProgressHUD showErrorWithStatus:@"删除失败"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//            NSLog(@"删除失败：%@",error);
//        }];
//        [self.myTableView.mj_header endRefreshing];
//        
//        
//    }];
//    [zylAlert addBtnAlertTitle:@"取消" action:^{
//        
//        NSLog(@"取消");
//        
//    }];
//    [zylAlert showAlertWithSender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addNew:(id)sender {
    NSString *zjhStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
    if (zjhStr.length > 0) {
        SWTTgInfoViewController *tgInfoVC = [[SWTTgInfoViewController alloc]init];
        [self.navigationController pushViewController:tgInfoVC animated:YES];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后添加"];
        
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
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

- (NSMutableArray *)xiansuoArr {
	if(_xiansuoArr == nil) {
		_xiansuoArr = [[NSMutableArray alloc] init];
	}
	return _xiansuoArr;
}



@end
