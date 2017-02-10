//
//  SWTAddCompanyViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAddCompanyViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "NIDropDown.h"
#import "SWTGjType.h"
#import "SWTDwxz.h"

#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface SWTAddCompanyViewController ()<NIDropDownDelegate>
@property (nonatomic, strong) NIDropDown *dropDown;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstrainst;

@property (strong, nonatomic) IBOutlet UITextField *dwmcTextField;
@property (strong, nonatomic) IBOutlet UITextField *frxmTextField;
@property (strong, nonatomic) IBOutlet UITextField *zjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *zzjgTextField;
@property (strong, nonatomic) IBOutlet UITextField *zcdzTextField;
@property (strong, nonatomic) IBOutlet UITextField *bgdzTextField;
@property (strong, nonatomic) IBOutlet UITextField *sjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *yzbmTextField;
@property (strong, nonatomic) IBOutlet UIButton *ssdwBtn;
@property (strong, nonatomic) IBOutlet UIButton *regionBtn;
@property (strong, nonatomic) IBOutlet UIButton *dwxzBtn;
@property (strong, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic, strong) NSMutableArray *GjArr;
@property (nonatomic, strong) NSMutableArray *GjNameArr;

@property (nonatomic, strong) NSMutableArray *dwxzArr;


@end

