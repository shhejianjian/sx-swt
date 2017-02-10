//
//  SWTLoadFileViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/17.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTLoadFileViewController.h"

@interface SWTLoadFileViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation SWTLoadFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
//    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"传票及存根" ofType:@"doc"]isDirectory:NO]]];
    
    [self loadwebView];
    self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
                self.myWebView.scalesPageToFit=YES;
    self.myWebView.multipleTouchEnabled=YES;
    self.myWebView.userInteractionEnabled=YES;
}


- (void) loadwebView {
//    NSString *txtPath=[[NSBundle mainBundle]pathForResource:@"city_list" ofType:@"txt"];
//    
//    NSLog(@"txtPath:%@",txtPath);
    
    ///编码可以解决 .txt 中文显示乱码问题
    
    NSStringEncoding *useEncodeing = nil;
    
    //带编码头的如utf-8等，这里会识别出来
    
    NSString *body = [NSString stringWithContentsOfFile:self.path usedEncoding:useEncodeing error:nil];
    
    //识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug。
    
    if (!body) {
        
        body = [NSString stringWithContentsOfFile:self.path encoding:0x80000632 error:nil];
        
        NSLog(@"%@",body);
        
    }
    
    //还是识别不到，按GB18030编码再解码一次.
    
    if (!body) {
        
        body = [NSString stringWithContentsOfFile:self.path encoding:0x80000631 error:nil];
        
        NSLog(@"%@",body);
        
    }
    
    //展现
    
    if (body) {
        
        NSLog(@"%@",body);
        
        NSData *data=[body dataUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"data:%@",data);
        
        [self.myWebView loadHTMLString:body baseURL: nil];
        
    }else {
        
        NSString *urlString = [[NSBundle mainBundle] pathForAuxiliaryExecutable:self.path];
        
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *requestUrl = [NSURL URLWithString:urlString];
        
        NSLog(@"%@",urlString);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
        
        [self.myWebView loadRequest:request];
        
    }
    
    

}

// 自定义方法 获取指定URL的MIMEType类型
- (NSString *)mimeType:(NSURL *)url
{
    // 1. NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 2. NSURLConnection
    // 从NSURLResponse可以获取到服务器返回的MIMEType
    // 使用同步方法获取response里面的MIMEType
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response error:nil];
    return response.MIMEType;
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
