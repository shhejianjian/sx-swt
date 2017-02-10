//
//  SWTNewsTableViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTNewsTableViewController.h"
#import "SWTNewsViewController.h"
#import "SWTMainNewsCell.h"
#import "SWTSubNewsViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTMainNews.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

static NSString *ID=@"mainNewsCell";
@interface SWTNewsTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *MainNewsTableView;
@property (nonatomic, strong) NSMutableArray *newsCenterArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;

@end

@implementation SWTNewsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"+++%@",self.MyIdStr);
    
    [self.MainNewsTableView registerNib:[UINib nibWithNibName:@"SWTMainNewsCell" bundle:nil] forCellReuseIdentifier:ID];
    self.MainNewsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.MainNewsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.MainNewsTableView.mj_header beginRefreshing];

}
//- (void)viewWillAppear:(BOOL)animated {
//    [self.MainNewsTableView.mj_header beginRefreshing];
//}
- (void)loadNewData
{
    [self.newsCenterArr removeAllObjects];
    self.currentPage = 1;
    [self load];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self load];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (void)load {
    [SVProgressHUD showWithStatus:@"正在加载"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"page"] = @(self.currentPage);
    params[@"pageSize"] = @"6";
    params[@"columncode"] = self.MyIdStr;
    [SWTHttpTool post:NewsTableUrl params:params success:^(id json) {
        
        NSArray *arr = [SWTMainNews mj_objectArrayWithKeyValuesArray:json[@"data"]];
        self.totalCount = [json[@"total"] integerValue];

                for (SWTMainNews *mainNews in arr) {
                    [self.newsCenterArr addObject:mainNews];
                }
        [self.MainNewsTableView reloadData];
        [SVProgressHUD dismiss];
        [self.MainNewsTableView.mj_header endRefreshing];
        [self.MainNewsTableView.mj_footer endRefreshing];

        NSLog(@"%@",json);
            } failure:^(NSError *error) {
                [self.MainNewsTableView.mj_header endRefreshing];
                [self.MainNewsTableView.mj_footer endRefreshing];
                NSLog(@"%@",error);
            }];
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.newsCenterArr.count == self.totalCount) {
        self.MainNewsTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.MainNewsTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.newsCenterArr.count;
}


- (SWTMainNewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWTMainNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[SWTMainNewsCell alloc]init];
    }
    cell.mainNews = self.newsCenterArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTSubNewsViewController *subNewsVC = [[SWTSubNewsViewController alloc]init];
    SWTMainNews *mainNews = self.newsCenterArr[indexPath.row];
    subNewsVC.NewsModel = mainNews;
    [self.navigationController pushViewController:subNewsVC animated:YES];
//    [self presentViewController:subNewsVC animated:YES completion:^{
//        NSLog(@"present");
//    }];
//    [self.navigationController pushViewController:subNewsVC animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ([self.delegate respondsToSelector:@selector(didSelect:atIndexPath:)]) {
//        [self.delegate didSelect:tableView atIndexPath:indexPath];
//    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)newsCenterArr {
	if(_newsCenterArr == nil) {
		_newsCenterArr = [[NSMutableArray alloc] init];
	}
	return _newsCenterArr;
}

@end
