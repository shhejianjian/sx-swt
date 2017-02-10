//
//  SWTGSFirstViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTGSFirstViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTBase.h"
@interface SWTGSFirstViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation SWTGSFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWebView];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadWebView {
    NSString *fyJJIDStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtID"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = fyJJIDStr;
    [SWTHttpTool get:GetFyxxUrl params:params success:^(id json) {
        NSLog(@"%@",json);
        SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
        NSString *str =[NSString stringWithFormat:@"<html><body>%@</body></html>",baseModel.content];
        [self.myWebView loadHTMLString:str baseURL:nil];
    } failure:^(NSError *error) {
        
    }];
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
