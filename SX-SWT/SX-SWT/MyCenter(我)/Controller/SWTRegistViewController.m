//
//  SWTRegistViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/3.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTRegistViewController.h"
#import "NIDropDown.h"
#import "SWTGjType.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTBase.h"
#import "SWTMyCenterViewController.h"
#import "SWTLogin.h"
#import "NSString+time.h"
#import "HMDatePickView.h"


@interface SWTRegistViewController ()<NIDropDownDelegate>
@property (nonatomic, strong) NIDropDown *dropDown;
@property (strong, nonatomic) IBOutlet UITextField *realNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;
@property (strong, nonatomic) IBOutlet UITextField *sjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *sfzhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *csrqTextField;
@property (strong, nonatomic) IBOutlet UIButton *mzBtn;
@property (strong, nonatomic) IBOutlet UIButton *xlBtn;
@property (nonatomic, strong) NSMutableArray *whcdArr;
@property (nonatomic, strong) NSMutableArray *whcdNameArr;
@property (nonatomic, strong) NSMutableArray *nationArr;
@property (nonatomic, strong) NSMutableArray *nationNameArr;
@property (nonatomic, copy) NSString *mzCodeStr;
@property (nonatomic, copy) NSString *xlCodeStr;
@property (strong, nonatomic) IBOutlet UIButton *sexBtn;

@end

