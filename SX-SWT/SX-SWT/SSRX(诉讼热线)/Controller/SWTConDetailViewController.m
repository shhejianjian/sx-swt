//
//  SWTConDetailViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTConDetailViewController.h"

@interface SWTConDetailViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTConDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];

    [self loadWebView];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadWebView {
    if (self.index == 0) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContentsslc" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 1) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContentsqzs" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 2) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContentlatj" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 3) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContentsswsys" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 4) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContentssfxts" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 5) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent19" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 6) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent1" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 7) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent2" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 8) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent3" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 9) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent4" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 10) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent5" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 11) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent6" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 12) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent7" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 13) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent8" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 14) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent9" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 15) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent10" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 16) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent11" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 17) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent12" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 18) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent13" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 19) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent14" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 20) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent15" ofType:@"html"]isDirectory:NO]]];

    } else if (self.index == 21) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent16" ofType:@"html"]isDirectory:NO]]];

    } else if (self.index == 22) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent17" ofType:@"html"]isDirectory:NO]]];

    } else if (self.index == 23) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent18" ofType:@"html"]isDirectory:NO]]];

    } else if (self.index == 24) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ssznContent20" ofType:@"html"]isDirectory:NO]]];

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
