//
//  SWTTabViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/26.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTTabViewController.h"
#import "SWTMainViewController.h"
#import "SWTMyCenterViewController.h"

@interface SWTTabViewController ()

@end

@implementation SWTTabViewController
+ (void)initialize{
    UITabBar *bar = [UITabBar appearance];
    [bar setBackgroundColor:[UIColor clearColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SWTMainViewController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
    [self addVc:homeVC title:@"首页" Image:@"button_main" SelectedImage:nil];
    SWTMyCenterViewController *myCenterVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"myCenter"];
    [self addVc:myCenterVC title:@"个人中心" Image:@"button_myself" SelectedImage:nil];
    // Do any additional setup after loading the view.
}
- (void)addVc:(UIViewController *)childVC title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage;
{
    childVC.title = title;
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
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
