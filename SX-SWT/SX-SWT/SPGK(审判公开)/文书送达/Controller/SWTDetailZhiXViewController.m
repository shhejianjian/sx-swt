//
//  SWTDetailZhiXViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/17.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTDetailZhiXViewController.h"
#import "SWTBaseInfoCell.h"
#import "SWTWSDetailMainViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTWsDetail.h"
#import "SWTZxrzList.h"
#import "SWTZXRZCell.h"
#import "SVProgressHUD.h"
static NSString *ID=@"SWTZXRZCell";


@interface SWTDetailZhiXViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dsrDetailInfoArr;

@end
extern NSString *subAjbsStr;

@implementation SWTDetailZhiXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTZXRZCell" bundle:nil] forCellReuseIdentifier:ID];
    
    [self loadZXRZList];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadZXRZList {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    params[@"flag"] = @1;
    params[@"page"] = @1;
    params[@"rows"] = @20;
    params[@"ajbs"] = subAjbsStr;
    [SWTHttpTool post:GetZxzxLogListUrl params:params success:^(id json) {

        NSLog(@"%@++==---",json);
        self.dsrDetailInfoArr = [SWTZxrzList mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        [self.myTableView reloadData];

    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.dsrDetailInfoArr.count;
    
}


- (SWTZXRZCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTZXRZCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTZXRZCell alloc]init];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.zxrzListModel = self.dsrDetailInfoArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 130;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)dsrDetailInfoArr {
	if(_dsrDetailInfoArr == nil) {
		_dsrDetailInfoArr = [[NSMutableArray alloc] init];
	}
	return _dsrDetailInfoArr;
}

@end
