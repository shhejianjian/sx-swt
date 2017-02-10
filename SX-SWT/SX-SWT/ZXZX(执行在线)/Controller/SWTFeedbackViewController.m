//
//  SWTFeedbackViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/18.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTFeedbackViewController.h"
#import "LSSSZNCell.h"
#import "SWTConDetailViewController.h"
static NSString *ID=@"LSSSZNCell";


@interface SWTFeedbackViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [self.myTableView registerNib:[UINib nibWithNibName:@"LSSSZNCell" bundle:nil] forCellReuseIdentifier:ID];
    // Do any additional setup after loading the view from its nib.
}






#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}



- (LSSSZNCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    LSSSZNCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[LSSSZNCell alloc]init];
        
    }
    cell.guidanceLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0) {
        cell.guidanceLabel.text = @"诉讼流程";
    } else if (indexPath.row == 1) {
        cell.guidanceLabel.text = @"申请再审、申诉条件及要求";
    } else if (indexPath.row == 2) {
        cell.guidanceLabel.text = @"立案条件";
    } else if (indexPath.row == 3) {
        cell.guidanceLabel.text = @"诉讼文书样式";
    } else if (indexPath.row == 4) {
        cell.guidanceLabel.text = @"诉讼风险提示";
    } else if (indexPath.row == 5) {
        cell.guidanceLabel.text = @"诉讼费用";
    } else if (indexPath.row == 6) {
        cell.guidanceLabel.text = @"民事诉讼风险提示书";
        
    } else if (indexPath.row == 7) {
        cell.guidanceLabel.text = @"当事人诉讼权利与义务须知";
        
    } else if (indexPath.row == 8) {
        cell.guidanceLabel.text = @"登记立案须知";
        
    } else if (indexPath.row == 9) {
        cell.guidanceLabel.text = @"民事案件起诉须知";
        
    } else if (indexPath.row == 10) {
        cell.guidanceLabel.text = @"小额诉讼须知";
        
    } else if (indexPath.row == 11) {
        cell.guidanceLabel.text = @"行政案件起诉须知";
        
    } else if (indexPath.row == 12) {
        cell.guidanceLabel.text = @"刑事自诉案件起诉须知";
        
    } else if (indexPath.row == 13) {
        cell.guidanceLabel.text = @"刑事附带民事案件起诉须知";
        
    } else if (indexPath.row == 14) {
        cell.guidanceLabel.text = @"申请保全须知";
        
    } else if (indexPath.row == 15) {
        cell.guidanceLabel.text = @"申请先予执行须知";
        
    } else if (indexPath.row == 16) {
        cell.guidanceLabel.text = @"上诉须知";
        
    } else if (indexPath.row == 17) {
        cell.guidanceLabel.text = @"申请执行须知";
        
    } else if (indexPath.row == 18) {
        cell.guidanceLabel.text = @"民事案件申请再审须知";
        
    } else if (indexPath.row == 19) {
        cell.guidanceLabel.text = @"行政案件申请再审须知";
        
    } else if (indexPath.row == 20) {
        cell.guidanceLabel.text = @"刑事案件申诉须知";
        
    } else if (indexPath.row == 21) {
        cell.guidanceLabel.text = @"诉前调解建议书";
        
    } else if (indexPath.row == 22) {
        cell.guidanceLabel.text = @"立案调解建议书";
        
    } else if (indexPath.row == 23) {
        cell.guidanceLabel.text = @"司法文书电子送达须知";
        
    } else if (indexPath.row == 24) {
        cell.guidanceLabel.text = @"人民法院关于缓、减、免交诉讼费的规定";
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTConDetailViewController *conDetailVC = [[SWTConDetailViewController alloc]init];
    conDetailVC.index = indexPath.row;
    [self.navigationController pushViewController:conDetailVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
