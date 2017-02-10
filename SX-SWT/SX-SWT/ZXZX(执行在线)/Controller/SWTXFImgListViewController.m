//
//  SWTXFImgListViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXFImgListViewController.h"
#import "SWTXFListViewController.h"
#import "SWTULXFImgViewController.h"
#import "SWTXfImgListCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTXFImgList.h"
#import "MBProgressHUD+MJ.h"
#import "XWScanImage.h"
static NSString *ID=@"SWTXfImgListCell";



@interface SWTXFImgListViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *xfImgListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation SWTXFImgListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
      [self.myTableView registerNib:[UINib nibWithNibName:@"SWTXfImgListCell" bundle:nil] forCellReuseIdentifier:ID];
    
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
    [self.xfImgListArr removeAllObjects];
    self.currentPage = 1;
    [self loadImgList];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadImgList];
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.myTableView];
        NSIndexPath * indexPath = [self.myTableView indexPathForRowAtPoint:point];
        if(indexPath == nil) return ;
        SWTXFImgList *ssclModel = self.xfImgListArr[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        
        params[@"flag"] = @1;
        params[@"id"] = ssclModel.id;
        [SWTHttpTool post:DeleteXFImgUrl params:params success:^(id json) {
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

- (void)loadImgList {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"xfid"] = self.xfIdStr;
    params[@"page"] = @(self.currentPage);
    params[@"pageSize"] = @8;
    [SWTHttpTool post:GetXFInfoAndImgUrl params:params success:^(id json) {
        
//        self.xfImgListArr = [SWTXFImgList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        NSArray *arr = [SWTXFImgList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        
        for (SWTXFImgList *ajlbModel in arr) {
            [self.xfImgListArr addObject:ajlbModel];
        }
        
        self.totalCount = [json[@"total"] integerValue];
        [self.myTableView reloadData];
        [SVProgressHUD dismiss];        NSLog(@"++%@==%@",json,params);
    } failure:^(NSError *error) {
        NSLog(@"--%@",error);
    }];
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];

}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (self.xfImgListArr.count == self.totalCount) {
        self.myTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.xfImgListArr.count;
    
}


- (SWTXfImgListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTXfImgListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTXfImgListCell alloc]init];
        
    }
    cell.xfImgListModel = self.xfImgListArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 100;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    SWTXfImgListCell *cell = (SWTXfImgListCell *)[self tableView:self.myTableView cellForRowAtIndexPath:indexPath];
    if (cell.showImg.image) {
        [XWScanImage scanBigImageWithImageView:cell.showImg];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}






- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addImgAndUpload:(id)sender {
//    if ([self.checkStatusStr isEqualToString:@"查看"]) {
//        [SVProgressHUD showErrorWithStatus:@"当前处于查看状态下无法添加"];
//    } else {
    SWTULXFImgViewController *upLoadImgVC = [[SWTULXFImgViewController alloc]init];
    upLoadImgVC.xfidStr = self.xfIdStr;
    [self.navigationController pushViewController:upLoadImgVC animated:YES];
//    }
}
- (IBAction)completeAndBack:(id)sender {
    [self jumpToVC];
}
- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SWTXFListViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
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

- (NSMutableArray *)xfImgListArr {
	if(_xfImgListArr == nil) {
		_xfImgListArr = [[NSMutableArray alloc] init];
	}
	return _xfImgListArr;
}

@end
