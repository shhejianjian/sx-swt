//
//  SWTAddPlaintiffViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/26.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAddPlaintiffViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "NIDropDown.h"
#import "SWTGjType.h"
#import "HMDatePickView.h"

#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface SWTAddPlaintiffViewController ()<NIDropDownDelegate>
@property (nonatomic, strong) NIDropDown *dropDown;
@property (nonatomic, strong) NSMutableArray *GjArr;
@property (nonatomic, strong) NSMutableArray *GjNameArr;
@property (nonatomic, strong) NSMutableArray *whcdArr;
@property (nonatomic, strong) NSMutableArray *whcdNameArr;
@property (nonatomic, strong) NSMutableArray *nationArr;
@property (nonatomic, strong) NSMutableArray *nationNameArr;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewConstract;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *chooseDateBtn;

@property (strong, nonatomic) IBOutlet UIButton *ssdwBtnClick;
@property (strong, nonatomic) IBOutlet UITextField *dsrInfoTextField;
@property (strong, nonatomic) IBOutlet UIButton *gjBtn;
@property (strong, nonatomic) IBOutlet UIButton *jmsfzBtn;
@property (strong, nonatomic) IBOutlet UIButton *sexBtn;
@property (strong, nonatomic) IBOutlet UITextField *zjNumTextField;
@property (strong, nonatomic) IBOutlet UITextField *birthTextField;
@property (strong, nonatomic) IBOutlet UITextField *hujiAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *juzhuAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *telNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *yzBmTextField;
@property (strong, nonatomic) IBOutlet UIButton *chooseEducation;
@property (strong, nonatomic) IBOutlet UIButton *chooseNation;
@property (strong, nonatomic) IBOutlet UIButton *chooseJob;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation SWTAddPlaintiffViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    if (ScreenHeight == 568) {
        self.viewConstract.constant = 120;
    } else if (ScreenHeight == 667) {
        self.viewConstract.constant = 80;
    } else if (ScreenHeight == 736) {
        self.viewConstract.constant = 40;
    }
    [self loadGjType];
    [self loadWhcd];
    [self loadNation];
    [self setUpUI];
    
    // Do aseny additional setup after loading the view from its nib.
}

