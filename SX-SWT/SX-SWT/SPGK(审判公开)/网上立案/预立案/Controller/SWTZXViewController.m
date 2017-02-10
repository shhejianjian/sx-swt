//
//  SWTZXViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTZXViewController.h"
#import "SWTAddPartyViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "NIDropDown.h"
#import "SWTGjType.h"
#import "SWTYlaInfo.h"
#import "SWTZxyjType.h"
#import "SVProgressHUD.h"
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface SWTZXViewController ()<NIDropDownDelegate,UITextViewDelegate>

@property (nonatomic, strong) NIDropDown *dropDown;

@property (nonatomic, strong) NSMutableArray *zxyjArr;
@property (nonatomic, strong) NSMutableArray *zxyjNameArr;

@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstrainst;

@property (strong, nonatomic) IBOutlet UITextField *sqrmcTextField;
@property (strong, nonatomic) IBOutlet UITextField *lxdhTextField;
@property (strong, nonatomic) IBOutlet UITextField *yjjgTextField;

@property (strong, nonatomic) IBOutlet UITextField *sjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *zjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *yjwhTextField;
@property (strong, nonatomic) IBOutlet UITextField *bdeTextField;
@property (strong, nonatomic) IBOutlet UITextView *ssqqTextView;
@property (strong, nonatomic) IBOutlet UITextView *sslyTextView;
@property (strong, nonatomic) IBOutlet UILabel *ssqqPreViewLabel;
@property (strong, nonatomic) IBOutlet UILabel *sslyPreViewLabel;

@property (strong, nonatomic) IBOutlet UIButton *ydsrGxBtn;
@property (strong, nonatomic) IBOutlet UIButton *zxyjBtn;


@property (nonatomic, copy) NSString *zxyjDmStr;


@end

@implementation SWTZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.ssqqTextView.delegate = self;
    self.sslyTextView.delegate = self;
    if (ScreenHeight == 568) {
        self.bottomViewConstrainst.constant = 170;
    } else if (ScreenHeight == 667) {
        self.bottomViewConstrainst.constant = 120;
    } else if (ScreenHeight == 736) {
        self.bottomViewConstrainst.constant = 90;
    }
    [self loadZXyjType];
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
    if (self.ajlbModel) {
        self.sqrmcTextField.text = self.ajlbModel.sqrmc;
        self.lxdhTextField.text = self.ajlbModel.sqrdh;
        self.sjhmTextField.text = self.ajlbModel.sqryddh;
        self.zjhmTextField.text = self.ajlbModel.sqrzjhm;
        self.yjjgTextField.text = self.ajlbModel.yjjg;
        self.yjwhTextField.text = self.ajlbModel.yjwh;
        [self.ydsrGxBtn setTitle:self.ajlbModel.ydsrgxmc forState:UIControlStateNormal];
        [self.zxyjBtn setTitle:self.ajlbModel.zxyj forState:UIControlStateNormal];
        self.bdeTextField.text = self.ajlbModel.ajbd;
        self.ssqqTextView.text = self.ajlbModel.ssqq;
        self.sslyTextView.text = self.ajlbModel.ssly;
        self.ssqqPreViewLabel.hidden = YES;
        self.sslyPreViewLabel.hidden = YES;
    }
}


- (void)loadZXyjType {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"t_bmxt_bm_zxyj"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"===%@===",JsonObject);
    self.zxyjArr = [SWTZxyjType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    for (SWTZxyjType *zxyjTypeModel in self.zxyjArr) {
        [self.zxyjNameArr addObject:zxyjTypeModel.dmms];
    }
}
- (IBAction)ydsrgxBtnClick:(id)sender {
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
    SWTZxyjType *zxyjTypeModel = self.zxyjArr[self.dropDown.index];
    self.zxyjDmStr = zxyjTypeModel.dm;
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}

- (IBAction)zxyjBtnClick:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 220;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.zxyjNameArr :nil :@"down"];
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
    } else {
        params[@"fydm"] = self.lafyDMStr;
        params[@"fymc"] = self.lafymcStr;
        
    }
    params[@"ajlb"] = @"8";
    params[@"ajlbmc"] = @"执行";
    params[@"ajfl"] = @"801";
    params[@"ajflmc"] = @"执行";
    params[@"spjb"] = @"4";
    params[@"sqrdh"] = self.lxdhTextField.text;
    params[@"sqryddh"] = self.sjhmTextField.text;
    params[@"sqrzjhm"] = self.zjhmTextField.text;
    params[@"sqr_name"] = self.sqrmcTextField.text;
    params[@"ydsrgxmc"] = self.ydsrGxBtn.titleLabel.text;
    if ([self.ydsrGxBtn.titleLabel.text isEqualToString:@"本人"]) {
        params[@"ydsrgx"] = @"1";
    } else if ([self.ydsrGxBtn.titleLabel.text isEqualToString:@"代理人"]) {
        params[@"ydsrgx"] = @"2";
    } else if ([self.ydsrGxBtn.titleLabel.text isEqualToString:@"当事人律师"]) {
        params[@"ydsrgx"] = @"3";
    }
    params[@"ssqq"] = self.ssqqTextView.text;
    params[@"ssly"] = self.sslyTextView.text;
    params[@"ajbd"] = self.bdeTextField.text;
    params[@"yjjg"] = self.yjjgTextField.text;
    params[@"yjwh"] = self.yjwhTextField.text;
    params[@"zxyj"] = self.zxyjBtn.titleLabel.text;
    params[@"zxyjdm"] = self.zxyjDmStr;
//    if ([self.zxyjBtn.titleLabel.text isEqualToString:@"本人"]) {
//        params[@"zxyjdm"] = @"1";
//    } else if ([self.zxyjBtn.titleLabel.text isEqualToString:@"代理人"]) {
//        params[@"zxyjdm"] = @"2";
//    } else if ([self.zxyjBtn.titleLabel.text isEqualToString:@"当事人律师"]) {
//        params[@"zxyjdm"] = @"3";
//    }
    [SWTHttpTool post:SaveOrChangeYlaInfoUrl params:params success:^(id json) {
        SWTYlaInfo *ylaInfo = [SWTYlaInfo mj_objectWithKeyValues:json];
        NSLog(@"==%@",params);
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
- (IBAction)loadLoginInfoBtnClick:(id)sender {
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

- (NSMutableArray *)zxyjArr {
	if(_zxyjArr == nil) {
		_zxyjArr = [[NSMutableArray alloc] init];
	}
	return _zxyjArr;
}

- (NSMutableArray *)zxyjNameArr {
	if(_zxyjNameArr == nil) {
		_zxyjNameArr = [[NSMutableArray alloc] init];
	}
	return _zxyjNameArr;
}

@end
