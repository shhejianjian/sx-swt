//
//  SWTChooseMapViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/29.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTChooseMapViewController.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SVProgressHUD.h"
#import "SWTFyType.h"
#import "SWTMainViewController.h"
#define MainScreenWidth             [[UIScreen mainScreen]bounds].size.width

@interface SWTChooseMapViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *fyTypeArr;
@property (nonatomic, strong) NSArray *allFyNameArr;
@property (nonatomic, strong) NSArray *allFyNameJCArr;

@property (nonatomic, strong) NSMutableArray *R1NameArr;
@property (nonatomic, strong) NSMutableArray *R2NameArr;
@property (nonatomic, strong) NSMutableArray *R3NameArr;
@property (nonatomic, strong) NSMutableArray *R4NameArr;
@property (nonatomic, strong) NSMutableArray *R5NameArr;
@property (nonatomic, strong) NSMutableArray *R6NameArr;
@property (nonatomic, strong) NSMutableArray *R7NameArr;
@property (nonatomic, strong) NSMutableArray *R8NameArr;
@property (nonatomic, strong) NSMutableArray *R9NameArr;
@property (nonatomic, strong) NSMutableArray *R0NameArr;
@property (nonatomic, strong) NSMutableArray *RANameArr;
@property (nonatomic, strong) NSMutableArray *RBNameArr;

@property (nonatomic, strong) NSMutableArray *R0FyArr;
@property (nonatomic, strong) NSMutableArray *R1FyArr;
@property (nonatomic, strong) NSMutableArray *R2FyArr;
@property (nonatomic, strong) NSMutableArray *R3FyArr;
@property (nonatomic, strong) NSMutableArray *R4FyArr;
@property (nonatomic, strong) NSMutableArray *R5FyArr;
@property (nonatomic, strong) NSMutableArray *R6FyArr;
@property (nonatomic, strong) NSMutableArray *R7FyArr;
@property (nonatomic, strong) NSMutableArray *R8FyArr;
@property (nonatomic, strong) NSMutableArray *R9FyArr;
@property (nonatomic, strong) NSMutableArray *RAFyArr;
@property (nonatomic, strong) NSMutableArray *RBFyArr;


@end

@implementation SWTChooseMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFyType];
    self.allFyNameArr = @[@"    陕西省高级人民法院",@"    西安市中级人民法院",@"    铜川市中级人民法院",@"    宝鸡市中级人民法院",@"    咸阳市中级人民法院",@"    渭南市中级人民法院",@"    汉中市中级人民法院",@"    安康市中级人民法院",@"    商洛市中级人民法院",@"    延安市中级人民法院",@"    榆林市中级人民法院",@"    铁路运输法院"];
    self.allFyNameJCArr = @[@"陕西",@"西安",@"铜川",@"宝鸡",@"咸阳",@"渭南",@"汉中",@"安康",@"商洛",@"延安",@"榆林",@"铁路"];
    
    
    // Do any additional setup after loading the view from its nib.
}

