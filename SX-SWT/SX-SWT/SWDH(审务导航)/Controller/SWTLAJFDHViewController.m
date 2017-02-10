//
//  SWTLAJFDHViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTLAJFDHViewController.h"
#import "STAlertView.h"

@interface SWTLAJFDHViewController ()
@property (strong, nonatomic) IBOutlet UIButton *pastBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIButton *ajxzBtn;
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (nonatomic, assign) int index;
@end

@implementation SWTLAJFDHViewController

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
//到达立案大厅，询问工作人员，根据工作人员指引到达“立案登记”窗口；
//    根据工作人员的指引来到“立案登记”窗口，立案工作人员审核材料，材料无误之后，确认立案；
    if (self.index == 1) {
        self.showImg.image = [UIImage imageNamed:@"图4"];
        self.noteLabel.text = @"根据工作人员的指引来到“立案登记”窗口，立案工作人员审核材料，材料无误之后，确认立案；";
        self.index = 2;
        self.pastBtn.hidden = NO;
        return;
    }
    if (self.index == 2) {
        self.showImg.image = [UIImage imageNamed:@"图5"];
        self.noteLabel.text = @"根据案件金额，依据《诉讼费用交纳办法》，登记立案后通知当事人交纳诉讼费；";
        self.nextBtn.hidden = YES;
        self.index = 3;
        self.pastBtn.hidden = NO;
        return;
    }
}
- (IBAction)pastBtnClick:(id)sender {
    if (self.index == 3) {
        self.showImg.image = [UIImage imageNamed:@"图4"];
        self.noteLabel.text = @"根据工作人员的指引来到“立案登记”窗口，立案工作人员审核材料，材料无误之后，确认立案；";
        self.index = 2;
        self.pastBtn.hidden = NO;
        self.nextBtn.hidden = NO;
        return;
    }
    if (self.index == 2) {
        self.showImg.image = [UIImage imageNamed:@"图3"];
        self.noteLabel.text = @"到达立案大厅，询问工作人员，根据工作人员指引到达“立案登记”窗口；";
        self.index = 1;
        self.pastBtn.hidden = YES;
        self.nextBtn.hidden = NO;
        return;
    }
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
