//
//  SWTXFListViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/9.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXFListViewController.h"
#import "SWTXFTSViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTXFListCell.h"
#import "ZYLAlert.h"
#import "SWTXFDetailViewController.h"

static NSString *ID=@"SWTXFListCell";


@interface SWTXFListViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backbtn;
@property (strong, nonatomic) IBOutlet UITableView *mytableView;
@property (nonatomic, strong) NSMutableArray *xfListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation SWTXFListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backbtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.mytableView registerNib:[UINib nibWithNibName:@"SWTXFListCell" bundle:nil] forCellReuseIdentifier:ID];
    self.mytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.mytableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.xfListArr removeAllObjects];
    self.currentPage = 1;
    [self loadXFList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadXFList];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.mytableView.mj_header beginRefreshing];
}
- (void)loadXFList {
    [SVProgressHUD showWithStatus:@"正在加载，请稍等"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *zjhStr = [userDefault objectForKey:@"sfzhm"];
    if (zjhStr.length > 0) {
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        params[@"flag"] = @1;
        params[@"page"] = @(self.currentPage);
        params[@"pageSize"] = @6;
        params[@"sfzjhm"] = zjhStr;
        [SWTHttpTool post:GetXFTSListUrl params:params success:^(id json) {
            
            NSArray *arr = [SWTXFList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
            for (SWTXFList *xflistModel in arr) {
                [self.xfListArr addObject:xflistModel];
            }
            self.totalCount = [json[@"total"] integerValue];

            [self.mytableView reloadData];
            [SVProgressHUD dismiss];
            [self.mytableView.mj_header endRefreshing];
            [self.mytableView.mj_footer endRefreshing];
            NSLog(@"++%@++%@",json,params);
        } failure:^(NSError *error) {
            [self.mytableView.mj_header endRefreshing];
            [self.mytableView.mj_footer endRefreshing];
            NSLog(@"++%@",error);
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后查看"];
        
    }
    [self.mytableView.mj_header endRefreshing];

}


- (IBAction)addNew:(id)sender {
    NSString *zjhStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
    if (zjhStr.length > 0) {
        [SWTHttpTool get:GetXFUUIDUrl params:nil success:^(id json) {
            NSLog(@"%@",json);
            SWTXFTSViewController *xftsVC = [[SWTXFTSViewController alloc]init];
            [self.navigationController pushViewController:xftsVC animated:YES];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后添加"];
        
    }
    
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.xfListArr.count == self.totalCount) {
        self.mytableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.mytableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.xfListArr.count;
    
}


- (SWTXFListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTXFListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTXFListCell alloc]init];
        
    }
    cell.xfListModel = self.xfListArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 180;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTXFList *xfListModel = self.xfListArr[indexPath.row];

//    ZYLAlert *zylAlert = [[ZYLAlert alloc] initWithTitle:@"提示" message:@"请选择您的操作"];
//    [zylAlert addBtnAlertTitle:@"查看" action:^{
        SWTXFDetailViewController *xfDetailVC = [[SWTXFDetailViewController alloc]init];
        xfDetailVC.xfListModel = xfListModel;
        [self.navigationController pushViewController:xfDetailVC animated:YES];
       
        
//    }];
    
//    [zylAlert addBtnAlertTitle:@"修改" action:^{
//        
//        SWTXFTSViewController *xftsVC = [[SWTXFTSViewController alloc]init];
//        xftsVC.xfListModel = xfListModel;
//        [self.navigationController pushViewController:xftsVC animated:YES];
//    }];
    
//    [zylAlert addBtnAlertTitle:@"删除" action:^{
//        NSMutableDictionary *params  = [NSMutableDictionary dictionary];
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
//        params[@"outusername"] = [userDefault objectForKey:@"name"];
//        params[@"flag"] = @1;
//        params[@"id"] = xfListModel.id;
////        NSLog(@"++++%@",ajlbModel.id);
//        [SWTHttpTool post:DeleteXFInfoUrl params:params success:^(id json) {
////
//            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//            NSLog(@"删除成功：%@",json);
//            [self.mytableView.mj_header beginRefreshing];
//        } failure:^(NSError *error) {
//            [SVProgressHUD showErrorWithStatus:@"删除失败"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//            NSLog(@"删除失败：%@",error);
//        }];
//        [self.mytableView.mj_header endRefreshing];
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

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)xfListArr {
	if(_xfListArr == nil) {
		_xfListArr = [[NSMutableArray alloc] init];
	}
	return _xfListArr;
}

@end
