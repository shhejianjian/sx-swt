//
//  SWTTgInfoViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTTgInfoViewController.h"
#import "NIDropDown.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTFyType.h"
#import "SWTXsFjListViewController.h"
#import "SWTBase.h"
@interface SWTTgInfoViewController ()<NIDropDownDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITextField *jbrsfzhm;
@property (nonatomic, strong) NIDropDown *dropDown;

@property (strong, nonatomic) IBOutlet UITextField *jbrNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *jbrlxdh;
@property (strong, nonatomic) IBOutlet UITextField *jbrsjhm;
@property (strong, nonatomic) IBOutlet UITextField *bjbrxm;
@property (strong, nonatomic) IBOutlet UITextField *zxah;
@property (strong, nonatomic) IBOutlet UIButton *zxfyBtn;
@property (nonatomic, strong) NSMutableArray *fyTypeArr;
@property (nonatomic, strong) NSMutableArray *fyNameArr;
@property (nonatomic, copy) NSString *lafyDMStr;



@end

@implementation SWTTgInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self loadFyTypefirst];
    [self setUpUI];
    
    NSString *fyMcStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
    [self.zxfyBtn setTitle:fyMcStr forState:UIControlStateNormal];
    self.zxfyBtn.userInteractionEnabled = NO;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
    if (self.xsListModel) {
        self.jbrNameTextField.text = self.usermapModel.name;
        self.jbrsfzhm.text = self.usermapModel.sfzhm;
        self.jbrlxdh.text = self.usermapModel.lxdh;
        self.jbrsjhm.text = self.usermapModel.sjhm;
        self.bjbrxm.text = self.xsListModel.bjbrmc;
        [self.zxfyBtn setTitle:self.xsListModel.fymc forState:UIControlStateNormal];
        self.zxah.text = self.xsListModel.ahqc;
    }
}

- (IBAction)loadLoginInfo:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *lxdh = [userDefault objectForKey:@"lxdh"];
    NSString *sjhm = [userDefault objectForKey:@"sjhm"];
    NSString *zjhm = [userDefault objectForKey:@"sfzhm"];
    if (name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"在我的页面进行登录才可加载自身信息"];
    } else {
        self.jbrNameTextField.text = name;
        self.jbrlxdh.text = lxdh;
        self.jbrsjhm.text = sjhm;
        self.jbrsfzhm.text = zjhm;
    }
}
- (IBAction)loadFyType:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 280;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.fyNameArr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    SWTFyType *fyTypeModel = self.fyTypeArr[self.dropDown.index];
    self.lafyDMStr = fyTypeModel.XSSX;
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}
- (void)loadFyTypefirst {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"t_bmxt_bm_fy"ofType:@"json"];
    //根据文件路径读取数据
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    //格式化成json数据
    NSError *error = nil;
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
    self.fyTypeArr = [SWTFyType mj_objectArrayWithKeyValuesArray:JsonObject[@"RECORDS"]];
    NSString *fymcStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"courtName"];
    for (SWTFyType *fyTypeModel in self.fyTypeArr) {
        if ([fymcStr isEqualToString:@"榆林法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"RA"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"铜川法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R2"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"宝鸡法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R3"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"安康法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R7"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"渭南法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R5"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"汉中法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R6"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"咸阳法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R4"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"西安法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R1"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"延安法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R9"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"商洛法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R8"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        } else if ([fymcStr isEqualToString:@"陕西法院"]) {
            if ([fyTypeModel.DM hasPrefix:@"R00"] || [fyTypeModel.DM hasPrefix:@"R10"] || [fyTypeModel.DM hasPrefix:@"R20"] || [fyTypeModel.DM hasPrefix:@"R30"] || [fyTypeModel.DM hasPrefix:@"R40"] || [fyTypeModel.DM hasPrefix:@"R50"] || [fyTypeModel.DM hasPrefix:@"R60"] || [fyTypeModel.DM hasPrefix:@"R70"] || [fyTypeModel.DM hasPrefix:@"R80"] || [fyTypeModel.DM hasPrefix:@"R90"] || [fyTypeModel.DM hasPrefix:@"RB0"] || [fyTypeModel.DM hasPrefix:@"RB1"]) {
                [self.fyNameArr addObject:fyTypeModel.DMMS];
            }
        }
        
    }
}

- (IBAction)jumpToNext:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    if (self.xsListModel) {
//        params[@"xsid"] = self.xsListModel.id;
//    }
    params[@"loginname"] = [userDefault objectForKey:@"apploginname"];
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    params[@"flag"] = @1;
    params[@"sfzjhm"] = self.jbrsfzhm.text;
    params[@"lxdh"] = self.jbrlxdh.text;
    params[@"lxsj"] = self.jbrsjhm.text;
    params[@"bjbrmc"] = self.bjbrxm.text;
    params[@"fydm"] = [userDefault objectForKey:@"selectFyDM"];
    params[@"fymc"] = self.zxfyBtn.titleLabel.text;
    params[@"ahqc"] = self.zxah.text;
    [SWTHttpTool post:SaveXsInfoUrl params:params success:^(id json) {
        
        SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
        if ([baseModel.flag isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            SWTXsFjListViewController *fjListVC = [[SWTXsFjListViewController alloc]init];
            fjListVC.jbxsidStr = baseModel.xsid;
            NSLog(@"xiugai:%@",baseModel.xsid);
            fjListVC.checkStatusStr = @"修改";

            [self.navigationController pushViewController:fjListVC animated:YES];
        }
        
        
        NSLog(@"++%@==%@",json,params);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不稳定，请稍后再试"];
        NSLog(@"--%@",error);
    }];
    
    
    
    
    
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

- (NSMutableArray *)fyTypeArr {
	if(_fyTypeArr == nil) {
		_fyTypeArr = [[NSMutableArray alloc] init];
	}
	return _fyTypeArr;
}

- (NSMutableArray *)fyNameArr {
	if(_fyNameArr == nil) {
		_fyNameArr = [[NSMutableArray alloc] init];
	}
	return _fyNameArr;
}

@end
