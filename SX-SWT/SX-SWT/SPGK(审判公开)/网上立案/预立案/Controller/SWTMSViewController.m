//
//  SWTMSViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTMSViewController.h"
#import "SWTAddPartyViewController.h"
#import "NIDropDown.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTYlaInfo.h"
#import "SVProgressHUD.h"
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface SWTMSViewController () <NIDropDownDelegate,UITextViewDelegate>

@property (nonatomic, strong) NIDropDown *dropDown;

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewContrast;

@property (strong, nonatomic) IBOutlet UITextField *sqrNametextfield;
@property (strong, nonatomic) IBOutlet UITextField *lxdhtextfield;
@property (strong, nonatomic) IBOutlet UITextField *telNumbertextfield;
@property (strong, nonatomic) IBOutlet UITextField *zjNumtextfield;
@property (strong, nonatomic) IBOutlet UIButton *ydsrgxBtn;
@property (strong, nonatomic) IBOutlet UITextField *moneyNumtextfield;
@property (strong, nonatomic) IBOutlet UITextView *ssqqTextView;
@property (strong, nonatomic) IBOutlet UITextView *sslyTextView;

@property (strong, nonatomic) IBOutlet UILabel *ssqqPreViewLabel;
@property (strong, nonatomic) IBOutlet UILabel *sslyPreViewLabel;

@end



@implementation SWTMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.ssqqTextView.delegate = self;
    self.sslyTextView.delegate = self;
    if (ScreenHeight == 568) {
        self.bottomViewContrast.constant = 90;
    } else if (ScreenHeight == 667) {
        self.bottomViewContrast.constant = 40;
    } else if (ScreenHeight == 736) {
        self.bottomViewContrast.constant = 10;
    }
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
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
- (void)setUpUI {
    if (self.ajlbModel) {
        self.sqrNametextfield.text = self.ajlbModel.sqrmc;
        self.lxdhtextfield.text = self.ajlbModel.sqrdh;
        self.telNumbertextfield.text = self.ajlbModel.sqryddh;
        self.zjNumtextfield.text = self.ajlbModel.sqrzjhm;
        [self.ydsrgxBtn setTitle:self.ajlbModel.ydsrgxmc forState:UIControlStateNormal];
        self.moneyNumtextfield.text = self.ajlbModel.ajbd;
        self.ssqqTextView.text = self.ajlbModel.ssqq;
        self.sslyTextView.text = self.ajlbModel.ssly;
        self.ssqqPreViewLabel.hidden = YES;
        self.sslyPreViewLabel.hidden = YES;
    }
}

- (IBAction)DSRGXBtnClick:(id)sender {
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
        params[@"ajlb"] = @"2";
        params[@"ajlbmc"] = @"民事";
    } else {
        params[@"fydm"] = self.lafyDMStr;
        params[@"fymc"] = self.lafymcStr;
        params[@"ajlb"] = @"2";
        params[@"ajlbmc"] = @"民事";
    }
    params[@"ajfl"] = @"201";
    params[@"ajflmc"] = @"一审";
    params[@"spjb"] = @"1";
    params[@"sqrdh"] = self.lxdhtextfield.text;
    params[@"sqryddh"] = self.telNumbertextfield.text;
    params[@"sqrzjhm"] = self.zjNumtextfield.text;
    params[@"sqr_name"] = self.sqrNametextfield.text;
    params[@"ydsrgxmc"] = self.ydsrgxBtn.titleLabel.text;
    if ([self.ydsrgxBtn.titleLabel.text isEqualToString:@"本人"]) {
        params[@"ydsrgx"] = @"1";
    } else if ([self.ydsrgxBtn.titleLabel.text isEqualToString:@"代理人"]) {
        params[@"ydsrgx"] = @"2";
    } else if ([self.ydsrgxBtn.titleLabel.text isEqualToString:@"当事人律师"]) {
        params[@"ydsrgx"] = @"3";
    }
    params[@"ssqq"] = self.ssqqTextView.text;
    params[@"ssly"] = self.sslyTextView.text;
    params[@"ajbd"] = self.moneyNumtextfield.text;
    
    [SWTHttpTool post:SaveOrChangeYlaInfoUrl params:params success:^(id json) {
        NSLog(@"----%@",params);
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
        NSLog(@"失败：%@--%@",error,params);

    }];
    
    
    
}
- (IBAction)loadLoginInfoClick:(id)sender {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *lxdh = [userDefault objectForKey:@"lxdh"];
    NSString *sjhm = [userDefault objectForKey:@"sjhm"];
    NSString *zjhm = [userDefault objectForKey:@"sfzhm"];
    
    if (name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"在我的页面进行登录才可加载自身信息"];
    } else {
        self.sqrNametextfield.text = name;
        self.lxdhtextfield.text = lxdh;
        self.telNumbertextfield.text = sjhm;
        self.zjNumtextfield.text = zjhm;
    }
    
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
