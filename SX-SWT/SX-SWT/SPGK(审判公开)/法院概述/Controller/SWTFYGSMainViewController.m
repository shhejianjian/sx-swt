//
//  SWTFYGSMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTFYGSMainViewController.h"
#import "SWTGSFirstViewController.h"
#import "SWTGSSecondViewController.h"
#import "SWTGSThirdViewController.h"
#import "SWTGSForthViewController.h"
#import "SWTLoadFothWebViewController.h"

@interface SWTFYGSMainViewController ()<FJSlidingControllerDataSource,FJSlidingControllerDelegate,SWTGSForthViewControllerDelegate>
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *controllers;

@end

@implementation SWTFYGSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasouce = self;
    self.delegate = self;
    SWTGSFirstViewController *v1 = [[SWTGSFirstViewController alloc]init];
    v1.parentController = self;
    SWTGSSecondViewController *v2 = [[SWTGSSecondViewController alloc]init];
    v2.parentController = self;
    SWTGSThirdViewController *v3 = [[SWTGSThirdViewController alloc]init];
    v3.parentController = self;
    SWTGSForthViewController *v4 = [[SWTGSForthViewController alloc]init];
    v4.delegate = self;
    v4.parentController = self;
    
    self.titles= @[@"法院简介",@"审判委员会",@"联系方式",@"参阅案例"];
    self.controllers = @[v1,v2,v3,v4];
    [self addChildViewController:v1];
    [self addChildViewController:v2];
    [self addChildViewController:v3];
    [self addChildViewController:v4];

    //self.title = self.titles[0];
    
    [self reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didSelectForth:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SWTLoadFothWebViewController *zxgfWebVC = [[SWTLoadFothWebViewController alloc]init];
    zxgfWebVC.index = indexPath.row;
    [self.navigationController pushViewController:zxgfWebVC animated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
