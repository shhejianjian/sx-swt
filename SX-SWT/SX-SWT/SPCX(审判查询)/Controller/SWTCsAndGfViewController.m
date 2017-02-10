//
//  SWTCsAndGfViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTCsAndGfViewController.h"
#import "SWTCsAndGfTableViewCell.h"
#import "SWTZxcsWebViewController.h"

static NSString *ID=@"csAndGfCell";

@interface SWTCsAndGfViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation SWTCsAndGfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTCsAndGfTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 11;
    
}


- (SWTCsAndGfTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTCsAndGfTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[SWTCsAndGfTableViewCell alloc]init];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"向法院申请恢复执行时，我应该提供哪些材料？";
        cell.timeLabel.text = @"2011-12-06";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"法院为什么要暂时停止执行我的判决?";
        cell.timeLabel.text = @"2011-12-06";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"申请执行时，我需要向法院交纳申请费吗？";
        cell.timeLabel.text = @"2011-12-06";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"申请执行书怎么写？";
        cell.timeLabel.text = @"2011-12-06";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"向法院申请执行时，我应该提交哪些材料？";
        cell.timeLabel.text = @"2011-12-06";
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"我应当在何时申请执行？";
        cell.timeLabel.text = @"2011-12-06";
    } else if (indexPath.row == 6) {
        cell.titleLabel.text = @"哪些生效的法律文书可以向法院申请执行？";
        cell.timeLabel.text = @"2011-12-06";
    } else if (indexPath.row == 7) {
        cell.titleLabel.text = @"收费标准";
        cell.timeLabel.text = @"2014-04-16";
    } else if (indexPath.row == 8) {
        cell.titleLabel.text = @"申请执行人须知";
        cell.timeLabel.text = @"2014-04-16";
    } else if (indexPath.row == 9) {
        cell.titleLabel.text = @"被执行人须知";
        cell.timeLabel.text = @"2014-04-16";
    } else if (indexPath.row == 10) {
        cell.titleLabel.text = @"风险告知";
        cell.timeLabel.text = @"2014-04-16";
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  80;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTZxcsWebViewController *zxcsWebVC = [[SWTZxcsWebViewController alloc]init];
    zxcsWebVC.index = indexPath.row;
    [self.navigationController pushViewController:zxcsWebVC animated:YES];
    
    
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
