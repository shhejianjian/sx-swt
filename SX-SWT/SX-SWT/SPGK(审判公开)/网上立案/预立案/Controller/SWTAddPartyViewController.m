//
//  SWTAddPartyViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/26.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAddPartyViewController.h"
#import "SWTPartyCell.h"
#import "SWTAddPlaintiffViewController.h"
#import "SWTSecondPartyCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "RecommendHeadView.h"
#import "SWTSSCLViewController.h"
#import "SWTAddCompanyViewController.h"
#import "UITableView+Popover.h"
#import "SWTDsrInfo.h"
#import "NSString+FontAwesome.h"
#import "SVProgressHUD.h"

static NSString *identifier1 = @"cell1";
static NSString *identifier2 = @"cell2";
@interface SWTAddPartyViewController () <recommedDelegate>
{
    //设置一个状态为数值下标2表示分组个数
    BOOL  isOpen[2];
    RecommendHeadView *_CellHeadView;
}

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dsrInfoArr;

@property (nonatomic, strong) NSMutableArray *myDsrInfoArr;
@property (nonatomic, strong) NSMutableArray *companyInfoArr;
@property (strong, nonatomic) IBOutlet UIButton *nextVCBtn;

@end

@implementation SWTAddPartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];

    [self.tableView registerNib:[UINib nibWithNibName:@"SWTPartyCell" bundle:nil] forCellReuseIdentifier:identifier1];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTSecondPartyCell" bundle:nil] forCellReuseIdentifier:identifier2];
    
    if ([self.checkStatusStr isEqualToString:@"查看"]) {
        [self.nextVCBtn setTitle:@"查看诉讼材料" forState:UIControlStateNormal];
    } else {
        [self.nextVCBtn setTitle:@"添加诉讼材料" forState:UIControlStateNormal];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDsrInfo)];
    [self.tableView.mj_header beginRefreshing];
    [SVProgressHUD dismiss];
}

