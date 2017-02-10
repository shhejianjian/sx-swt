//
//  SWTZxcsWebViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/17.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTZxcsWebViewController.h"

@interface SWTZxcsWebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTZxcsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self loadWebView];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadWebView {
    if (self.index == 0) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent1" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 1) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent2" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 2) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent3" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 3) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent4" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 4) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent5" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 5) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent6" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 6) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent7" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 7) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent8" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 8) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent9" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 9) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent10" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 10) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent11" ofType:@"html"]isDirectory:NO]]];
    }
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
