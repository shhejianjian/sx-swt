//
//  SWTxiansuoViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTxiansuoViewController.h"
#import "SWTZXZXMainViewController.h"
#import "SWTConst.h"
@interface SWTxiansuoViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation SWTxiansuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *ID=@"xiansuoCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]init];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"提供线索";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"信访投诉";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"法律咨询";
    }
    cell.backgroundColor = SWTGlobalColor;

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  44;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(didSelectXianSuo:atIndexPath:)]) {
        [self.delegate didSelectXianSuo:tableView atIndexPath:indexPath];
    }
    
    
    
    
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

@end