//- (void)viewDidAppear:(BOOL)animated {
//    NSString *courtNameIDStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
//    NSLog(@"++====%@",courtNameIDStr);
//    if (courtNameIDStr.length > 0) {
//        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        SWTMainViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"mainTab"];
//        [self presentViewController:nav animated:NO completion:nil];
//    }
//}

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
    for (SWTFyType *fyTypeModel in self.fyTypeArr) {
        if ([fyTypeModel.DM hasPrefix:@"R0"]) {
            [self.R0NameArr addObject:fyTypeModel.DMMS];
            [self.R0FyArr addObject:fyTypeModel];
        } else if ([fyTypeModel.DM hasPrefix:@"R1"]) {
            [self.R1NameArr addObject:fyTypeModel.DMMS];
            [self.R1FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R2"]) {
            [self.R2NameArr addObject:fyTypeModel.DMMS];
            [self.R2FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R3"]) {
            [self.R3NameArr addObject:fyTypeModel.DMMS];
            [self.R3FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R4"]) {
            [self.R4NameArr addObject:fyTypeModel.DMMS];
            [self.R4FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R5"]) {
            [self.R5NameArr addObject:fyTypeModel.DMMS];
            [self.R5FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R6"]) {
            [self.R6NameArr addObject:fyTypeModel.DMMS];
            [self.R6FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R7"]) {
            [self.R7NameArr addObject:fyTypeModel.DMMS];
            [self.R7FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R8"]) {
            [self.R8NameArr addObject:fyTypeModel.DMMS];
            [self.R8FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"R9"]) {
            [self.R9NameArr addObject:fyTypeModel.DMMS];
            [self.R9FyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"RA"]) {
            [self.RANameArr addObject:fyTypeModel.DMMS];
            [self.RAFyArr addObject:fyTypeModel];

        } else if ([fyTypeModel.DM hasPrefix:@"RB"]) {
            [self.RBNameArr addObject:fyTypeModel.DMMS];
            [self.RBFyArr addObject:fyTypeModel];

        }
        
    }
}


#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section == 0) {
        return self.R0NameArr.count;
    } else if (section == 1) {
        return self.R1NameArr.count;

    } else if (section == 2) {
        return self.R2NameArr.count;

    } else if (section == 3) {
        return self.R3NameArr.count;

    } else if (section == 4) {
        return self.R4NameArr.count;

    } else if (section == 5) {
        return self.R5NameArr.count;

    } else if (section == 6) {
        return self.R6NameArr.count;

    } else if (section == 7) {
        return self.R7NameArr.count;

    } else if (section == 8) {
        return self.R8NameArr.count;

    } else if (section == 9) {
        return self.R9NameArr.count;

    } else if (section == 10) {
        return self.RANameArr.count;

    } else if (section == 11) {
        return self.RBNameArr.count;

    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *ID=@"chooseMapCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[UITableViewCell alloc]init];
        
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.R0NameArr[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.R1NameArr[indexPath.row];
    } else if (indexPath.section == 2) {
        cell.textLabel.text = self.R2NameArr[indexPath.row];
    } else if (indexPath.section == 3) {
        cell.textLabel.text = self.R3NameArr[indexPath.row];
    } else if (indexPath.section == 4) {
        cell.textLabel.text = self.R4NameArr[indexPath.row];
    } else if (indexPath.section == 5) {
        cell.textLabel.text = self.R5NameArr[indexPath.row];
    } else if (indexPath.section == 6) {
        cell.textLabel.text = self.R6NameArr[indexPath.row];
    } else if (indexPath.section == 7) {
        cell.textLabel.text = self.R7NameArr[indexPath.row];
    } else if (indexPath.section == 8) {
        cell.textLabel.text = self.R8NameArr[indexPath.row];
    } else if (indexPath.section == 9) {
        cell.textLabel.text = self.R9NameArr[indexPath.row];
    } else if (indexPath.section == 10) {
        cell.textLabel.text = self.RANameArr[indexPath.row];
    } else if (indexPath.section == 11) {
        cell.textLabel.text = self.RBNameArr[indexPath.row];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 60;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 40;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    
    CGRect frameRect = CGRectMake(0, 0, MainScreenWidth, 40);
    UILabel *label = [[UILabel alloc] initWithFrame:frameRect];
    label.backgroundColor = SWTColor(245, 245, 245);
    label.textColor = SWTColor(98, 9, 15);
    label.text = self.allFyNameArr[section];
    return label;
    
    
    
}
//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.allFyNameJCArr objectAtIndex:section];
}
//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.allFyNameJCArr;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        SWTFyType *fytypeModel = self.R0FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.newsID,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 1) {
        SWTFyType *fytypeModel = self.R1FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 2) {
        SWTFyType *fytypeModel = self.R2FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 3) {
        SWTFyType *fytypeModel = self.R3FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 4) {
        SWTFyType *fytypeModel = self.R4FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 5) {
        SWTFyType *fytypeModel = self.R5FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 6) {
        SWTFyType *fytypeModel = self.R6FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 7) {
        SWTFyType *fytypeModel = self.R7FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 8) {
        SWTFyType *fytypeModel = self.R8FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 9) {
        SWTFyType *fytypeModel = self.R9FyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 10) {
        SWTFyType *fytypeModel = self.RAFyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 11) {
        SWTFyType *fytypeModel = self.RBFyArr[indexPath.row];
        NSLog(@"%@--%@",fytypeModel.DM,fytypeModel.DMMS);
        NSString *message = [NSString stringWithFormat:@"确认选择%@?",fytypeModel.DMMS];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setObject:fytypeModel.DMMS forKey:@"selectCourtName"];
            [userDefault setObject:fytypeModel.newsID forKey:@"selectCourtID"];
            [userDefault setObject:fytypeModel.DZ forKey:@"selectSpwyID"];
            [userDefault setObject:fytypeModel.DM forKey:@"selectFyDM"];
            [userDefault setObject:fytypeModel.SM forKey:@"selectFyDLBM"];
            [userDefault setObject:fytypeModel.DZYX forKey:@"selectFyAddress"];
            [userDefault setObject:fytypeModel.LXDH forKey:@"selectFyLxdh"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)fyTypeArr {
	if(_fyTypeArr == nil) {
		_fyTypeArr = [[NSMutableArray alloc] init];
	}
	return _fyTypeArr;
}



- (NSMutableArray *)R1NameArr {
	if(_R1NameArr == nil) {
		_R1NameArr = [[NSMutableArray alloc] init];
	}
	return _R1NameArr;
}

- (NSMutableArray *)R2NameArr {
	if(_R2NameArr == nil) {
		_R2NameArr = [[NSMutableArray alloc] init];
	}
	return _R2NameArr;
}

- (NSMutableArray *)R3NameArr {
	if(_R3NameArr == nil) {
		_R3NameArr = [[NSMutableArray alloc] init];
	}
	return _R3NameArr;
}

- (NSMutableArray *)R4NameArr {
	if(_R4NameArr == nil) {
		_R4NameArr = [[NSMutableArray alloc] init];
	}
	return _R4NameArr;
}

- (NSMutableArray *)R5NameArr {
	if(_R5NameArr == nil) {
		_R5NameArr = [[NSMutableArray alloc] init];
	}
	return _R5NameArr;
}

- (NSMutableArray *)R6NameArr {
	if(_R6NameArr == nil) {
		_R6NameArr = [[NSMutableArray alloc] init];
	}
	return _R6NameArr;
}

- (NSMutableArray *)R7NameArr {
	if(_R7NameArr == nil) {
		_R7NameArr = [[NSMutableArray alloc] init];
	}
	return _R7NameArr;
}

- (NSMutableArray *)R8NameArr {
	if(_R8NameArr == nil) {
		_R8NameArr = [[NSMutableArray alloc] init];
	}
	return _R8NameArr;
}

- (NSMutableArray *)R9NameArr {
	if(_R9NameArr == nil) {
		_R9NameArr = [[NSMutableArray alloc] init];
	}
	return _R9NameArr;
}

- (NSMutableArray *)R0NameArr {
	if(_R0NameArr == nil) {
		_R0NameArr = [[NSMutableArray alloc] init];
	}
	return _R0NameArr;
}

- (NSMutableArray *)RANameArr {
	if(_RANameArr == nil) {
		_RANameArr = [[NSMutableArray alloc] init];
	}
	return _RANameArr;
}

- (NSMutableArray *)RBNameArr {
	if(_RBNameArr == nil) {
		_RBNameArr = [[NSMutableArray alloc] init];
	}
	return _RBNameArr;
}

- (NSMutableArray *)R0FyArr {
	if(_R0FyArr == nil) {
		_R0FyArr = [[NSMutableArray alloc] init];
	}
	return _R0FyArr;
}

- (NSMutableArray *)R1FyArr {
	if(_R1FyArr == nil) {
		_R1FyArr = [[NSMutableArray alloc] init];
	}
	return _R1FyArr;
}

- (NSMutableArray *)R2FyArr {
	if(_R2FyArr == nil) {
		_R2FyArr = [[NSMutableArray alloc] init];
	}
	return _R2FyArr;
}

- (NSMutableArray *)R3FyArr {
	if(_R3FyArr == nil) {
		_R3FyArr = [[NSMutableArray alloc] init];
	}
	return _R3FyArr;
}

- (NSMutableArray *)R4FyArr {
	if(_R4FyArr == nil) {
		_R4FyArr = [[NSMutableArray alloc] init];
	}
	return _R4FyArr;
}

- (NSMutableArray *)R5FyArr {
	if(_R5FyArr == nil) {
		_R5FyArr = [[NSMutableArray alloc] init];
	}
	return _R5FyArr;
}

- (NSMutableArray *)R6FyArr {
	if(_R6FyArr == nil) {
		_R6FyArr = [[NSMutableArray alloc] init];
	}
	return _R6FyArr;
}

- (NSMutableArray *)R7FyArr {
	if(_R7FyArr == nil) {
		_R7FyArr = [[NSMutableArray alloc] init];
	}
	return _R7FyArr;
}

- (NSMutableArray *)R8FyArr {
	if(_R8FyArr == nil) {
		_R8FyArr = [[NSMutableArray alloc] init];
	}
	return _R8FyArr;
}

- (NSMutableArray *)R9FyArr {
	if(_R9FyArr == nil) {
		_R9FyArr = [[NSMutableArray alloc] init];
	}
	return _R9FyArr;
}

- (NSMutableArray *)RAFyArr {
	if(_RAFyArr == nil) {
		_RAFyArr = [[NSMutableArray alloc] init];
	}
	return _RAFyArr;
}

- (NSMutableArray *)RBFyArr {
	if(_RBFyArr == nil) {
		_RBFyArr = [[NSMutableArray alloc] init];
	}
	return _RBFyArr;
}

@end
