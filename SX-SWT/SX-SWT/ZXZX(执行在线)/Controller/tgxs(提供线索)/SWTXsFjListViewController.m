//
//  SWTXsFjListViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXsFjListViewController.h"
#import "SWTAddXsViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTXFListCell.h"
#import "MBProgressHUD+MJ.h"
#import "SWTXsListViewController.h"
#import "SWTXsFjList.h"
#import "SWTXfImgListCell.h"
#import "XWScanImage.h"

static NSString *ID=@"SWTXFListCell";


@interface SWTXsFjListViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;

@property (nonatomic, strong) NSMutableArray *fjListArr;
@end

@implementation SWTXsFjListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
     [self.myTableView registerNib:[UINib nibWithNibName:@"SWTXfImgListCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadXsFjList];
    if ([self.checkStatusStr isEqualToString:@"查看"]) {
    } else {
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGr.minimumPressDuration = 1.0;
        [self.myTableView addGestureRecognizer:longPressGr];
    }
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.fjListArr removeAllObjects];
    self.currentPage = 1;
    [self loadXsFjList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadXsFjList];
}
- (void) loadXsFjList {
    [SVProgressHUD showWithStatus:@"正在加载，请稍等"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"page"] = @(self.currentPage);
    params[@"pageSize"] = @8;
    params[@"xsid"] = self.jbxsidStr;
    [SWTHttpTool post:GetXsFjListById params:params success:^(id json) {
        NSArray *arr = [SWTXsFjList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        for (SWTXsFjList *xsfjListModel in arr) {
            [self.fjListArr addObject:xsfjListModel];
        }
        self.totalCount = [json[@"total"] integerValue];
        [self.myTableView reloadData];
        [SVProgressHUD dismiss];
        NSLog(@"++%@--%@",json,params);
    } failure:^(NSError *error) {
        NSLog(@"--%@",error);
    }];
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];

}
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.myTableView];
        NSIndexPath * indexPath = [self.myTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        SWTXsFjList *ssclModel = self.fjListArr[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        params[@"flag"] = @1;
        params[@"xsfjid"] = ssclModel.id;
        [SWTHttpTool post:DeleteXsFjUrl params:params success:^(id json) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self.myTableView.mj_header beginRefreshing];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络不稳定,请稍后再试"];
        }];
        [self.myTableView.mj_header endRefreshing];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self.myTableView.mj_header beginRefreshing];
    
}

- (IBAction)completeAndBack:(id)sender {
    [self jumpToVC];
}
- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SWTXsListViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)addNewAndUpload:(id)sender {
    
//    if ([self.checkStatusStr isEqualToString:@"查看"]) {
//        [SVProgressHUD showErrorWithStatus:@"当前处于查看状态下无法添加"];
//    } else {
    SWTAddXsViewController *addXsVC = [[SWTAddXsViewController alloc]init];
    addXsVC.jbxsIdStr = self.jbxsidStr;
    [self.navigationController pushViewController:addXsVC animated:YES];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.fjListArr.count == self.totalCount) {
        self.myTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.fjListArr.count;
    
}


- (SWTXfImgListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTXfImgListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTXfImgListCell alloc]init];
        
    }
    cell.fjListModel = self.fjListArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 100;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTXfImgListCell *cell = (SWTXfImgListCell *)[self tableView:self.myTableView cellForRowAtIndexPath:indexPath];
    if (cell.showImg.image) {
        [XWScanImage scanBigImageWithImageView:cell.showImg];
    }
//    if ([self.checkStatusStr isEqualToString:@"查看"]) {
//        NSLog(@"1");
//    } else {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"长按可删除";
//        hud.margin = 10.f;
//        hud.yOffset = 150.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:3];
//    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)fjListArr {
	if(_fjListArr == nil) {
		_fjListArr = [[NSMutableArray alloc] init];
	}
	return _fjListArr;
}

@end