- (void)loadDsrInfo {
    [self.myDsrInfoArr removeAllObjects];
    [self.companyInfoArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    params[@"ylainfoid"] = self.ylaInfoIdStr;
    [SWTHttpTool post:getYlaDsrByYlaId params:params success:^(id json) {
        
        self.dsrInfoArr = [SWTDsrInfo mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        for (SWTDsrInfo *dsrinfoModel in self.dsrInfoArr) {
            if ([dsrinfoModel.lxbm isEqualToString:@"1"]) {
                [self.myDsrInfoArr addObject:dsrinfoModel];
            } else {
                [self.companyInfoArr addObject:dsrinfoModel];
            }
        }
        NSLog(@"===++%@---%@",json,params);
    } failure:^(NSError *error) {
        NSLog(@"---%@",error);
    }];
    [self.tableView.mj_header endRefreshing];
}





- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)jumpToNext:(id)sender {
    SWTSSCLViewController *ssclVC = [[SWTSSCLViewController alloc]init];
    ssclVC.ylaInfoId = self.ylaInfoIdStr;
    ssclVC.checkStatusStr = self.checkStatusStr;
    [self.navigationController pushViewController:ssclVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isOpen[section]) {
        if (section == 0) {
            return self.myDsrInfoArr.count;
        } else if (section ==1) {
            return self.companyInfoArr.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWTPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (!cell) {
        cell = [[SWTPartyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
    if (indexPath.section == 0) {
        cell.dsrInfoModel = self.myDsrInfoArr[indexPath.row];
    } else {
        cell.companyDsrInfoModel = self.companyInfoArr[indexPath.row];
        cell.xzOrxbLabel.text = @"单位地址：";
    }
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}



//自定义头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    _CellHeadView=[[RecommendHeadView alloc]init];
    _CellHeadView.chooseBtn.tag=section;
    
    if (isOpen[section] == 1) {
        _CellHeadView.chooseBtn.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:25];
        [_CellHeadView.chooseBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAIconSortDown] forState:UIControlStateNormal];
        [_CellHeadView.chooseBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAIconSortDown] forState:UIControlStateHighlighted];

        [_CellHeadView.chooseBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_CellHeadView.chooseBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];

    } else {
        _CellHeadView.chooseBtn.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
        [_CellHeadView.chooseBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAIconPlay] forState:UIControlStateNormal];
        [_CellHeadView.chooseBtn setTitle:[NSString fontAwesomeIconStringForEnum:FAIconPlay] forState:UIControlStateHighlighted];

        [_CellHeadView.chooseBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_CellHeadView.chooseBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];

    }
    _CellHeadView.delegate = self;
    _CellHeadView.addPartyBtn.tag = section;
    if (section == 0) {
        _CellHeadView.titleLabel.text = @"添加个人当事人信息";
    } else if (section == 1) {
        _CellHeadView.titleLabel.text = @"添加单位当事人信息";
    }
    

        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(gestureAction:)];
        [_CellHeadView.chooseBtn addGestureRecognizer: gesture];

    return _CellHeadView;
    
}
//头视图的响应事件
- (void)gestureAction :(UITapGestureRecognizer *)gesture {
    
    //获取当前点击组的tag值
    NSInteger section = gesture.view.tag;
    NSLog(@"%d",isOpen[section]);
    //当点击哪一组之后它的状态取反
    isOpen[section] = !isOpen[section];
    [_tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.checkStatusStr isEqualToString:@"查看"]) {
        NSArray *names = @[@"查看"];
        NSMutableArray *items = [NSMutableArray array];
        
        for (NSInteger i = 0; i<names.count; i++) {
            PopoverItem *item = [[PopoverItem alloc]initWithName:names[i] image:nil selectedHandler:^(PopoverItem *item) {
            if ([item.name isEqualToString:@"查看"]) {
                    if (indexPath.section == 0) {
                        SWTDsrInfo *myDsrInfoModel = self.myDsrInfoArr[indexPath.row];
                        
                        SWTAddPlaintiffViewController *plaintVC = [[SWTAddPlaintiffViewController alloc]init];
                        plaintVC.checkStatusInfoModel = myDsrInfoModel;
                        [self.navigationController pushViewController:plaintVC animated:YES];
                    } else if (indexPath.section == 1) {
                        SWTDsrInfo *companyDsrInfoModel = self.companyInfoArr[indexPath.row];
                        
                        SWTAddCompanyViewController *companyVC = [[SWTAddCompanyViewController alloc]init];
                        companyVC.checkStatusInfoModel = companyDsrInfoModel;
                        [self.navigationController pushViewController:companyVC animated:YES];
                    }
                }
            }];
            [items addObject:item];

        }
        [tableView showPopoverWithItems:items forIndexPath:indexPath];

    } else {
        NSArray *names = @[@"删除"];
        NSMutableArray *items = [NSMutableArray array];
        
        for (NSInteger i = 0; i<names.count; i++) {
            PopoverItem *item = [[PopoverItem alloc]initWithName:names[i] image:nil selectedHandler:^(PopoverItem *popoverItem) {
//                if ([popoverItem.name isEqualToString:@"修改"]) {
//                    
//                    
//                    
//                    if (indexPath.section == 0) {
//                        SWTDsrInfo *myDsrInfoModel = self.myDsrInfoArr[indexPath.row];
//                        
//                        SWTAddPlaintiffViewController *plaintVC = [[SWTAddPlaintiffViewController alloc]init];
//                        plaintVC.myDsrInfoModel = myDsrInfoModel;
//                        plaintVC.ylaIndoId = myDsrInfoModel.ajbs;
//                        [self.navigationController pushViewController:plaintVC animated:YES];
//                        
//                    } else if (indexPath.section == 1) {
//                        SWTDsrInfo *companyDsrInfoModel = self.companyInfoArr[indexPath.row];
//                        
//                        SWTAddCompanyViewController *companyVC = [[SWTAddCompanyViewController alloc]init];
//                        companyVC.companyDsrInfoModel = companyDsrInfoModel;
//                        companyVC.ylaIndoId = companyDsrInfoModel.ajbs;
//                        [self.navigationController pushViewController:companyVC animated:YES];
//                    }
//                    
//                    
//                }
                if ([popoverItem.name isEqualToString:@"删除"]) {
                    
                    
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    
                    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
                    
                    params[@"outusername"] = [userDefault objectForKey:@"name"];
                    
                    params[@"flag"] = @1;
                    if (indexPath.section == 0) {
                        SWTDsrInfo *myDsrInfoModel = self.myDsrInfoArr[indexPath.row];
                        
                        params[@"dsrid"] = myDsrInfoModel.jlid;
                        
                    } else if (indexPath.section == 1) {
                        SWTDsrInfo *companyDsrInfoModel = self.companyInfoArr[indexPath.row];
                        
                        params[@"dsrid"] = companyDsrInfoModel.jlid;
                    }
                    [SWTHttpTool post:DeleteYlaDsrByIdUrl params:params success:^(id json) {
                        
                        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        NSLog(@"删除成功：%@",json);
                        [self.tableView.mj_header beginRefreshing];
                    } failure:^(NSError *error) {
                        [SVProgressHUD showErrorWithStatus:@"删除失败"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        NSLog(@"删除失败：%@",error);
                    }];
                    [self.tableView.mj_header endRefreshing];
                    
                }
                
            }];
            [items addObject:item];
        }
        [tableView showPopoverWithItems:items forIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
    
}


#pragma mark - recommendDelegate
- (void)clickAddBtn:(RecommendHeadView *)view atSectionTag:(NSInteger)sectionTag {
    if ([self.checkStatusStr isEqualToString:@"查看"]) {
        [SVProgressHUD showErrorWithStatus:@"当前处于查看状态下无法添加"];
    }else {
        if (sectionTag == 0) {
            SWTAddPlaintiffViewController *plaintVC = [[SWTAddPlaintiffViewController alloc]init];
            plaintVC.ylaIndoId = self.ylaInfoIdStr;
            [self.navigationController pushViewController:plaintVC animated:YES];
        }else if (sectionTag == 1) {
            SWTAddCompanyViewController *companyVC = [[SWTAddCompanyViewController alloc]init];
            companyVC.ylaIndoId = self.ylaInfoIdStr;
            [self.navigationController pushViewController:companyVC animated:YES];
        }
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

- (NSMutableArray *)dsrInfoArr {
	if(_dsrInfoArr == nil) {
		_dsrInfoArr = [[NSMutableArray alloc] init];
	}
	return _dsrInfoArr;
}

- (NSMutableArray *)companyInfoArr {
	if(_companyInfoArr == nil) {
		_companyInfoArr = [[NSMutableArray alloc] init];
	}
	return _companyInfoArr;
}

- (NSMutableArray *)myDsrInfoArr {
	if(_myDsrInfoArr == nil) {
		_myDsrInfoArr = [[NSMutableArray alloc] init];
	}
	return _myDsrInfoArr;
}

@end
