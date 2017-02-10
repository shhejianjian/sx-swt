//
//  SWTBookArriveViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTBookArriveViewController.h"
#import "SWTBookArriveCell.h"
#import "SWTWSDetailMainViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTDZWS.h"
#import "SWTWsDetail.h"
#import "SVProgressHUD.h"
#import "SWTSPGKMainViewController.h"
static NSString *ID=@"bookCell";


@interface SWTBookArriveViewController () <SWTBookArriveCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *bookTableView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, strong) NSMutableArray *wssdArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;

@end

@implementation SWTBookArriveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
     [self.bookTableView registerNib:[UINib nibWithNibName:@"SWTBookArriveCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.bookTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.bookTableView.mj_header beginRefreshing];
//    [self loadDzwsSdList];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    self.currentPage = 1;
    [self loadDzwsSdList];
}

- (void)loadDzwsSdList {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"userid"] = self.zjhStr;
    params[@"password"] = self.pwdStr;
        [SWTHttpTool post:LoginToGetWsListUrl params:params success:^(id json) {
            
            self.wssdArr = [SWTDZWS mj_objectArrayWithKeyValuesArray:json[@"wslist"]];
            
            NSLog(@"++%@++%@",json,params);
            [self.bookTableView reloadData];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        }];
//    } else {
//        [SVProgressHUD showErrorWithStatus:@"请前往我的页面进行登录后查看"];
//    }
    [self.bookTableView.mj_header endRefreshing];
}



- (IBAction)back:(id)sender {
    [self jumpToVC];
}

- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SWTSPGKMainViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}



#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.wssdArr.count;
    
}


- (SWTBookArriveCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTBookArriveCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTBookArriveCell alloc]init];
        
    }
    cell.dzwsModel = self.wssdArr[indexPath.row];
    cell.delegate = self;
    cell.ckxqBtn.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 180;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


- (void)didSelect:(SWTBookArriveCell *)cell atIndexPath:(NSInteger)index {
    SWTWSDetailMainViewController *detailVC = [[SWTWSDetailMainViewController alloc]init];
    SWTDZWS *dzwsModel = self.wssdArr[index];
    detailVC.ajbsStr = dzwsModel.ajbs;
    [self.navigationController pushViewController:detailVC animated:YES];
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

- (NSMutableArray *)wssdArr {
	if(_wssdArr == nil) {
		_wssdArr = [[NSMutableArray alloc] init];
	}
	return _wssdArr;
}



@end
