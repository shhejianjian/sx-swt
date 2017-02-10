//
//  SWTcxFirstViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTcxFirstViewController.h"
#import "SWTspcxMainViewController.h"
#import "SWTFyType.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "NIDropDown.h"
#import "SWTAyTreeViewController.h"

@interface SWTcxFirstViewController ()<NIDropDownDelegate>
@property (nonatomic, strong) NIDropDown *dropDown;


@property (nonatomic, strong) NSMutableArray *fyTypeArr;
@property (nonatomic, strong) NSMutableArray *fyjcNameArr;
@property (nonatomic, copy) NSString *lafyNameStr;
@end

extern NSString *msAyStr;
extern NSString *msAyDm;

@implementation SWTcxFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFyType];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    if (msAyStr) {
        self.ayqcTextField.text = msAyStr;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    msAyStr = nil;
    msAyDm = nil;
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
//    NSLog(@"fymc:%@",JsonObject);
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
        if ([self.delegate respondsToSelector:@selector(didSelect)]) {
            [self.delegate didSelect];
        }
    
}

- (IBAction)chaxunBtn:(id)sender {
    if (self.nianHaoTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"查询编码不得为空"];
        return;
    }
    if (self.zihaoTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"查询密码不得为空"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(clickCXBtnWithAhqc:andNdh:andFymc:andLaay:)]) {
        [self.delegate clickCXBtnWithAhqc:self.zihaoTextField.text andNdh:self.nianHaoTextField.text andFymc:self.fyqcTextField.text andLaay:self.ayqcTextField.text];
    }
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

- (NSMutableArray *)fyjcNameArr {
	if(_fyjcNameArr == nil) {
		_fyjcNameArr = [[NSMutableArray alloc] init];
	}
	return _fyjcNameArr;
}

@end
