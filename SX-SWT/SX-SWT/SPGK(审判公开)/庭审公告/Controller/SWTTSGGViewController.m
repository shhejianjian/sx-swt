//
//  SWTTSGGViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTTSGGViewController.h"
#import "YTDatePick.h"
#import "SWTFyType.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "NIDropDown.h"
#import "SWTAyTreeViewController.h"
#import "SWTGgListViewController.h"

@interface SWTTSGGViewController ()<NIDropDownDelegate>
@property (nonatomic, strong) NIDropDown *dropDown;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *fyqcTextField;
@property (strong, nonatomic) IBOutlet UITextField *ayqcTextField;
@property (strong, nonatomic) IBOutlet UITextField *ahqcTextField;
@property (nonatomic, copy) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *fyTypeArr;
@property (nonatomic, strong) NSMutableArray *fyjcNameArr;
@property (nonatomic, copy) NSString *lafyNameStr;

@end

extern NSString *msAyStr;
extern NSString *msAyDm;

@implementation SWTTSGGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    [self createCancleNotifation];
    [self createNotifation];
    [self loadFyType];
}
- (void)viewWillAppear:(BOOL)animated {
    if (msAyStr) {
        self.ayqcTextField.text = msAyStr;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    msAyStr = nil;
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
    for (SWTFyType *fyTypeModel in self.fyTypeArr) {
        [self.fyjcNameArr addObject:fyTypeModel.FYJC];
    }
}
- (IBAction)chooseFyTypeBtn:(id)sender {
    if(self.dropDown == nil) {
        CGFloat f = 280;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :self.fyjcNameArr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)chooseAyBtn:(id)sender {
    SWTAyTreeViewController *ayTreeVC = [[SWTAyTreeViewController alloc]init];
    [self.navigationController pushViewController:ayTreeVC animated:YES];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    SWTFyType *fyTypeModel = self.fyTypeArr[self.dropDown.index];
    self.lafyNameStr = fyTypeModel.DMMS;
    self.fyqcTextField.text = self.lafyNameStr;
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}

- (IBAction)startTimeBtn:(id)sender {
    [self createBackgroundView];
    [YTDatePick showPickWithMakeSure:^(id year, id month, id day) {
        self.startTimeTextField.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    }];
}

- (IBAction)endTimeBtn:(id)sender {
    [self createBackgroundView];
    [YTDatePick showPickWithMakeSure:^(id year, id month, id day) {
        self.endTimeTextField.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    }];
}

-(void)createBackgroundView{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.6;
    _bgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgView];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)jumpToNextVC:(id)sender {
    SWTGgListViewController *ggListVC = [[SWTGgListViewController alloc]init];
    ggListVC.ahStr = self.ahqcTextField.text;
    ggListVC.ayStr = self.ayqcTextField.text;
    ggListVC.fydmStr = self.fyqcTextField.text;
    ggListVC.startTimeStr = self.startTimeTextField.text;
    ggListVC.endTimeStr = self.endTimeTextField.text;
    [self.navigationController pushViewController:ggListVC animated:YES];
}









#pragma mark -- 时间选择器
-(void)createCancleNotifation{
    if([self respondsToSelector:@selector(setCancleValueChanges)]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCancleValueChanges) name:@"setCancleValueChanges" object:nil];
    }
}
-(void)createNotifation{
    if([self respondsToSelector:@selector(setCancleValueChanges)]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCancleValueChanges) name:@"setInfor" object:nil];
    }
}
-(void)setCancleValueChanges {
    [_bgView removeFromSuperview];
}





- (NSMutableArray *)fyjcNameArr {
	if(_fyjcNameArr == nil) {
		_fyjcNameArr = [[NSMutableArray alloc] init];
	}
	return _fyjcNameArr;
}

- (NSMutableArray *)fyTypeArr {
	if(_fyTypeArr == nil) {
		_fyTypeArr = [[NSMutableArray alloc] init];
	}
	return _fyTypeArr;
}

@end
