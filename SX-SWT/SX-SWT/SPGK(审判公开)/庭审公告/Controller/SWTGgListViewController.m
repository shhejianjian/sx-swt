//
//  SWTGgListViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/8.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTGgListViewController.h"
#import "SWTTSGGCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTTsggList.h"
#import "HMDatePickView.h"

static NSString *ID=@"SWTTSGGCell";


@interface SWTGgListViewController () <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *tsggArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;

@property (strong, nonatomic) IBOutlet UISearchBar *mysearchBar;
@property (strong, nonatomic) IBOutlet UIButton *startTime;
@property (strong, nonatomic) IBOutlet UIButton *endTime;


@end

@implementation SWTGgListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
     [self.myTableView registerNib:[UINib nibWithNibName:@"SWTTSGGCell" bundle:nil] forCellReuseIdentifier:ID];
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.myTableView.mj_header beginRefreshing];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",[NSDate date]];
    NSString *titleDateStr = [dateStr substringWithRange:NSMakeRange(0, 10)];
    [self.startTime setTitle:titleDateStr forState:UIControlStateNormal];
    [self.endTime setTitle:titleDateStr forState:UIControlStateNormal];

//    self.mysearchBar.showsCancelButton = YES;
    self.mysearchBar.delegate = self;
//    self.mysearchBar.showsSearchResultsButton = YES;
   
    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.tsggArr removeAllObjects];
    self.currentPage = 1;
    [self loadGgList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadGgList];
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (void)loadGgList {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    params[@"fydm"] = [userDefault objectForKey:@"selectFyDM"];
    params[@"flag"] = @1;
    params[@"page"] = @(self.currentPage);
    params[@"pageSize"] = @5;
    params[@"ahqc"] = self.mysearchBar.text;
//    params[@"fymc"] = self.fydmStr;
//    params[@"laay"] = self.mysearchBar.text;
    params[@"kssj"] = [NSString stringWithFormat:@"%@ 00:00:00",self.startTime.titleLabel.text];
    params[@"jssj"] = [NSString stringWithFormat:@"%@ 23:59:59",self.endTime.titleLabel.text];
    [SWTHttpTool post:GetTsggListUrl params:params success:^(id json) {
        [SVProgressHUD dismiss];

        NSArray *arr = [SWTTsggList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        for (SWTTsggList *spcxlistModel in arr) {
            [self.tsggArr addObject:spcxlistModel];
        }
        self.totalCount = [json[@"total"] integerValue];
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSLog(@"++%@++%@",json,params);
    } failure:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        NSLog(@"++%@",error);
    }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.myTableView.mj_header beginRefreshing];
//    [self loadNewData];
}

- (IBAction)startTImeBtnCLick:(id)sender {
    /** 自定义日期选择器 */
    
    HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:self.view.frame];
    //距离当前日期的年份差（设置最大可选日期）
    datePickVC.maxYear = -1;
    //设置最小可选日期(年分差)
    datePickVC.minYear = 10;
    datePickVC.date = [NSDate date];
    //设置字体颜色
    datePickVC.fontColor = SWTRedColor;
    //日期回调
    datePickVC.completeBlock = ^(NSString *selectDate) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        NSDate *date1=[dateFormatter dateFromString:selectDate];
//        NSDate *date2=[dateFormatter dateFromString:self.endTime.titleLabel.text];
//        NSComparisonResult result = [date1 compare:date2];
//        NSLog(@"date1 : %@, date2 : %@", date1, date2);
//        if (result == NSOrderedDescending) {
//            [SVProgressHUD showErrorWithStatus:@"开始时间不能超过结束时间"];
//        } else if (result == NSOrderedAscending){
//            [self.startTime setTitle:selectDate forState:UIControlStateNormal];
//        }
//        [self loadNewData];
//        [self.myTableView.mj_header beginRefreshing];

    };
    //配置属性
    [datePickVC configuration];
    
    [self.view addSubview:datePickVC];
    
}
- (IBAction)endTImeBtnCLick:(id)sender {
    
    /** 自定义日期选择器 */
    
    HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:self.view.frame];
    //距离当前日期的年份差（设置最大可选日期）
    datePickVC.maxYear = -2;
    //设置最小可选日期(年分差)
    datePickVC.minYear = 1;
    datePickVC.date = [NSDate date];
    //设置字体颜色
    datePickVC.fontColor = SWTRedColor;
    //日期回调
    datePickVC.completeBlock = ^(NSString *selectDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date1=[dateFormatter dateFromString:selectDate];
        NSDate *date2=[dateFormatter dateFromString:self.startTime.titleLabel.text];
        NSComparisonResult result = [date1 compare:date2];
        NSLog(@"date1 : %@, date2 : %@", date1, date2);
        if (result == NSOrderedDescending) {
            [self.endTime setTitle:selectDate forState:UIControlStateNormal];
            [self.myTableView.mj_header beginRefreshing];

        } else if (result == NSOrderedAscending){
            [SVProgressHUD showErrorWithStatus:@"结束时间不能早于开始时间"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }


    };
    //配置属性
    [datePickVC configuration];
    
    [self.view addSubview:datePickVC];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.tsggArr.count == self.totalCount) {
        self.myTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.tsggArr.count;
}


- (SWTTSGGCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTTSGGCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTTSGGCell alloc]init];
        
    }
    cell.tsggListModel = self.tsggArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 160;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)tsggArr {
	if(_tsggArr == nil) {
		_tsggArr = [[NSMutableArray alloc] init];
	}
	return _tsggArr;
}

@end
