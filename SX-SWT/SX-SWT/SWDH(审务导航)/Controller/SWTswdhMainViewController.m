//
//  SWTswdhMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTswdhMainViewController.h"
#import "SWTLAJFViewController.h"
#import "SWTDHImgViewController.h"
#import "SWTXFDHViewController.h"
#import "SWTLAJFDHViewController.h"
#import "SWTAJCXDHViewController.h"
#import "SWTSSCLDHViewController.h"
#import "SWTFLYZDHViewController.h"

@interface SWTswdhMainViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTswdhMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)ktBtnCLick:(id)sender {
    SWTDHImgViewController *dhNoteVC = [[SWTDHImgViewController alloc]init];
    [self.navigationController pushViewController:dhNoteVC animated:YES];
}
- (IBAction)xfBtnCLick:(id)sender {
    SWTXFDHViewController *dhNoteVC = [[SWTXFDHViewController alloc]init];
    [self.navigationController pushViewController:dhNoteVC animated:YES];
}
- (IBAction)ajcxBtnCLick:(id)sender {
    SWTAJCXDHViewController *dhNoteVC = [[SWTAJCXDHViewController alloc]init];
    [self.navigationController pushViewController:dhNoteVC animated:YES];
}
- (IBAction)ssclzsBtnCLick:(id)sender {
    SWTSSCLDHViewController *dhNoteVC = [[SWTSSCLDHViewController alloc]init];
    [self.navigationController pushViewController:dhNoteVC animated:YES];
}
- (IBAction)flyzzxBtnCLick:(id)sender {
    SWTFLYZDHViewController *dhNoteVC = [[SWTFLYZDHViewController alloc]init];
    [self.navigationController pushViewController:dhNoteVC animated:YES];
}
- (IBAction)lajfdhlcBtnCLick:(id)sender {
    SWTLAJFDHViewController *dhNoteVC = [[SWTLAJFDHViewController alloc]init];
    [self.navigationController pushViewController:dhNoteVC animated:YES];}



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
