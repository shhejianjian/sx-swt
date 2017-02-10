//
//  SWTGSForthViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTGSForthViewController.h"
#import "SWTCsAndGfTableViewCell.h"


static NSString *ID=@"csAndGfCell";

@interface SWTGSForthViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation SWTGSForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTCsAndGfTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 10;
    
}


- (SWTCsAndGfTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SWTCsAndGfTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell=[[SWTCsAndGfTableViewCell alloc]init];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.timeLabel.hidden = YES;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"西安市自力建筑安装工程有限责任公司申请 西安市长安区人民法院错误执行国家赔偿案";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"杜娟诉宝鸡市人力资源和社会保障局 劳动管理工伤认定案";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"美国大陆管理有限公司诉陕西济生制药 有限公司公司解散纠纷管辖异议案";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"高喜民与郝治斌保证合同纠纷案";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"咸阳康美特陶瓷有限公司诉张宝莲 医疗保险待遇纠纷案";
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"朱健康诉张建敏、伊芝民 合伙份额转让合同纠纷案";
    } else if (indexPath.row == 6) {
        cell.titleLabel.text = @"王军红与王军伟、薛延红继承纠纷案";
    } else if (indexPath.row == 7) {
        cell.titleLabel.text = @"韩跟谋与董莹探望权纠纷案";
    } else if (indexPath.row == 8) {
        cell.titleLabel.text = @"阮鉴重大劳动安全事故案";
    } else if (indexPath.row == 9) {
        cell.titleLabel.text = @"黄炳伍绑架案";
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  60;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(didSelectForth:atIndexPath:)]) {
        [self.delegate didSelectForth:tableView atIndexPath:indexPath];
    }
    
    
//    SWTZxgfWebViewController *zxgfWebVC = [[SWTZxgfWebViewController alloc]init];
//    zxgfWebVC.index = indexPath.row;
//    [self.navigationController pushViewController:zxgfWebVC animated:YES];
    
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
