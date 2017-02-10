//
//  SWTbaoguangViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTbaoguangViewController.h"
#import "SWTZXZXMainViewController.h"
#import "SWTCsAndGfTableViewCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTTSGGCell.h"
#import "SWTBgtList.h"
static NSString *ID=@"SWTTSGGCell";

@interface SWTbaoguangViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *bgtListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation SWTbaoguangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.myTableView registerNib:[UINib nibWithNibName:@"SWTTSGGCell" bundle:nil] forCellReuseIdentifier:ID];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.myTableView.mj_header beginRefreshing];    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.bgtListArr removeAllObjects];
    self.currentPage = 1;
    [self loadGsbgxxList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadGsbgxxList];
}

- (void)loadGsbgxxList {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"page"] = @(self.currentPage);
    params[@"rows"] = @5;
    [SVProgressHUD showWithStatus:@"正在加载..."];

    [SWTHttpTool post:GetGsxxBgInfoListUrl params:params success:^(id json) {
        [SVProgressHUD dismiss];
        
        NSArray *arr = [SWTBgtList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        for (SWTBgtList *bgtListModel in arr) {
            [self.bgtListArr addObject:bgtListModel];
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
    

}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.bgtListArr.count == self.totalCount) {
        [self.myTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.bgtListArr.count;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (SWTTSGGCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTTSGGCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[SWTTSGGCell alloc]init];
    }
    cell.bgtListModel = self.bgtListArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  180;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTBgtList *bglistModel = self.bgtListArr[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(didSelectRow:atIndexPath:andmdetailModel:)]) {
        [self.delegate didSelectRow:tableView atIndexPath:indexPath andmdetailModel:bglistModel];
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

- (NSMutableArray *)bgtListArr {
	if(_bgtListArr == nil) {
		_bgtListArr = [[NSMutableArray alloc] init];
	}
	return _bgtListArr;
}

@end
