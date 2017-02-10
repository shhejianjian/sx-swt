//
//  SWTLoadWBWebViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/30.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTLoadWBWebViewController.h"

@interface SWTLoadWBWebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation SWTLoadWBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSURL alloc]initWithString:@"http://weibo.com/u/3912076973"];
    
    [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    _myWebView.scalesPageToFit=YES;
    
    _myWebView.multipleTouchEnabled=YES;
    
    _myWebView.userInteractionEnabled=YES;
    // Do any additional setup after loading the view from its nib.
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
