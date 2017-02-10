//
//  SWTChangeInfoViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTChangeInfoViewController.h"
#import "SWTAddPartyViewController.h"
#import "SWTSSCLViewController.h"
@interface SWTChangeInfoViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)changeToDSR:(id)sender {
    SWTAddPartyViewController *dsrVC = [[SWTAddPartyViewController alloc]init];
    [self.navigationController pushViewController:dsrVC animated:YES];
}

- (IBAction)changeToSSCL:(id)sender {
    SWTSSCLViewController *ssclVC = [[SWTSSCLViewController alloc]init];
    [self.navigationController pushViewController:ssclVC animated:YES];
}




- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveAndBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
