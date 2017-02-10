//
//  SWTDYNewsViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTDYNewsViewController.h"
#import "SWTNewsViewController.h"
#import "SWTDYNewsCell.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTNewsColum.h"
static NSString *ID=@"dyNewsCell";



@interface SWTDYNewsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *newsColumArr;
@end

@implementation SWTDYNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTDYNewsCell" bundle:nil] forCellReuseIdentifier:ID];
    [self getTitleArr];
    // Do any additional setup after loading the view from its nib.
}


- (void)getTitleArr {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"sate"] = @1;
    [SWTHttpTool get:GetNewsColumListUrl params:params success:^(id json) {
        self.newsColumArr = [SWTNewsColum mj_objectArrayWithKeyValuesArray:json[@"rows"]];
        [self.myTableView reloadData];
        NSLog(@"newsDY:%@",json);
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
//    return 4;
    return self.newsColumArr.count;
    
}


- (SWTDYNewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTDYNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTDYNewsCell alloc]init];
        
    }
    
    cell.newsColum = self.newsColumArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 60;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
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

- (NSMutableArray *)newsColumArr {
	if(_newsColumArr == nil) {
		_newsColumArr = [[NSMutableArray alloc] init];
	}
	return _newsColumArr;
}

@end
