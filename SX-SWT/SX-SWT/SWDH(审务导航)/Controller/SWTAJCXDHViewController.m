//
//  SWTAJCXDHViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAJCXDHViewController.h"
#import "STAlertView.h"

@interface SWTAJCXDHViewController ()
@property (strong, nonatomic) IBOutlet UIButton *pastBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIButton *ajxzBtn;
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (nonatomic, assign) int index;
@end

@implementation SWTAJCXDHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.nextBtn setTitle:@"\uf2ee" forState:UIControlStateNormal];
    self.pastBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.pastBtn setTitle:@"\uf2ea" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 5;
    self.pastBtn.layer.cornerRadius = 5;
    self.ajxzBtn.layer.cornerRadius = 5;

    self.pastBtn.hidden = YES;
    self.index = 1;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)nextBtnClick:(UIButton *)sender {
//    if (self.index == 1) {
//        self.showImg.image = [UIImage imageNamed:@"图2"];
//        self.noteLabel.text = @"二、进入安检门，法警进行安检，出示相应的证件以及传票（比如：身份证，或者律师证），通过安检门来到立案大厅；";
//        self.index = 2;
//        self.pastBtn.hidden = NO;
//        self.ajxzBtn.hidden = NO;
//
//        return;
//    }
//    if (self.index == 2) {
//        self.showImg.image = [UIImage imageNamed:@"图3"];
//        self.noteLabel.text = @"三、到达立案大厅，在“查询咨询”窗口询问工作人员；";
//        self.index = 3;
//        self.ajxzBtn.hidden = YES;
//
//        self.pastBtn.hidden = NO;
//        return;
//    }
    if (self.index == 1) {
        self.showImg.image = [UIImage imageNamed:@"图4"];
        self.noteLabel.text = @"根据工作人员的指引到达“阅卷室”，出具相关身份证明，需要查询案号为：XX的案件卷宗，资料可以进行打印，但是资料原件不能带离阅卷室；";
        self.index = 2;

        self.pastBtn.hidden = NO;
        self.nextBtn.hidden = YES;
        return;
    }
    
}
- (IBAction)pastBtnClick:(id)sender {
    if (self.index == 2) {
        self.showImg.image = [UIImage imageNamed:@"图3"];
        self.noteLabel.text = @"到达立案大厅，在“查询咨询”窗口询问工作人员；";
        self.index = 1;
        self.pastBtn.hidden = YES;
        self.nextBtn.hidden = NO;

        return;
    }
//    if (self.index == 3) {
//        self.showImg.image = [UIImage imageNamed:@"图2"];
//        self.noteLabel.text = @"二、进入安检门，法警进行安检，出示相应的证件以及传票（比如：身份证，或者律师证），通过安检门来到立案大厅；";
//        self.index = 2;
//        self.ajxzBtn.hidden = NO;
//
//        self.pastBtn.hidden = NO;
//        
//        return;
//    }
//    if (self.index == 2) {
//        self.showImg.image = [UIImage imageNamed:@"大门"];
//        self.noteLabel.text = @"一、首先来到诉讼服务中心到达安检门；";
//        self.index = 1;
//        self.pastBtn.hidden = YES;
//        self.ajxzBtn.hidden = YES;
//
//        return;
//    }
    
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
