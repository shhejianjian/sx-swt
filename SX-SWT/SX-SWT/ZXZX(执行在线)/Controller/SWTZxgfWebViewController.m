//
//  SWTZxgfWebViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/17.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTZxgfWebViewController.h"

@interface SWTZxgfWebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTZxgfWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self loadWebView];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadWebView {
    if (self.index == 0) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent12" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 1) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent13" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 2) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent14" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 3) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent15" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 4) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent16" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 5) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"zxcsContent17" ofType:@"html"]isDirectory:NO]]];
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
