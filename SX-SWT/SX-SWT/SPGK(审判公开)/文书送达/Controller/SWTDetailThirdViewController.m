//
//  SWTDetailThirdViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTDetailThirdViewController.h"
#import "SWTWSDetailMainViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTBaseInfoCell.h"
#import "SWTWsDetail.h"
#import "SWTSpzzDetail.h"
static NSString *ID1=@"baseInfoCell";

@interface SWTDetailThirdViewController ()
@property (strong, nonatomic) IBOutlet UITableView *spzzDetailTableView;
@property (nonatomic, strong) NSMutableArray *spzzDetailInfoArr;
@end
extern NSString *subAjbsStr;

@implementation SWTDetailThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.spzzDetailTableView registerNib:[UINib nibWithNibName:@"SWTBaseInfoCell" bundle:nil] forCellReuseIdentifier:ID1];
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
    [SWTHttpTool post:GetWSSDSpcxDetailInfoUrl params:params success:^(id json) {
        
        NSArray *arr = [SWTSpzzDetail mj_objectArrayWithKeyValuesArray:json];
        for (SWTSpzzDetail *spzzDetailModel in arr) {
            [self.spzzDetailInfoArr addObject:spzzDetailModel];
        }
        [self.spzzDetailTableView reloadData];
        NSLog(@"spzz:%@",json);
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.spzzDetailInfoArr.count;
    
}


- (SWTBaseInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWTBaseInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:ID1];
    if (!cell) {
        cell=[[SWTBaseInfoCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.labmLabel.hidden = YES;
    cell.lbLabel.hidden = YES;
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

    cell.spzzDetailModel = self.spzzDetailInfoArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 130;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSMutableArray *)spzzDetailInfoArr {
	if(_spzzDetailInfoArr == nil) {
		_spzzDetailInfoArr = [[NSMutableArray alloc] init];
	}
	return _spzzDetailInfoArr;
}

@end
