//
//  SWTWSDetailMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTWSDetailMainViewController.h"
#import "SWTDetailThirdViewController.h"
#import "SWTDetailSecondViewController.h"
#import "SWTBaseInfoViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTDetailZhiXViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetWorking.h"
#import "SWTLoadFileViewController.h"
@interface SWTWSDetailMainViewController () <FJSlidingControllerDelegate,FJSlidingControllerDataSource,SWTBaseInfoViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *controllers;
@property (nonatomic, copy) NSString *filePath;
@end



NSString *subAjbsStr;
NSString *checkStr;
@implementation SWTWSDetailMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    subAjbsStr = self.ajbsStr;
    checkStr = self.checkTypeStr;
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.datasouce = self;
    self.delegate = self;
    
    if ([self.checkTypeStr isEqualToString:@"执行在线"]) {
        SWTBaseInfoViewController *v1 = [[SWTBaseInfoViewController alloc]init];
        
        v1.parentController = self;
        SWTDetailSecondViewController *v2 = [[SWTDetailSecondViewController alloc]init];
        v2.parentController = self;
        SWTDetailThirdViewController *v3 = [[SWTDetailThirdViewController alloc]init];
        v3.parentController = self;
        SWTDetailZhiXViewController *v4 = [[SWTDetailZhiXViewController alloc]init];
        v4.parentController = self;
        
        self.titles      = @[@"基本信息",@"当事人",@"审判组织",@"执行日志"];
        self.controllers = @[v1,v2,v3,v4];
        [self addChildViewController:v1];
        [self addChildViewController:v2];
        [self addChildViewController:v3];
        [self addChildViewController:v4];
        [self reloadData];
    } else {
        SWTBaseInfoViewController *v1 = [[SWTBaseInfoViewController alloc]init];
        v1.delegate = self;
        v1.parentController = self;
        SWTDetailSecondViewController *v2 = [[SWTDetailSecondViewController alloc]init];
        v2.parentController = self;
        SWTDetailThirdViewController *v3 = [[SWTDetailThirdViewController alloc]init];
        v3.parentController = self;
        
        self.titles      = @[@"基本信息",@"当事人",@"审判组织"];
        self.controllers = @[v1,v2,v3];
        [self addChildViewController:v1];
        [self addChildViewController:v2];
        [self addChildViewController:v3];
        [self reloadData];
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}



- (void)viewWillDisappear:(BOOL)animated {
    self.checkTypeStr = nil;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark dataSouce
- (NSInteger)numberOfPageInFJSlidingController:(FJSlidingController *)fjSlidingController{
    return self.titles.count;
}
- (UIViewController *)fjSlidingController:(FJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index{
    return self.controllers[index];
}
- (NSString *)fjSlidingController:(FJSlidingController *)fjSlidingController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
#pragma mark delegate
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedIndex:(NSInteger)index{
    // presentIndex
    NSLog(@"%ld",index);
    self.title = [self.titles objectAtIndex:index];
}
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedController:(UIViewController *)controller{
    // presentController
}
- (void)fjSlidingController:(FJSlidingController *)fjSlidingController selectedTitle:(NSString *)title{
    // presentTitle
}

- (void)didClickDownFileBtn:(NSString *)username andpwd:(NSString *)pwd andAjbs:(NSString *)ajbsStr {
    //初始化进度条
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.tag=1000;
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.labelText = @"Downloading...";
    HUD.square = YES;
    [HUD show:YES];
    //初始化队列
    NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
    //下载地址
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://1.85.16.50:9001/sdzx/sdzxController/downWsByApp?zjh=%@&signature_code=%@",username,pwd]];
    //保存路径
    NSString *rootPath = [self dirDoc];
    _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.doc",subAjbsStr]];
    NSLog(@"++--++--%@",_filePath);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
    // 根据下载量设置进度条的百分比
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
        HUD.progress = precent;
    }];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        [HUD removeFromSuperview];
        SWTLoadFileViewController *loafFileVC = [[SWTLoadFileViewController alloc]init];
        loafFileVC.path = _filePath;
        [self.navigationController pushViewController:loafFileVC animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        [HUD removeFromSuperview];
    }];
    //开始下载
    [queue addOperation:op];

}


//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
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
