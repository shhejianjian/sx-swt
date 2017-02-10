//
//  SWTDetailSecondViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTDetailSecondViewController.h"
#import "SWTWSDetailMainViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTBaseInfoCell.h"
#import "SWTDsrDetail.h"
static NSString *ID1=@"baseInfoCell";

@interface SWTDetailSecondViewController ()
@property (strong, nonatomic) IBOutlet UITableView *dsrDetailTableView;
@property (nonatomic, strong) NSMutableArray *dsrDetailInfoArr;
@end
extern NSString *subAjbsStr;

@implementation SWTDetailSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dsrDetailTableView registerNib:[UINib nibWithNibName:@"SWTBaseInfoCell" bundle:nil] forCellReuseIdentifier:ID1];
    [self loadDetailInfo];
    // Do any additional setup after loading the view from its nib.
}
- (void) loadDetailInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"ajbs"] = subAjbsStr;
    [SWTHttpTool post:GetWSSDDsrDetailInfoUrl params:params success:^(id json) {
        
        NSLog(@"%@++--",json);
        NSArray *arr = [SWTDsrDetail mj_objectArrayWithKeyValuesArray:json];
        for (SWTDsrDetail *dsrDetailModel in arr) {
            [self.dsrDetailInfoArr addObject:dsrDetailModel];
        }
        [self.dsrDetailTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
//    return 1;
    return self.dsrDetailInfoArr.count;
    
}


- (SWTBaseInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTBaseInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:ID1];
    
    if (!cell) {
        
        cell=[[SWTBaseInfoCell alloc]init];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    SWTDsrDetail *dsDetail = self.dsrDetailInfoArr[indexPath.row];
    NSLog(@"dsrDetail:%@==%@",dsDetail.mc,dsDetail.xbmc);
    if (!dsDetail.xbmc) {
        cell.spcxLabel.hidden = YES;
    }
    if (!dsDetail.mzmc) {
        cell.lbLabel.hidden = YES;
    }
    if (!dsDetail.gjmc) {
        cell.labmLabel.hidden = YES;
    }
    cell.spcxLabel.hidden = YES;
    cell.eightLabel.hidden = YES;
    cell.nineLabel.hidden = YES;
    cell.tenLabel.hidden = YES;
    cell.elevenLabel.hidden = YES;
    cell.twlveLabel.hidden = YES;
    cell.thirteenLabel.hidden = YES;
    cell.forteenLabel.hidden = YES;
    cell.fifteenLabel.hidden = YES;
    cell.sixTeenLabel.hidden = YES;
    cell.jieduanLabel.hidden = YES;
    cell.dsrDetailModel = self.dsrDetailInfoArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 180;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
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

- (NSMutableArray *)dsrDetailInfoArr {
	if(_dsrDetailInfoArr == nil) {
		_dsrDetailInfoArr = [[NSMutableArray alloc] init];
	}
	return _dsrDetailInfoArr;
}

@end
