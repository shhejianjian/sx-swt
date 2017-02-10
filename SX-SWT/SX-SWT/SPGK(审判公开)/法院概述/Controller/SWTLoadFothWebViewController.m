//
//  SWTLoadFothWebViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTLoadFothWebViewController.h"

@interface SWTLoadFothWebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation SWTLoadFothWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadWebView {
    if (self.index == 0) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent1" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 1) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent2" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 2) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent3" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 3) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent4" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 4) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent5" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 5) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent6" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 6) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent7" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 7) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent8" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 8) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent9" ofType:@"html"]isDirectory:NO]]];
    } else if (self.index == 9) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cyalContent10" ofType:@"html"]isDirectory:NO]]];
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
