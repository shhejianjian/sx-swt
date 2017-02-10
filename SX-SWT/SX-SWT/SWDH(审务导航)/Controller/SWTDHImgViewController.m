//
//  SWTDHImgViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/23.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTDHImgViewController.h"
#import "STAlertView.h"

@interface SWTDHImgViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIButton *pastBtn;
@property (strong, nonatomic) IBOutlet UIButton *fgxImgClick;
@property (strong, nonatomic) IBOutlet UIButton *sjyBtn;

@property (strong, nonatomic) IBOutlet UIButton *ajxzBtn;


@property (nonatomic, assign) int index;

@end

@implementation SWTDHImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.nextBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.nextBtn setTitle:@"\uf2ee" forState:UIControlStateNormal];
    self.pastBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.pastBtn setTitle:@"\uf2ea" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 5;
    self.pastBtn.layer.cornerRadius = 5;
    self.fgxImgClick.layer.cornerRadius = 5;
    self.pastBtn.hidden = YES;
    self.index = 1;
    
    
}
- (IBAction)nextPictureClick:(UIButton *)sender {
    
        if (self.index == 1) {
            self.showImg.image = [UIImage imageNamed:@"图9"];
            self.noteLabel.text = @"当事人在书记员的引领下进入法庭";
            self.index = 2;
            self.pastBtn.hidden = NO;
            self.fgxImgClick.hidden = NO;
            self.sjyBtn.hidden = NO;
            self.nextBtn.hidden = YES;
            return;
        }
}


- (IBAction)pastBtnClick:(UIButton *)sender {
        if (self.index == 2) {
            self.showImg.image = [UIImage imageNamed:@"图6"];
            self.noteLabel.text = @"到达法庭门口后等待；";
            self.index = 1;
            self.pastBtn.hidden = NO;
            self.fgxImgClick.hidden = YES;
            self.sjyBtn.hidden = YES;
            self.nextBtn.hidden = NO;
            return;
        }
    if (self.index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}






- (IBAction)fgxBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"法馆席" image:nil message:@"合议庭是指人民法院审理案件时，由一定数量的审判人员，采用法定的形式所组成的审理案件的组织。" buttonTitles:nil];
    alert.hideWhenTapOutside = YES;
    [alert show:YES];
}

- (IBAction)ftzxBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"秩序流程" image:nil message:@"一、庭审流程：\n1、宣读法庭秩序，注意事项。\n2、原告宣读起诉书；\n3、被告针对原告起诉书做承认或者否认的答辩；\n4、法庭组织争议焦点；\n5、针对法庭组织的焦点来举证质证；\n6、双方就案件事实部分进行发问；\n7、法庭对原被告进行发问；\n8、法庭辩论；\n9、法庭组织调解，达成调解协议——》制作调解书，双方当事人签收后  生效；（向法院合议庭提出再审申请；当事人履行调解书内容或申请执行；）如果调解失败，就择日宣判。\n二、法庭秩序：\n1、未经许可不准录音录像和摄影；\n2、不得随意走动和进入审判区；\n3、不得鼓掌、喧哗、哭闹和实施其他妨害审判活动的行为；\n4、不得发言、提问；\n5、不准吸烟和随地吐痰；\n6、随时携带的移动电话、传呼机等通讯工具必须关闭或调到震动位置；\n7、对法庭的审判活动有意见，可以在闭馆以后以书面或者口头形式向人民法院提出；\n8、违反法庭纪律的，审判长可以当庭口头警告、训诫，也可以责令推出法庭；对严重扰乱法庭秩序的人，将依法追究刑事责任。民事庭依照《中华人民共和国民事诉讼法》的有关规定，对原告XX诉被告XX一案进行审理。本案合议庭由审判员XX、代理审判员XX、XX组成，由审判员XX担任审判长，由书记员ＸＸ担任记录。" buttonTitles:nil];
    alert.hideWhenTapOutside = YES;
    [alert show:YES];
}
- (IBAction)sjyBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"书记员" image:nil message:@"书记员是我国各级人民法院和人民检察院内担任办理案件的记录工作有关事项的人员。" buttonTitles:nil];
    alert.hideWhenTapOutside = YES;
    [alert show:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