@implementation SWTRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self loadWhcd];
    [self loadNation];
    // Do any additional setup after loading the view.
}
- (void)loadWhcd {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"bm_education"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.whcdArr = [SWTGjType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    for (SWTGjType *gjTypeModel in self.whcdArr) {
        [self.whcdNameArr addObject:gjTypeModel.DMMS];
    }
}
- (void)loadNation {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"bm_nation"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.nationArr = [SWTGjType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    for (SWTGjType *gjTypeModel in self.nationArr) {
        [self.nationNameArr addObject:gjTypeModel.DMMS];
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chooseMzBtn:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 280;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.nationNameArr :nil :@"up"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}
- (IBAction)chooseSexBtn:(id)sender {
    NSArray *arr = @[@"男",@"女",@"其他"];
    if(self.dropDown == nil) {
        CGFloat f = 120;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"up"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)chooseXlBtn:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 320;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.whcdNameArr :nil :@"up"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    
    SWTGjType *mzCodeModel = self.nationArr[self.dropDown.index];
    SWTGjType *xlCodeModel = self.whcdArr[self.dropDown.index];
    self.mzCodeStr = mzCodeModel.DM;
    self.xlCodeStr = xlCodeModel.DM;
    
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}




- (IBAction)chooseDate:(id)sender {
    /** 自定义日期选择器 */
    HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:self.view.frame];
    //距离当前日期的年份差（设置最大可选日期）
    datePickVC.maxYear = -1;
    //设置最小可选日期(年分差)
    datePickVC.minYear = 100;
    datePickVC.date = [NSDate date];
    //设置字体颜色
    datePickVC.fontColor = SWTRedColor;
    //日期回调
    datePickVC.completeBlock = ^(NSString *selectDate) {
        self.csrqTextField.text = selectDate;
    };
    //配置属性
    [datePickVC configuration];
    [self.view addSubview:datePickVC];
    
}


- (IBAction)registBtnClick:(id)sender {
    BOOL isTelRight = false;
    BOOL isSFZRight = false;
    if (self.sjhmTextField.text.length > 0) {
        isTelRight = [NSString valiMobile:self.sjhmTextField.text];
    }
    if (self.sfzhmTextField.text.length > 0) {
        isSFZRight = [NSString checkIdentityCardNo:self.sfzhmTextField.text];
    }
    if (self.userNameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"用户名不得为空"];
        return;
    } else if (self.passWordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不得为空"];
        return;
    } else if (self.sjhmTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不得为空"];
        return;
    } else if (self.sfzhmTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"身份证号码不得为空"];
        return;
    } else if (self.realNameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"真实姓名不得为空"];
        return;
    } else if (self.csrqTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"出生日期不得为空"];
        return;
    } else if ([self.mzBtn.titleLabel.text isEqualToString:@"请选择民族"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择民族"];
        return;
    } else if ([self.xlBtn.titleLabel.text isEqualToString:@"请选择学历"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择学历"];
        return;
    } else if ([self.sexBtn.titleLabel.text isEqualToString:@"请选择性别"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        return;
    } else if (isTelRight == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    } else if (isSFZRight == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的身份证号码"];
        return;
    } else {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"apploginname"] = self.userNameTextField.text;
        params[@"apppwd"] = self.passWordTextField.text;
        params[@"sjhm"] = self.sjhmTextField.text;
        params[@"sfzhm"] = self.sfzhmTextField.text;
        params[@"mzcode"] = self.mzCodeStr;
        params[@"xlcode"] = self.xlCodeStr;
        params[@"mz"] = self.mzBtn.titleLabel.text;
        params[@"xl"] = self.xlBtn.titleLabel.text;
        params[@"birthday"] = self.csrqTextField.text;
        params[@"sex"] = self.sexBtn.titleLabel.text;
        params[@"flag"] = @1;
        params[@"name"] = self.realNameTextField.text;
        [SWTHttpTool post:RegistUrl params:params success:^(id json) {
            SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
            if ([baseModel.flag isEqualToString:@"1"]) {
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                NSMutableDictionary *loginParams = [NSMutableDictionary dictionary];
                loginParams[@"appname"] = self.userNameTextField.text;
                loginParams[@"apppwd"] = self.passWordTextField.text;
                [SWTHttpTool post:LoginUrl params:loginParams success:^(id json) {
                    SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
                    if ([baseModel.flag isEqualToString:@"1"]) {
                        NSUserDefaults *UserDefaults=[NSUserDefaults standardUserDefaults];
                        SWTLogin *loginModel = [SWTLogin mj_objectWithKeyValues:json[@"userinfo"]];
                        [UserDefaults setObject:loginModel.id forKey:@"loginId"];
                        [UserDefaults setObject:self.userNameTextField.text forKey:@"username"];
                        [UserDefaults setObject:self.passWordTextField.text forKey:@"password"];
                        [UserDefaults setObject:loginModel.sfzhm forKey:@"sfzhm"];
                        [UserDefaults setObject:loginModel.apploginname forKey:@"apploginname"];
                        [UserDefaults setObject:self.realNameTextField.text forKey:@"name"];
                        [UserDefaults setObject:loginModel.birthday forKey:@"birthday"];
                        [UserDefaults setObject:self.sjhmTextField.text forKey:@"lxdh"];
                        [UserDefaults setObject:loginModel.sjhm forKey:@"sjhm"];
                        [UserDefaults setObject:loginModel.sex forKey:@"sex"];
                        [UserDefaults setObject:loginModel.mz forKey:@"mz"];
                        [UserDefaults setObject:loginModel.xl forKey:@"xl"];
                        [UserDefaults synchronize];
                        [self jumpToVC];
                    }
                } failure:^(NSError *error) {
                    
                }];
                
            }
            NSLog(@"%@",json);
        } failure:^(NSError *error) {
            
        }]; 
    }
 
}
- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SWTMyCenterViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
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

- (NSMutableArray *)whcdArr {
	if(_whcdArr == nil) {
		_whcdArr = [[NSMutableArray alloc] init];
	}
	return _whcdArr;
}

- (NSMutableArray *)whcdNameArr {
	if(_whcdNameArr == nil) {
		_whcdNameArr = [[NSMutableArray alloc] init];
	}
	return _whcdNameArr;
}

- (NSMutableArray *)nationArr {
	if(_nationArr == nil) {
		_nationArr = [[NSMutableArray alloc] init];
	}
	return _nationArr;
}

- (NSMutableArray *)nationNameArr {
	if(_nationNameArr == nil) {
		_nationNameArr = [[NSMutableArray alloc] init];
	}
	return _nationNameArr;
}

@end
