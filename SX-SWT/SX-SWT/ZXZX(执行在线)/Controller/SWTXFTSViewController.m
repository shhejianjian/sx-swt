//
//  SWTXFTSViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/9.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTXFTSViewController.h"
#import "NIDropDown.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTFyType.h"
#import "SWTXFImgListViewController.h"
#import "SWTBase.h"


#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface SWTXFTSViewController ()<NIDropDownDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *previewLabel;
@property (nonatomic, strong) NIDropDown *dropDown;
@property (strong, nonatomic) IBOutlet UIButton *backbtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;
@property (strong, nonatomic) IBOutlet UITextField *xfNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *xfSfzTextField;
@property (strong, nonatomic) IBOutlet UITextField *lxdhTextField;
@property (strong, nonatomic) IBOutlet UITextField *sjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *dzyjTextField;
@property (strong, nonatomic) IBOutlet UITextField *yzbmTextField;
@property (strong, nonatomic) IBOutlet UIButton *xfrsfBtn;
@property (strong, nonatomic) IBOutlet UIButton *xffyBtn;
@property (strong, nonatomic) IBOutlet UITextField *ahqcTextField;
@property (strong, nonatomic) IBOutlet UIButton *xfmdBtn;
@property (strong, nonatomic) IBOutlet UITextView *fynrTextView;
@property (strong, nonatomic) IBOutlet UITextField *grdzTextField;
@property (nonatomic, copy) NSString *lafyDMStr;
@property (nonatomic, strong) NSMutableArray *fyTypeArr;
@property (nonatomic, strong) NSMutableArray *fyNameArr;

@end

@implementation SWTXFTSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyMcStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
    [self.xffyBtn setTitle:fyMcStr forState:UIControlStateNormal];
    self.xffyBtn.userInteractionEnabled = NO;
