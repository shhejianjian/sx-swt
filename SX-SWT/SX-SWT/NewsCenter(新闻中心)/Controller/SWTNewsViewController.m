//
//  SWTNewsViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTNewsViewController.h"
#import "SWTNewsTableViewController.h"
#import "SWTDYNewsViewController.h"
#import "SWTSubNewsViewController.h"
#import "SWTMainNewsCell.h"
#import "SWTMainNews.h"
#import "SegmentViewController.h"
#import "SWTConst.h"
#import "UIBarButtonItem+Extension.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTNewsColum.h"
#import "SWTMainNewsCell.h"
#import "SVProgressHUD.h"
#import "SegmentView.h"
#import "BtnCollectionView.h"
#import "FileSave.h"
#import "ZLNavTabBarController.h"
#import "ZLCommonConst.h"

static NSString *ID=@"mainNewsCell";



@interface SWTNewsViewController () 

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *IDArr;




@end

@implementation SWTNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTitleArr];
}


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"新闻中心";
    self.navigationController.navigationBar.barTintColor = SWTRedColor;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:nil highImage:nil title:@"返回"];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getTitleArr {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"state"] = @0;
    [SWTHttpTool post:GetNewsColumListUrl params:params success:^(id json) {
        NSLog(@"%@",json);

        NSArray *arr = [SWTNewsColum mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        for (SWTNewsColum *newsColum in arr) {
            [self.titleArr addObject:newsColum.columnname];
            [self.IDArr addObject:newsColum.columncode];
        }
        [self initSegementVC];
    } failure:^(NSError *error) {
        
    }];

}

- (void)initSegementVC {
    
ZLNavTabBarController *navTabBarController = [[ZLNavTabBarController alloc] init];
    NSMutableArray *controlArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.titleArr.count; i ++) {
        SWTNewsTableViewController *newstableVC = [[SWTNewsTableViewController alloc]init];
        newstableVC.title = self.titleArr[i];
        newstableVC.MyIdStr = self.IDArr[i];
        NSLog(@"--%@",newstableVC.MyIdStr);
        [controlArray addObject:newstableVC];
    }
    navTabBarController.subViewControllers = controlArray;
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    navTabBarController.mainViewBounces = YES;
    navTabBarController.selectedToIndex = 3;
    navTabBarController.unchangedToIndex = 3;
    navTabBarController.showArrayButton = YES;
    [navTabBarController addParentController:self];
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

- (NSMutableArray *)titleArr {
	if(_titleArr == nil) {
		_titleArr = [[NSMutableArray alloc] init];
	}
	return _titleArr;
}


- (NSMutableArray *)IDArr {
	if(_IDArr == nil) {
		_IDArr = [[NSMutableArray alloc] init];
	}
	return _IDArr;
}

@end