@implementation SWTAddCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    if (ScreenHeight == 568) {
        self.bottomViewConstrainst.constant = 70;
    } else if (ScreenHeight == 667) {
        self.bottomViewConstrainst.constant = 20;
    } else if (ScreenHeight == 736) {
        self.bottomViewConstrainst.constant = -10;
    }
    [self loadGjType];
    [self loadDwxzType];
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
    if (self.companyDsrInfoModel) {
        [self.ssdwBtn setTitle:self.companyDsrInfoModel.ssdwmc forState:UIControlStateNormal];
        self.dwmcTextField.text = self.companyDsrInfoModel.mc;
        self.frxmTextField.text = self.companyDsrInfoModel.frdb;
        self.zjhmTextField.text = self.companyDsrInfoModel.sfzjhm;
        [self.regionBtn setTitle:self.companyDsrInfoModel.gjmc forState:UIControlStateNormal];
        self.zzjgTextField.text = self.companyDsrInfoModel.zzjgdm;
//        [self.dwxzBtn setTitle:self.companyDsrInfoModel.dwxz forState:UIControlStateNormal];
        self.zcdzTextField.text = self.companyDsrInfoModel.zzdz;
        self.bgdzTextField.text = self.companyDsrInfoModel.jtdz;
        self.sjhmTextField.text = self.companyDsrInfoModel.zzdhhm;
        self.yzbmTextField.text = self.companyDsrInfoModel.ybbh;
    } else if (self.checkStatusInfoModel)  {
        [self.ssdwBtn setTitle:self.checkStatusInfoModel.ssdwmc forState:UIControlStateNormal];
        [self.ssdwBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.ssdwBtn.userInteractionEnabled = NO;
        
        self.dwmcTextField.text = self.checkStatusInfoModel.mc;
        self.dwmcTextField.userInteractionEnabled = NO;
        self.dwmcTextField.placeholder = @"";
        
        self.frxmTextField.text = self.checkStatusInfoModel.frdb;
        self.frxmTextField.userInteractionEnabled = NO;
        self.frxmTextField.placeholder = @"";

        self.zjhmTextField.text = self.checkStatusInfoModel.sfzjhm;
        self.zjhmTextField.userInteractionEnabled = NO;
        self.zjhmTextField.placeholder = @"";

        [self.regionBtn setTitle:self.checkStatusInfoModel.gjmc forState:UIControlStateNormal];
        [self.regionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.regionBtn.userInteractionEnabled = NO;


        self.zzjgTextField.text = self.checkStatusInfoModel.zzjgdm;
        self.zzjgTextField.userInteractionEnabled = NO;
        self.zzjgTextField.placeholder = @"";

//        [self.dwxzBtn setTitle:self.checkStatusInfoModel.dwxz forState:UIControlStateNormal];
        [self.dwxzBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.dwxzBtn.userInteractionEnabled = NO;


        self.zcdzTextField.text = self.checkStatusInfoModel.zzdz;
        self.zcdzTextField.userInteractionEnabled = NO;
        self.zcdzTextField.placeholder = @"";

        self.bgdzTextField.text = self.checkStatusInfoModel.jtdz;
        self.bgdzTextField.userInteractionEnabled = NO;
        self.bgdzTextField.placeholder = @"";

        self.sjhmTextField.text = self.checkStatusInfoModel.zzdhhm;
        self.sjhmTextField.userInteractionEnabled = NO;
        self.sjhmTextField.placeholder = @"";

        self.yzbmTextField.text = self.checkStatusInfoModel.ybbh;
        self.yzbmTextField.userInteractionEnabled = NO;
        self.yzbmTextField.placeholder = @"";
        self.saveBtn.hidden = YES;
    }
}
- (void)loadGjType {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"t_bmxt_bm_gj"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.GjArr = [SWTGjType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    for (SWTGjType *gjTypeModel in self.GjArr) {
        [self.GjNameArr addObject:gjTypeModel.DMMS];
    }
}
- (void)loadDwxzType {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"dwxz"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSArray *arr = [SWTGjType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    for (SWTDwxz *dwxzModel in arr) {
        [self.dwxzArr addObject:dwxzModel.DMMS];
    }
}

- (IBAction)ssdwBtnCLick:(id)sender {
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

- (IBAction)regionBtnCLick:(id)sender {
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
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}

- (IBAction)dwxzBtnCLick:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 200;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.dwxzArr :nil :@"down"];
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
- (IBAction)saveAndBack:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
//    if (self.companyDsrInfoModel) {
//        params[@"id"] = self.companyDsrInfoModel.ajbs;
//    }
    params[@"ajbs"] = self.ylaIndoId;
    params[@"lxbm"] = @"2";
    params[@"lxmc"] = @"单位当事人";
    params[@"ssdwmc"] = self.ssdwBtn.titleLabel.text;
    if ([self.ssdwBtn.titleLabel.text isEqualToString:@"原告"]) {
        params[@"ssdw"] = @"108001";
    } else if ([self.ssdwBtn.titleLabel.text isEqualToString:@"被告"]) {
        params[@"ssdw"] = @"108002";
    } else if ([self.ssdwBtn.titleLabel.text isEqualToString:@"第三人"]) {
        params[@"ssdw"] = @"108003";
    } else if ([self.ssdwBtn.titleLabel.text isEqualToString:@"申请(起诉)人"]) {
        params[@"ssdw"] = @"108004";
    } else if ([self.ssdwBtn.titleLabel.text isEqualToString:@"被起诉人"]) {
        params[@"ssdw"] = @"108005";
    }
    params[@"mc"] = self.dwmcTextField.text;
    params[@"gjmc"] = self.regionBtn.titleLabel.text;
//    params[@"dbrzjlx"] = @"居民身份证";
    params[@"sfzjhm"] = self.zjhmTextField.text;
    params[@"frdb"] = self.frxmTextField.text;
    params[@"jgdm"] = self.zzjgTextField.text;
    params[@"zzdwxz"] = self.dwxzBtn.titleLabel.text;
    params[@"dhhm"] = self.sjhmTextField.text;
    params[@"zzybbh"] = self.yzbmTextField.text;
    params[@"jtdz"] = self.zcdzTextField.text;
    params[@"zzdz"] = self.bgdzTextField.text;
    
    
    [SWTHttpTool post:SaveOrChangeDSRInfoUrl params:params success:^(id json) {
        
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"cg%@",json);
    } failure:^(NSError *error) {
        NSLog(@"sb%@",error);
    }];
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

- (NSMutableArray *)dwxzArr {
	if(_dwxzArr == nil) {
		_dwxzArr = [[NSMutableArray alloc] init];
	}
	return _dwxzArr;
}

@end
