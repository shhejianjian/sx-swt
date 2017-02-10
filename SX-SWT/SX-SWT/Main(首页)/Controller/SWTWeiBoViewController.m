
//
//  SWTWeiBoViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/30.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTWeiBoViewController.h"
#import "SWTLoadWBWebViewController.h"

@interface SWTWeiBoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *showImg;

@end

@implementation SWTWeiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showImg.layer.cornerRadius = 75;
    self.showImg.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)loadWebBtnClick:(id)sender {
    SWTLoadWBWebViewController *weiboWebView = [[SWTLoadWBWebViewController alloc]init];
    [self.navigationController pushViewController:weiboWebView animated:YES];
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
