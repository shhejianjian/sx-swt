//
//  SWTcxSecondViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTcxSecondViewController.h"
#import "SWTspcxMainViewController.h"



@interface SWTcxSecondViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation SWTcxSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.court.gov.cn/wenshu.html"];
    
    [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    _myWebView.scalesPageToFit=YES;
    
    _myWebView.multipleTouchEnabled=YES;
    
    _myWebView.userInteractionEnabled=YES;
    // Do any additional setup after loading the view from its nib.
}


//几个代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
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
