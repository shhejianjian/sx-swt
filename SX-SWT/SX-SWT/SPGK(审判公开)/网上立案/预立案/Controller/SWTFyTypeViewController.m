//
//  SWTFyTypeViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/26.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTFyTypeViewController.h"
#import "NIDropDown.h"
#import "SWTMSViewController.h"
#import "SWTXZViewController.h"
#import "SWTZXViewController.h"
#import "SWTFyType.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "ZYLAlert.h"

@interface SWTFyTypeViewController ()<NIDropDownDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) NIDropDown *dropDown;
@property (strong, nonatomic) IBOutlet UIButton *ajlxBtn;
@property (strong, nonatomic) IBOutlet UIButton *spcxBtn;
@property (strong, nonatomic) IBOutlet UILabel *spcxLabel;
@property (strong, nonatomic) IBOutlet UIButton *fymcBtn;
@property (nonatomic, copy) NSString *lafyDMStr;



@property (nonatomic, strong) NSMutableArray *fyTypeArr;
@property (nonatomic, strong) NSMutableArray *fyNameArr;
@end

@implementation SWTFyTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyMcStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
    [self.fymcBtn setTitle:fyMcStr forState:UIControlStateNormal];
    self.fymcBtn.userInteractionEnabled = NO;
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self loadFyType];
    // Do any additional setup after loading the view from its nib.
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
    NSLog(@"fymc;%@",JsonObject);
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

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)jumpToNext:(id)sender {
    
    if ([self.fymcBtn.titleLabel.text isEqualToString:@"选择法院"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择立案法院"];
    } else if ([self.ajlxBtn.titleLabel.text isEqualToString:@"选择类型"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择立案类型"];
    } else {
        if ([_ajlxBtn.titleLabel.text isEqualToString:@"民事"]) {
            SWTMSViewController *msVC = [[SWTMSViewController alloc]init];
            msVC.ajTypeStr = self.ajlxBtn.titleLabel.text;
            msVC.lafymcStr = self.fymcBtn.titleLabel.text;
            msVC.lafyDMStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectFyDM"];
            [self.navigationController pushViewController:msVC animated:YES];
        } else if ([_ajlxBtn.titleLabel.text isEqualToString:@"行政"]) {
            SWTXZViewController *xzVC = [[SWTXZViewController alloc]init];
            xzVC.ajTypeStr = self.ajlxBtn.titleLabel.text;
            xzVC.lafymcStr = self.fymcBtn.titleLabel.text;
            xzVC.lafyDMStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectFyDM"];
            [self.navigationController pushViewController:xzVC animated:YES];
        } else if ([_ajlxBtn.titleLabel.text isEqualToString:@"执行"]) {
            SWTZXViewController *zxVC = [[SWTZXViewController alloc]init];
            zxVC.ajTypeStr = self.ajlxBtn.titleLabel.text;
            zxVC.lafymcStr = self.fymcBtn.titleLabel.text;
            zxVC.lafyDMStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectFyDM"];
            [self.navigationController pushViewController:zxVC animated:YES];
        }
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

- (IBAction)chooseAJTypeBtn:(id)sender {
//    NSArray *arr = @[@"民事",@"行政",@"执行"];
//    if(self.dropDown == nil) {
//        CGFloat f = 120;
//        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
////        self.dropDown.delegate = self;
//    }
//    else {
//        [self.dropDown hideDropDown:sender];
//        [self rel];
//    }
    
    ZYLAlert *zylAlert = [[ZYLAlert alloc] initWithTitle:@"提示" message:@"请选择立案类型"];
    [zylAlert addBtnAlertTitle:@"民事" action:^{
        [self.ajlxBtn setTitle:@"民事" forState:UIControlStateNormal];
        self.spcxLabel.text = @"一审";
    }];
    [zylAlert addBtnAlertTitle:@"行政" action:^{
        [self.ajlxBtn setTitle:@"行政" forState:UIControlStateNormal];
        self.spcxLabel.text = @"一审";
    }];
    [zylAlert addBtnAlertTitle:@"执行" action:^{
        [self.ajlxBtn setTitle:@"执行" forState:UIControlStateNormal];
        self.spcxLabel.text = @"执行";
    }];
    [zylAlert addBtnAlertTitle:@"取消" action:^{
        NSLog(@"取消");
    }];
    [zylAlert showAlertWithSender:self];

}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    SWTFyType *fyTypeModel = self.fyTypeArr[self.dropDown.index];
    self.lafyDMStr = fyTypeModel.XSSX;
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
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
