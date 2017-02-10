//
//  SWTZxGfViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTZxGfViewController.h"
#import "SWTCsAndGfTableViewCell.h"
#import "SWTZxgfWebViewController.h"
static NSString *ID=@"csAndGfCell";

@interface SWTZxGfViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *mytableview;

@end

@implementation SWTZxGfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
     [self.mytableview registerNib:[UINib nibWithNibName:@"SWTCsAndGfTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
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
    
    return 6;
    
}


- (SWTCsAndGfTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTCsAndGfTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[SWTCsAndGfTableViewCell alloc]init];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"最高人民法院关于限制被执行人高消费及有关消费的若干规定";
        cell.timeLabel.text = @"2015-08-19";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"最高人民法院关于审理拒不执行判决、裁定刑事案件适用法律若干问题的解释";
        cell.timeLabel.text = @"2015-08-19";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"最高人民法院关于人民法院办理执行异议和复议案件若干问题的规定";
        cell.timeLabel.text = @"2015-07-06";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"最高人民法院关于适用《中华人民共和国民事诉讼法》的解释";
        cell.timeLabel.text = @"2015-04-01";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"最高人民法院关于公布失信被执行人名单信息的若干规定";
        cell.timeLabel.text = @"2015-04-16";
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"最高人民法院关于人民法院民事执行中拍卖、变卖财产的规定";
        cell.timeLabel.text = @"2015-04-16";
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  80;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTZxgfWebViewController *zxgfWebVC = [[SWTZxgfWebViewController alloc]init];
    zxgfWebVC.index = indexPath.row;
    [self.navigationController pushViewController:zxgfWebVC animated:YES];
    
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
