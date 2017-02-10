//
//  SWTBaseInfoViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTBaseInfoViewController.h"
#import "SWTWSDetailMainViewController.h"
#import "AFNetWorking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SVProgressHUD.h"
#import "SWTBaseInfoCell.h"
#import "MBProgressHUD+MJ.h"
#import "SWTLoadFileViewController.h"
#import "SWTBase.h"
static NSString *ID1=@"baseInfoCell";



@interface SWTBaseInfoViewController ()

@property (strong, nonatomic) IBOutlet UITableView *baseInfoTableView;
@property (nonatomic, strong) NSMutableArray *detailInfoArr;
@property (nonatomic, copy) NSString *filePath;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;

@end

extern NSString *subAjbsStr;
extern NSString *checkStr;
@implementation SWTBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.baseInfoTableView registerNib:[UINib nibWithNibName:@"SWTBaseInfoCell" bundle:nil] forCellReuseIdentifier:ID1];
    [self loadDetailInfo];
    if ([checkStr isEqualToString:@"审判查询"]) {
        self.downPwdTextField.hidden = YES;
        self.downZjhmTextField.hidden = YES;
        self.downBtn.hidden = YES;
        self.tableViewBottomConstraint.constant = -100;
    }
    if ([checkStr isEqualToString:@"执行在线"]) {
        self.downPwdTextField.hidden = YES;
        self.downZjhmTextField.hidden = YES;
        self.downBtn.hidden = YES;
        self.tableViewBottomConstraint.constant = -100;

    }
}
- (void)viewWillDisappear:(BOOL)animated {
    checkStr = nil;
}

- (void) loadDetailInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"ajbs"] = subAjbsStr;
    [SWTHttpTool post:GetWSSDDetailInfoUrl params:params success:^(id json) {
        NSLog(@"--==--%@",json);
        SWTWsDetail *wsDetailModel = [SWTWsDetail mj_objectWithKeyValues:json[@"ajjbxx"]];
        [self.detailInfoArr addObject:wsDetailModel];
        [self.baseInfoTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.detailInfoArr.count;
    
}


- (SWTBaseInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTBaseInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:ID1];
    
    if (!cell) {
        
        cell=[[SWTBaseInfoCell alloc]init];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.spcxLabel.hidden = YES;
    cell.wsDetailModel = self.detailInfoArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 500;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)downLoadFile:(id)sender {
    if (self.downZjhmTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"用户名不得为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if (self.downPwdTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不得为空"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    if ([self.delegate respondsToSelector:@selector(didClickDownFileBtn:andpwd:andAjbs:)]) {
        [self.delegate didClickDownFileBtn:self.downZjhmTextField.text andpwd:self.downPwdTextField.text andAjbs:subAjbsStr];
    }
}

- (NSMutableArray *)detailInfoArr {
	if(_detailInfoArr == nil) {
		_detailInfoArr = [[NSMutableArray alloc] init];
	}
	return _detailInfoArr;
}

@end
