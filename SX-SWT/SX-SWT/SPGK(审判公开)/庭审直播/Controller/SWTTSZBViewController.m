//
//  SWTTSZBViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/9.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTTSZBViewController.h"

@interface SWTTSZBViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTTSZBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.sxgaofa.cn/ts/index"];
    
    [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    _myWebView.scalesPageToFit=YES;
    
    _myWebView.multipleTouchEnabled=YES;
    
    _myWebView.userInteractionEnabled=YES;
    
}
- (IBAction)back:(id)sender {
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