- (void)setUpUI {
    if (self.myDsrInfoModel) {
        [self.ssdwBtnClick setTitle:self.myDsrInfoModel.ssdwmc forState:UIControlStateNormal];
        self.dsrInfoTextField.text = self.myDsrInfoModel.mc;
        [self.gjBtn setTitle:self.myDsrInfoModel.gjmc forState:UIControlStateNormal];
        [self.sexBtn setTitle:self.myDsrInfoModel.xbmc forState:UIControlStateNormal];
        self.zjNumTextField.text = self.myDsrInfoModel.sfzjhm;
        self.birthTextField.text = [self.myDsrInfoModel.csrq substringToIndex:10];
        self.hujiAddressTextField.text = self.myDsrInfoModel.dwmc;
        self.juzhuAddressTextField.text = self.myDsrInfoModel.jtdz;
        self.telNumberTextField.text = self.myDsrInfoModel.dhhm;
        self.yzBmTextField.text = self.myDsrInfoModel.ybbh;
        [self.chooseEducation setTitle:self.myDsrInfoModel.whcdmc forState:UIControlStateNormal];
        [self.chooseNation setTitle:self.myDsrInfoModel.mzmc forState:UIControlStateNormal];
//        [self.chooseJob setTitle:self.myDsrInfoModel.zy forState:UIControlStateNormal];
    } else if (self.checkStatusInfoModel) {
        [self.ssdwBtnClick setTitle:self.checkStatusInfoModel.ssdwmc forState:UIControlStateNormal];
        [self.ssdwBtnClick setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.ssdwBtnClick.userInteractionEnabled = NO;
        self.dsrInfoTextField.text = self.checkStatusInfoModel.mc;
        self.dsrInfoTextField.userInteractionEnabled = NO;
        self.dsrInfoTextField.placeholder = @"";
        
        [self.gjBtn setTitle:self.checkStatusInfoModel.gjmc forState:UIControlStateNormal];
        [self.gjBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.gjBtn.userInteractionEnabled = NO;

        [self.sexBtn setTitle:self.checkStatusInfoModel.xbmc forState:UIControlStateNormal];
        [self.sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.sexBtn.userInteractionEnabled = NO;

        self.zjNumTextField.text = self.checkStatusInfoModel.sfzjhm;
        self.zjNumTextField.userInteractionEnabled = NO;
        self.zjNumTextField.placeholder = @"";

        self.birthTextField.text = [self.checkStatusInfoModel.csrq substringToIndex:10];
        self.birthTextField.userInteractionEnabled = NO;
        self.birthTextField.placeholder = @"";

        self.hujiAddressTextField.text = self.checkStatusInfoModel.jtdz;
        self.hujiAddressTextField.userInteractionEnabled = NO;
        self.hujiAddressTextField.placeholder = @"";

        self.juzhuAddressTextField.text = self.checkStatusInfoModel.jtdz;
        self.juzhuAddressTextField.userInteractionEnabled = NO;
        self.juzhuAddressTextField.placeholder = @"";

        self.telNumberTextField.text = self.checkStatusInfoModel.dhhm;
        self.telNumberTextField.userInteractionEnabled = NO;
        self.telNumberTextField.placeholder = @"";

        self.yzBmTextField.text = self.checkStatusInfoModel.ybbh;
        self.yzBmTextField.userInteractionEnabled = NO;
        self.yzBmTextField.placeholder = @"";

        [self.chooseEducation setTitle:self.checkStatusInfoModel.whcdmc forState:UIControlStateNormal];
        [self.chooseEducation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.chooseEducation.userInteractionEnabled = NO;

        [self.chooseNation setTitle:self.checkStatusInfoModel.mzmc forState:UIControlStateNormal];
        [self.chooseNation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.chooseNation.userInteractionEnabled = NO;

//        [self.chooseJob setTitle:self.checkStatusInfoModel.zy forState:UIControlStateNormal];
        [self.chooseJob setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.chooseJob.userInteractionEnabled = NO;

        self.saveBtn.hidden = YES;
        self.chooseDateBtn.hidden = YES;
    }
}

- (void)loadGjType {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"t_bmxt_bm_gj"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"===%@===",JsonObject);
    self.GjArr = [SWTGjType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    for (SWTGjType *gjTypeModel in self.GjArr) {
        [self.GjNameArr addObject:gjTypeModel.DMMS];
    }
}



- (void)loadWhcd {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"bm_education"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"===%@===",JsonObject);
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
    NSLog(@"===%@===",JsonObject);
    self.nationArr = [SWTGjType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    for (SWTGjType *gjTypeModel in self.nationArr) {
        [self.nationNameArr addObject:gjTypeModel.DMMS];
    }
}
- (IBAction)chooseDateBtn:(id)sender {
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
        self.birthTextField.text=selectDate;
        
    };
    //配置属性
    [datePickVC configuration];
    
    [self.view addSubview:datePickVC];
}

- (IBAction)ssdwBtnClick:(id)sender {
    NSArray *arr = @[@"原告",@"被告",@"第三人",@"申请(起诉)人",@"被起诉人"];
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

- (IBAction)GjBtnClick:(id)sender {
    
    if(self.dropDown == nil) {
        CGFloat f = 320;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.GjNameArr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}
- (IBAction)SexyBtnClick:(id)sender {
    NSArray *arr = @[@"男",@"女",@"其他",@"未知"];
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
- (IBAction)whcdBtnClick:(id)sender {
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
- (IBAction)nationBtnClick:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 320;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.nationNameArr :nil :@"up"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}
- (IBAction)jobBtnClick:(id)sender {
    NSArray *arr = @[@"学生",@"教师",@"医生",@"程序员",@"工程师",@"经理",@"司机",@"公务员"];
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

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveAndBack:(id)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    params[@"flag"] = @1;
//    if (self.myDsrInfoModel) {
//        params[@"ajbs"] = self.myDsrInfoModel.ajbs;
//    }
    params[@"ajbs"] = self.ylaIndoId;
    params[@"lxbm"] = @"1";
    params[@"lxmc"] = @"个人当事人";
    params[@"ssdwmc"] = self.ssdwBtnClick.titleLabel.text;
    if ([self.ssdwBtnClick.titleLabel.text isEqualToString:@"原告"]) {
        params[@"ssdw"] = @"108001";
    } else if ([self.ssdwBtnClick.titleLabel.text isEqualToString:@"被告"]) {
        params[@"ssdw"] = @"108002";
    } else if ([self.ssdwBtnClick.titleLabel.text isEqualToString:@"第三人"]) {
        params[@"ssdw"] = @"108003";
    } else if ([self.ssdwBtnClick.titleLabel.text isEqualToString:@"申请(起诉)人"]) {
        params[@"ssdw"] = @"108004";
    } else if ([self.ssdwBtnClick.titleLabel.text isEqualToString:@"被起诉人"]) {
        params[@"ssdw"] = @"108005";
    }
    params[@"mc"] = self.dsrInfoTextField.text;
    params[@"gjmc"] = self.gjBtn.titleLabel.text;
//    params[@"zjlx"] = @"居民身份证";
    params[@"sfzjhm"] = self.zjNumTextField.text;
    params[@"xbmc"] = self.sexBtn.titleLabel.text;
    params[@"csrq"] = self.birthTextField.text;
    params[@"dwdz"] = self.hujiAddressTextField.text;
    params[@"jtdz"] = self.juzhuAddressTextField.text;
    params[@"dhhm"] = self.telNumberTextField.text;
    params[@"ybbh"] = self.yzBmTextField.text;
    params[@"whcdmc"] = self.chooseEducation.titleLabel.text;
    params[@"mzmc"] = self.chooseNation.titleLabel.text;
//    params[@"zy"] = self.chooseJob.titleLabel.text;
    
    [SWTHttpTool post:SaveOrChangeDSRInfoUrl params:params success:^(id json) {
        NSLog(@"00--00--%@",params);
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"cg%@",json);
    } failure:^(NSError *error) {
        NSLog(@"sb%@--%@",error,params);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)GjArr {
	if(_GjArr == nil) {
		_GjArr = [[NSMutableArray alloc] init];
	}
	return _GjArr;
}

- (NSMutableArray *)GjNameArr {
	if(_GjNameArr == nil) {
		_GjNameArr = [[NSMutableArray alloc] init];
	}
	return _GjNameArr;
}

- (NSMutableArray *)whcdNameArr {
	if(_whcdNameArr == nil) {
		_whcdNameArr = [[NSMutableArray alloc] init];
	}
	return _whcdNameArr;
}

- (NSMutableArray *)whcdArr {
	if(_whcdArr == nil) {
		_whcdArr = [[NSMutableArray alloc] init];
	}
	return _whcdArr;
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
