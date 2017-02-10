//
//  SWTSFWTViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSFWTViewController.h"
#import "SWTSfwtCell.h"
#import "SWTJPRecordViewController.h"
#import "SWTapplyQuoteViewController.h"
static NSString *ID=@"sfwtCell";


@interface SWTSFWTViewController () <SWTSfwtCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *sfwtTableView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTSFWTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.sfwtTableView registerNib:[UINib nibWithNibName:@"SWTSfwtCell" bundle:nil] forCellReuseIdentifier:ID];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jumpToNext:(id)sender {
    SWTJPRecordViewController *jpVC = [[SWTJPRecordViewController alloc]init];
    [self.navigationController pushViewController:jpVC animated:YES];
}




#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 5;
    
}


- (SWTSfwtCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTSfwtCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[SWTSfwtCell alloc]init];
        
    }
    cell.delegate = self;
    cell.isSuccessLabel.hidden = YES;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 130;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (void)didSelect:(SWTSfwtCell *)cell atIndexPath:(NSInteger)index {
    SWTapplyQuoteViewController *applyQuoteVC = [[SWTapplyQuoteViewController alloc]init];
    [self.navigationController pushViewController:applyQuoteVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
