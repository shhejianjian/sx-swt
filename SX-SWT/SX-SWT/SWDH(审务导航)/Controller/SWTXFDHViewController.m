//
//  SWTXFDHViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXFDHViewController.h"
#import "STAlertView.h"

@interface SWTXFDHViewController ()
@property (strong, nonatomic) IBOutlet UIButton *pastBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (nonatomic, assign) int index;
@property (strong, nonatomic) IBOutlet UIButton *ajxzBtn;

@end

@implementation SWTXFDHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.nextBtn setTitle:@"\uf2ee" forState:UIControlStateNormal];
    self.pastBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.pastBtn setTitle:@"\uf2ea" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 5;
    self.pastBtn.layer.cornerRadius = 5;
    self.pastBtn.hidden = YES;
    self.index = 1;
}
- (IBAction)nextBtnClick:(UIButton *)sender {
    if (self.index == 1) {
        self.showImg.image = [UIImage imageNamed:@"图4"];
        self.noteLabel.text = @"到达立案大厅，在“导诉台”询问工作人员，根据工作人员指引到达“信访接待”窗口；";
        self.index = 2;
        self.pastBtn.hidden = NO;
        return;
    }
    
    if (self.index == 2) {
        self.showImg.image = [UIImage imageNamed:@"图5"];
        self.noteLabel.text = @"到达“信访接待”窗口，工作人员会对信访人信息进行登记，填写来访（或者申诉）基本信息，根据信访人的情况，安排相关业务庭的法官进行判后答疑；或者信访办部门领导进行约谈，或者通过远程视频接访系统进行约谈；";
        sender.hidden = YES;
        self.index = 3;
        self.pastBtn.hidden = NO;
        return;
    }
}
- (IBAction)pastBtnClick:(id)sender {

    if (self.index == 3) {
        self.showImg.image = [UIImage imageNamed:@"图4"];
        self.noteLabel.text = @"到达立案大厅，在“导诉台”询问工作人员，根据工作人员指引到达“信访接待”窗口；";
        self.index = 2;
        self.pastBtn.hidden = NO;
        self.nextBtn.hidden = NO;
        return;
    }
    if (self.index == 2) {
        self.showImg.image = [UIImage imageNamed:@"图3"];
        self.noteLabel.text = @"到达立案大厅，在“导诉台”询问工作人员，根据工作人员指引到达“信访接待”窗口；";
        self.index = 1;
        self.pastBtn.hidden = YES;
        self.nextBtn.hidden = NO;
        return;
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

@end
