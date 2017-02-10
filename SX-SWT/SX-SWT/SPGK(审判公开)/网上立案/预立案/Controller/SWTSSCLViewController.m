//
//  SWTSSCLViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSSCLViewController.h"
#import "SWTAJLBViewController.h"
#import "SWTPartyCell.h"
#import "SWTSecondPartyCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTUploadCLViewController.h"
#import "SWTSscl.h"
#import "MBProgressHUD+MJ.h"
#import "SWTBase.h"
#import "SVProgressHUD.h"
#import "SWTXFImgList.h"
#import "SWTXfImgListCell.h"
#import "XWScanImage.h"
static NSString *identifier1 = @"cell1";
static NSString *identifier2 = @"cell2";

@interface SWTSSCLViewController ()

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *ssclArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

NSString *checkAjlbStr;

@implementation SWTSSCLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"SWTXfImgListCell" bundle:nil] forCellReuseIdentifier:identifier1];
    [self.tableview registerNib:[UINib nibWithNibName:@"SWTSecondPartyCell" bundle:nil] forCellReuseIdentifier:identifier2];
    if ([self.checkStatusStr isEqualToString:@"查看"]) {
    } else {
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGr.minimumPressDuration = 1.0;
        [self.tableview addGestureRecognizer:longPressGr];
    }
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData
{
    [self.ssclArr removeAllObjects];
    self.currentPage = 1;
    [self loadSsclInfo];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadSsclInfo];
}
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.tableview];
        NSIndexPath * indexPath = [self.tableview indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        SWTXFImgList *ssclModel = self.ssclArr[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        
        params[@"flag"] = @1;
        params[@"ssclid"] = ssclModel.ajbs;
        [SWTHttpTool post:DelSsclUrl params:params success:^(id json) {
            NSLog(@"ssclModel:%@",params);
            SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
            
            if ([baseModel.flag isEqualToString:@"1"]) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            } else {
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            [self.tableview.mj_header beginRefreshing];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        [self.tableview.mj_header endRefreshing];
        
    }
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self.tableview.mj_header beginRefreshing];

}

- (void)loadSsclInfo {
    [self.ssclArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ylainfoid"] = self.ylaInfoId;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"page"] = @(self.currentPage);
    params[@"pageSize"] = @"8";
    [SWTHttpTool post:GetSsclListUrl params:params success:^(id json) {
        NSArray *arr = [SWTXFImgList mj_objectArrayWithKeyValuesArray:json[@"rows"]];        
        for (SWTXFImgList *ajlbModel in arr) {
            [self.ssclArr addObject:ajlbModel];
        }
        
        self.totalCount = [json[@"total"] integerValue];
        [self.tableview reloadData];
        [SVProgressHUD dismiss];
        NSLog(@"%@",json);
    } failure:^(NSError *error) {
        NSLog(@"--%@",error);
    }];
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addSSCL:(id)sender {
    if ([self.checkStatusStr isEqualToString:@"查看"]) {
        [SVProgressHUD showErrorWithStatus:@"当前处于查看状态下无法添加"];
    } else {
        SWTUploadCLViewController *uploadVC = [[SWTUploadCLViewController alloc]init];
        uploadVC.uploadYlaInfoId = self.ylaInfoId;
        [self.navigationController pushViewController:uploadVC animated:YES];
    }
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)completeAndBackToAJLB:(id)sender {
    [self jumpToVC];
}
- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SWTAJLBViewController class]]) {
            checkAjlbStr = @"完成";
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.ssclArr.count == self.totalCount) {
        self.tableview.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableview.mj_footer.state = MJRefreshStateIdle;
    }
    return self.ssclArr.count;
}
- (SWTXfImgListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        SWTXfImgListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell) {
            cell = [[SWTXfImgListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
    cell.ssclListModel = self.ssclArr[indexPath.row];

        return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.checkStatusStr isEqualToString:@"查看"]) {
        SWTXfImgListCell *cell = (SWTXfImgListCell *)[self tableView:self.tableview cellForRowAtIndexPath:indexPath];
        if (cell.showImg.image) {
            [XWScanImage scanBigImageWithImageView:cell.showImg];
        }
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"长按可删除";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)ssclArr {
	if(_ssclArr == nil) {
		_ssclArr = [[NSMutableArray alloc] init];
	}
	return _ssclArr;
}

@end
