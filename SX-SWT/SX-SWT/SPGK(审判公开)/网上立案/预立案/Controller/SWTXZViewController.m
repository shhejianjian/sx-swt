//
//  SWTXZViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXZViewController.h"
#import "SWTAddPartyViewController.h"
#import "NIDropDown.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTYlaInfo.h"
#import "SVProgressHUD.h"
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface SWTXZViewController ()<NIDropDownDelegate,UITextViewDelegate>

@property (nonatomic, strong) NIDropDown *dropDown;

@property (strong, nonatomic) IBOutlet UIButton *backbtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstrainst;

@property (strong, nonatomic) IBOutlet UITextField *sqrmcTextField;
@property (strong, nonatomic) IBOutlet UITextField *lxdhTextField;
@property (strong, nonatomic) IBOutlet UITextField *sjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *zjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *pcjeTextField;
@property (strong, nonatomic) IBOutlet UITextView *ssqqTextView;
@property (strong, nonatomic) IBOutlet UITextView *sslyTextView;
@property (strong, nonatomic) IBOutlet UILabel *ssqqPreViewLabel;
@property (strong, nonatomic) IBOutlet UILabel *sslyPreViewLabel;

@property (strong, nonatomic) IBOutlet UIButton *ydsrGXBtn;
@property (strong, nonatomic) IBOutlet UIButton *xzpcfsBtn;


@end


@implementation SWTXZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backbtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backbtn setTitle:@"返回" forState:UIControlStateNormal];
    self.ssqqTextView.delegate = self;
    self.sslyTextView.delegate = self;
    if (ScreenHeight == 568) {
        self.bottomViewConstrainst.constant = 130;
    } else if (ScreenHeight == 667) {
        self.bottomViewConstrainst.constant = 80;
    } else if (ScreenHeight == 736) {
        self.bottomViewConstrainst.constant = 50;
    }
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
    if (self.ajlbModel) {
        self.sqrmcTextField.text = self.ajlbModel.sqrmc;
        self.lxdhTextField.text = self.ajlbModel.sqrdh;
        self.sjhmTextField.text = self.ajlbModel.sqryddh;
        self.zjhmTextField.text = self.ajlbModel.sqrzjhm;
        [self.ydsrGXBtn setTitle:self.ajlbModel.ydsrgxmc forState:UIControlStateNormal];
        [self.xzpcfsBtn setTitle:self.ajlbModel.tqxzpcfs forState:UIControlStateNormal];
        self.pcjeTextField.text = self.ajlbModel.sqxzpcje;
        self.ssqqTextView.text = self.ajlbModel.ssqq;
        self.sslyTextView.text = self.ajlbModel.ssly;
        self.ssqqPreViewLabel.hidden = YES;
        self.sslyPreViewLabel.hidden = YES;
    }
}


- (IBAction)ydsrGXBtnClick:(id)sender {
    NSArray *arr = @[@"本人",@"代理人",@"当事人律师"];
    if(self.dropDown == nil) {
        CGFloat f = 120;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}


- (IBAction)xzpcfsBtnClick:(id)sender {
    NSArray *arr = @[@"单独",@"附带",@"行政诉讼"];
    if(self.dropDown == nil) {
        CGFloat f = 120;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)jumpToNext:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    params[@"loginname"] = [userDefault objectForKey:@"apploginname"];

    params[@"flag"] = @1;
    if (self.ajlbModel) {
        params[@"ajbs"] = self.ajlbModel.ajbs;
        params[@"fydm"] = self.ajlbModel.fydm;
        params[@"fymc"] = self.ajlbModel.fymc;
//        params[@"ajlb"] = self.ajlbModel.lalx;
    } else {
        params[@"fydm"] = self.lafyDMStr;
        params[@"fymc"] = self.lafymcStr;
        
    }
    params[@"ajlb"] = @"6";
    params[@"ajlbmc"] = @"行政";
    params[@"ajfl"] = @"601";
    params[@"ajflmc"] = @"一审";
    params[@"spjb"] = @"1";
    params[@"sqrdh"] = self.lxdhTextField.text;
    params[@"sqryddh"] = self.sjhmTextField.text;
    params[@"sqrzjhm"] = self.zjhmTextField.text;
    params[@"sqr_name"] = self.sqrmcTextField.text;
    params[@"ydsrgxmc"] = self.ydsrGXBtn.titleLabel.text;
    if ([self.ydsrGXBtn.titleLabel.text isEqualToString:@"本人"]) {
        params[@"ydsrgx"] = @"1";
    } else if ([self.ydsrGXBtn.titleLabel.text isEqualToString:@"代理人"]) {
        params[@"ydsrgx"] = @"2";
    } else if ([self.ydsrGXBtn.titleLabel.text isEqualToString:@"当事人律师"]) {
        params[@"ydsrgx"] = @"3";
    }
    params[@"ssqq"] = self.ssqqTextView.text;
    params[@"ssly"] = self.sslyTextView.text;
    params[@"sqxzpcje"] = self.pcjeTextField.text;
    params[@"tqxzpcfs"] = self.xzpcfsBtn.titleLabel.text;
    if ([self.xzpcfsBtn.titleLabel.text isEqualToString:@"本人"]) {
        params[@"tqxzpcfsdm"] = @"1";
    } else if ([self.xzpcfsBtn.titleLabel.text isEqualToString:@"代理人"]) {
        params[@"tqxzpcfsdm"] = @"2";
    } else if ([self.xzpcfsBtn.titleLabel.text isEqualToString:@"当事人律师"]) {
        params[@"tqxzpcfsdm"] = @"3";
    }
    [SWTHttpTool post:SaveOrChangeYlaInfoUrl params:params success:^(id json) {
        SWTYlaInfo *ylaInfo = [SWTYlaInfo mj_objectWithKeyValues:json];
        NSLog(@"==%@",ylaInfo.ajbs);
        SWTAddPartyViewController *addPartyVC = [[SWTAddPartyViewController alloc]init];
        if (self.ajlbModel) {
            addPartyVC.ylaInfoIdStr = self.ajlbModel.ajbs;
        } else {
            addPartyVC.ylaInfoIdStr = ylaInfo.ajbs;
        }
        addPartyVC.checkStatusStr = @"修改或新增";

        [self.navigationController pushViewController:addPartyVC animated:YES];
        NSLog(@"成功：%@",json);

    } failure:^(NSError *error) {
        NSLog(@"失败：%@",error);

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loadLoginClick:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *lxdh = [userDefault objectForKey:@"lxdh"];
    NSString *sjhm = [userDefault objectForKey:@"sjhm"];
    NSString *zjhm = [userDefault objectForKey:@"sfzhm"];
    
    if (name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"在我的页面进行登录才可加载自身信息"];
    } else {
        self.sqrmcTextField.text = name;
        self.lxdhTextField.text = lxdh;
        self.sjhmTextField.text = sjhm;
        self.zjhmTextField.text = zjhm;
    }

}
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.ssqqTextView.text.length != 0) {
        self.ssqqPreViewLabel.hidden = YES;
    }else{
        self.ssqqPreViewLabel.hidden = NO;
    }
    if (self.sslyTextView.text.length != 0) {
        self.sslyPreViewLabel.hidden = YES;
    }else{
        self.sslyPreViewLabel.hidden = NO;
    }
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
