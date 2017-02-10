//
//  SWTConsultViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTConsultViewController.h"
#import "SWTRXMainViewController.h"
#import "SWTConDetailViewController.h"
#import "SWTFeedBackCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "XTTextField.h"
#import "SWTSSzxList.h"
static NSString *ID=@"SWTFeedBackCell";

@interface SWTConsultViewController () <XTTextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) XTTextField *xtTextField;
@property (nonatomic, strong) NSMutableArray *sszxListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation SWTConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTFeedBackCell" bundle:nil] forCellReuseIdentifier:ID];
    [self initXTTextField];

    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    [self.myTableView.mj_header beginRefreshing];

    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.sszxListArr removeAllObjects];
    self.currentPage = 1;
    [self loadSSZXList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadSSZXList];
}

- (void)initXTTextField{
    __weak __typeof(&*self)weakSelf = self;
    self.xtTextField = [[XTTextField alloc] initWithDelegate:self];
    [self.xtTextField setFinishAction:^(NSString *text) {
        if ( text.length != 0 ) {
            NSMutableDictionary *params=[NSMutableDictionary dictionary];
            NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
            params[@"outuserid"] = [userDefaults objectForKey:@"loginId"];
            
            params[@"outusername"] = [userDefaults objectForKey:@"name"];
            
            params[@"flag"] = @1;
            params[@"question"] = text;
            [SWTHttpTool post:PostSszxProblem params:params success:^(id json) {
                [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                [weakSelf.myTableView.mj_header beginRefreshing];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"发送失败"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }];
        }
    }];
}


- (void) loadSSZXList {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *loginIdStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
    if (loginIdStr.length > 0) {
        [SVProgressHUD showWithStatus:@"正在加载"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
        params[@"outusername"] = [userDefault objectForKey:@"name"];
    
        params[@"flag"] = @1;
        params[@"page"] = @(self.currentPage);
        params[@"pageSize"] = @8;
        [SWTHttpTool post:GetSszxListUrl params:params success:^(id json) {
            [SVProgressHUD dismiss];
            NSArray *arr = [SWTSSzxList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
            for (SWTSSzxList *sszxListModel in arr) {
                [self.sszxListArr addObject:sszxListModel];
            }
            
            self.totalCount = [json[@"total"] integerValue];
            [self.myTableView reloadData];
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            NSLog(@"++%@",json);
        } failure:^(NSError *error) {
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            NSLog(@"--%@",error);
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后查看"];
    }
    [self.myTableView.mj_header endRefreshing];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.xtTextField viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.xtTextField viewWillDisappear:animated];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.sszxListArr.count == self.totalCount) {
        self.myTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        NSLog(@"1");
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.sszxListArr.count;
}

#pragma mark - Table view  delegate

- (SWTFeedBackCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTFeedBackCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWTFeedBackCell alloc]init];
    }
    cell.sszxListModel = self.sszxListArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)zixunClick:(id)sender {
    NSString *loginIdStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"sfzhm"];
    if (loginIdStr.length > 0) {
    [self.xtTextField setBgViewShow:YES andHeight:50];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后查看"];
    }
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTFeedBackCell *cell = (SWTFeedBackCell *)[self tableView:self.myTableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
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

- (NSMutableArray *)sszxListArr {
	if(_sszxListArr == nil) {
		_sszxListArr = [[NSMutableArray alloc] init];
	}
	return _sszxListArr;
}

@end
