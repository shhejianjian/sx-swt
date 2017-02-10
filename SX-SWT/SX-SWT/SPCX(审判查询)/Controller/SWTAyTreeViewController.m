//
//  SWTAyTreeViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/8.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAyTreeViewController.h"
#import "BDDynamicTreeNode.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTAyInfo.h"

#define MainScreenWidth             [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight             [[UIScreen mainScreen]bounds].size.height


@interface SWTAyTreeViewController ()
{
    BDDynamicTree *_dynamicTree1;
    
}
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) NSMutableArray *AYArr;

@end


NSString *msAyStr;
NSString *msAyDm;

@implementation SWTAyTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self loadAY];

    _dynamicTree1 = [[BDDynamicTree alloc] initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight-64) nodes:self.AYArr];
    _dynamicTree1.delegate = self;
    
    [self.view addSubview:_dynamicTree1];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadAY {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"myAy"ofType:@"json"];
    
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    
    //格式化成json数据
    //id jsonObject = [NSJSONSerialization JSONObjectWithData:jdata options:Nil Optionserror:&error];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    NSArray *arr = [SWTAyInfo mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    BDDynamicTreeNode *root = [[BDDynamicTreeNode alloc] init];
    root.originX = 20.f;
    root.isDepartment = YES;
    root.fatherNodeId = nil;
    root.nodeId = @"node_1000";
    root.name = @"请选择案由";
    root.data = @{@"dmms":@"请选择案由"};
    [self.AYArr addObject:root];
    
    BDDynamicTreeNode *root1 = [[BDDynamicTreeNode alloc] init];
    root1.isDepartment = YES;
    root1.fatherNodeId = @"node_1000";
    root1.nodeId = @"896";
    root1.name = @"民事案由";
    root1.data = @{@"dmms":@"民事案由"};
    [self.AYArr addObject:root1];
    
    BDDynamicTreeNode *root2 = [[BDDynamicTreeNode alloc] init];
    root2.isDepartment = YES;
    root2.fatherNodeId = @"node_1000";
    root2.nodeId = @"200000";
    root2.name = @"民事新案由";
    root2.data = @{@"dmms":@"民事新案由"};
    [self.AYArr addObject:root2];

    BDDynamicTreeNode *root3 = [[BDDynamicTreeNode alloc] init];
    root3.isDepartment = YES;
    root3.fatherNodeId = @"node_1000";
    root3.nodeId = @"811";
    root3.name = @"行政案由";
    root3.data = @{@"dmms":@"行政案由"};
    [self.AYArr addObject:root3];
    
    BDDynamicTreeNode *root4 = [[BDDynamicTreeNode alloc] init];
    root4.isDepartment = YES;
    root4.fatherNodeId = @"node_1000";
    root4.nodeId = @"3001";
    root4.name = @"执行案由";
    root4.data = @{@"dmms":@"执行案由"};
    [self.AYArr addObject:root4];
    
    for (SWTAyInfo *ay in arr) {
        BDDynamicTreeNode *caiwu = [[BDDynamicTreeNode alloc] init];
        if ([ay.leaf isEqualToString:@"1"]) {
            caiwu.isDepartment = NO;
        } else {
            caiwu.isDepartment = YES;
        }
        caiwu.fatherNodeId = ay.sjdm;
        caiwu.nodeId = ay.dm;
        caiwu.name = ay.dmms;
        caiwu.data = @{@"name":ay.dmms};
        [self.AYArr addObject:caiwu];
    }
}




- (void)dynamicTree:(BDDynamicTree *)dynamicTree didSelectedRowWithNode:(BDDynamicTreeNode *)node
{
    if (!node.isDepartment) {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"确认选择此案由吗？" message:node.name preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            msAyStr = node.name;
            msAyDm = node.nodeId;
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
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

- (NSMutableArray *)AYArr {
	if(_AYArr == nil) {
		_AYArr = [[NSMutableArray alloc] init];
	}
	return _AYArr;
}

@end