//    self.backbtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backbtn setTitle:@"返回" forState:UIControlStateNormal];
    self.fynrTextView.delegate = self;
    if (ScreenHeight == 568) {
        self.bottomViewConstraint.constant = 120;
    } else if (ScreenHeight == 667) {
        self.bottomViewConstraint.constant = 70;
    } else if (ScreenHeight == 736) {
        self.bottomViewConstraint.constant = 130;
    }
    [self loadFyType];
    [self setUpUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpUI {
    if (self.xfListModel) {
        self.xfNameTextField.text = self.xfListModel.mc;
        self.xfSfzTextField.text = self.xfListModel.sfzjhm;
        self.lxdhTextField.text = self.xfListModel.dhhm;
        self.sjhmTextField.text = self.xfListModel.mobile;
        self.dzyjTextField.text = self.xfListModel.dzyj;
        self.yzbmTextField.text = self.xfListModel.yzbm;
        self.ahqcTextField.text = self.xfListModel.ahqc;
        self.fynrTextView.text = self.xfListModel.fyqk;
        self.grdzTextField.text = self.xfListModel.xfrdz;
        [self.xfrsfBtn setTitle:self.xfListModel.xfrsfmc forState:UIControlStateNormal];
        [self.xffyBtn setTitle:self.xfListModel.fymc forState:UIControlStateNormal];
        [self.xfmdBtn setTitle:self.xfListModel.xfmdmc forState:UIControlStateNormal];
        self.previewLabel.hidden = YES;
    }
}


- (IBAction)loadLoginInfoBtn:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *lxdh = [userDefault objectForKey:@"lxdh"];
    NSString *sjhm = [userDefault objectForKey:@"sjhm"];
    NSString *zjhm = [userDefault objectForKey:@"sfzhm"];
    if (name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"在我的页面进行登录才可加载自身信息"];
    } else {
        self.xfNameTextField.text = name;
        self.lxdhTextField.text = lxdh;
        self.sjhmTextField.text = sjhm;
        self.xfSfzTextField.text = zjhm;
    }
}
- (IBAction)chooseXFRBtn:(id)sender {
    NSArray *arr = @[@"本案当事人",@"诉讼代理人",@"其他"];
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
- (IBAction)chooseFyBtn:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 320;
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
- (void)loadFyType {
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

- (IBAction)chooseMdBtn:(id)sender {
    NSArray *arr = @[@"告诉",@"申诉、申请再审",@"执行",@"非诉",@"其他"];
    if(self.dropDown == nil) {
        CGFloat f = 200;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)jumpToNextVC:(id)sender {
    NSMutableDictionary *uuidParams = [NSMutableDictionary dictionary];
    if (self.xfListModel) {
        uuidParams[@"xfid"] = self.xfListModel.id;
    }
    [SWTHttpTool get:GetXFUUIDUrl params:uuidParams success:^(id json) {
        NSLog(@"%@",json);
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if (self.xfListModel) {
            params[@"xfid"] = self.xfListModel.id;
        }
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        params[@"flag"] = @1;
        params[@"mc"] = self.xfNameTextField.text;
        params[@"loginname"] = [userDefault objectForKey:@"apploginname"];
        params[@"dhhm"] = self.lxdhTextField.text;
        params[@"mobile"] = self.sjhmTextField.text;
        params[@"sfzjhm"] = self.xfSfzTextField.text;
        params[@"dzyj"] = self.dzyjTextField.text;
        params[@"yzbm"] = self.yzbmTextField.text;
        params[@"xfrsfmc"] = self.xfrsfBtn.titleLabel.text;
        if ([self.xfrsfBtn.titleLabel.text isEqualToString:@"本案当事人"]) {
            params[@"xfrsf"] = @"1";
        } else if ([self.xfrsfBtn.titleLabel.text isEqualToString:@"诉讼代理人"]) {
            params[@"xfrsf"] = @"2";
        } else if ([self.xfrsfBtn.titleLabel.text isEqualToString:@"其他"]) {
            params[@"xfrsf"] = @"5";
        }
        params[@"xfrdz"] = self.grdzTextField.text;
        params[@"fydm"] = [userDefault objectForKey:@"selectFyDM"];
        params[@"fymc"] = self.xffyBtn.titleLabel.text;
        params[@"ahqc"] = self.ahqcTextField.text;
        params[@"xfmdmc"] = self.xfmdBtn.titleLabel.text;
        if ([self.xfmdBtn.titleLabel.text isEqualToString:@"告诉"]) {
            params[@"xfmdbm"] = @"1";
        } else if ([self.xfmdBtn.titleLabel.text isEqualToString:@"申诉、申请再审"]) {
            params[@"xfmdbm"] = @"2";
        } else if ([self.xfmdBtn.titleLabel.text isEqualToString:@"执行"]) {
            params[@"xfmdbm"] = @"3";
        } else if ([self.xfmdBtn.titleLabel.text isEqualToString:@"非诉"]) {
            params[@"xfmdbm"] = @"5";
        } else if ([self.xfmdBtn.titleLabel.text isEqualToString:@"其他"]) {
            params[@"xfmdbm"] = @"6";
        }
        
        
        params[@"fyqk"] = self.fynrTextView.text;
        NSLog(@"---%@",params);
        [SWTHttpTool post:SaveXFInfoUrl params:params success:^(id json) {
            
            SWTBase *baseModel = [SWTBase mj_objectWithKeyValues:json];
            NSLog(@"%@==",baseModel.xfid);
            
            
            SWTXFImgListViewController *xfImgListVC = [[SWTXFImgListViewController alloc]init];
            if (self.xfListModel) {
                xfImgListVC.xfIdStr = self.xfListModel.id;
            } else {
                xfImgListVC.xfIdStr = baseModel.xfid;
            }
            xfImgListVC.checkStatusStr = @"修改";
            [self.navigationController pushViewController:xfImgListVC animated:YES];
            NSLog(@"++%@",json);
            
        } failure:^(NSError *error) {
            
            NSLog(@"--%@",error);
            
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length != 0) {
        self.previewLabel.hidden = YES;
    }else{
        self.previewLabel.hidden = NO;
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
