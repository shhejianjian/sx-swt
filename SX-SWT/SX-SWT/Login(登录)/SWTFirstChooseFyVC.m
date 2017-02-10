//
//  SWTFirstChooseFyVC.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/26.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTFirstChooseFyVC.h"
#import "SWTMainViewController.h"

@interface SWTFirstChooseFyVC ()

@end

@implementation SWTFirstChooseFyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    NSString *checkCourtName = [[NSUserDefaults standardUserDefaults]objectForKey:@"courtName"];
    if (checkCourtName.length > 0) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
//        [[NSUserDefaults standardUserDefaults]setObject:@"榆林法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:NO];
    }
}


- (IBAction)yulinBtnCLick:(id)sender {
    NSString *message = @"您是否要进入榆林法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"榆林法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)yananBtnClick:(id)sender {
    NSString *message = @"您是否要进入延安法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"延安法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)tongchuangBtnClick:(id)sender {
    NSString *message = @"您是否要进入铜川法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"铜川法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)xianYangBtnClick:(id)sender {
    NSString *message = @"您是否要进入咸阳法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"咸阳法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)weinanBtnClick:(id)sender {
    NSString *message = @"您是否要进入渭南法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"渭南法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)ankangBtnClick:(id)sender {
    NSString *message = @"您是否要进入安康法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"安康法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)shangluoBtnClick:(id)sender {
    NSString *message = @"您是否要进入商洛法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"商洛法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)xianBtnClick:(id)sender {
    NSString *message = @"您是否要进入西安法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"西安法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)hanzhongBtnClick:(id)sender {
    NSString *message = @"您是否要进入汉中法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"汉中法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)baojiBtnClick:(id)sender {
    NSString *message = @"您是否要进入宝鸡法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"宝鸡法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)shanxiBtnClick:(id)sender {
    
    NSString *message = @"您是否要进入陕西法院？";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
        [[NSUserDefaults standardUserDefaults]setObject:@"陕西法院" forKey:@"courtName"];
        [self.navigationController pushViewController:nav animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
