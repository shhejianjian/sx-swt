//
//  SWTSSCLDHViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSSCLDHViewController.h"
#import "STAlertView.h"

@interface SWTSSCLDHViewController ()
@property (strong, nonatomic) IBOutlet UIButton *pastBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIButton *ajxzBtn;
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (nonatomic, assign) int index;
@end

@implementation SWTSSCLDHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.nextBtn setTitle:@"\uf2ee" forState:UIControlStateNormal];
    self.pastBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.pastBtn setTitle:@"\uf2ea" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 5;
    self.pastBtn.layer.cornerRadius = 5;
    self.ajxzBtn.layer.cornerRadius = 5;

    self.pastBtn.hidden = YES;
    self.index = 1;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)nextBtnClick:(UIButton *)sender {
//    if (self.index == 1) {
//        self.showImg.image = [UIImage imageNamed:@"图2"];
//        self.noteLabel.text = @"二、进入安检门，法警进行安检，出示相应的证件以及传票（比如：身份证，或者律师证），通过安检门来到立案大厅；";
//        self.index = 2;
//        self.pastBtn.hidden = NO;
//        self.ajxzBtn.hidden = NO;
//
//        return;
//    }
//    if (self.index == 2) {
//        self.showImg.image = [UIImage imageNamed:@"图3"];
//        self.noteLabel.text = @"三、到达立案大厅，在“查询咨询”窗口询问工作人员；";
//        self.index = 3;
//        self.ajxzBtn.hidden = YES;
//
//        self.pastBtn.hidden = NO;
//        return;
//    }
    if (self.index == 1) {
        self.showImg.image = [UIImage imageNamed:@"图4"];
        self.noteLabel.text = @"根据工作人员的指引到达诉讼服务窗口，进行登记并且提供和上交各项所需材料；";
        self.index = 2;
        self.pastBtn.hidden = NO;
        self.nextBtn.hidden = YES;

        return;
    }
    
}
- (IBAction)pastBtnClick:(id)sender {
//    if (self.index == 4) {
//        self.showImg.image = [UIImage imageNamed:@"图3"];
//        self.noteLabel.text = @"三、到达立案大厅，在“查询咨询”窗口询问工作人员；";
//        self.index = 3;
//        self.pastBtn.hidden = NO;
//        self.ajxzBtn.hidden = YES;
//        self.nextBtn.hidden = NO;
//        return;
//    }
//    if (self.index == 3) {
//        self.showImg.image = [UIImage imageNamed:@"图2"];
//        self.noteLabel.text = @"二、进入安检门，法警进行安检，出示相应的证件以及传票（比如：身份证，或者律师证），通过安检门来到立案大厅；";
//        self.index = 2;
//        self.pastBtn.hidden = NO;
//        self.ajxzBtn.hidden = NO;
//
//        return;
//    }
    if (self.index == 2) {
        self.showImg.image = [UIImage imageNamed:@"图3"];
        self.noteLabel.text = @"到达立案大厅，在“查询咨询”窗口询问工作人员；";
        self.index = 1;
        self.pastBtn.hidden = YES;
        self.nextBtn.hidden = NO;
        return;
    }
    
}

- (IBAction)zslcBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"材料转收流程" image:nil message:@"材料转收流程是指接受本院正在审理或执行中的案件诉讼材料，并将当事人提交的诉讼材料转交承办法官。\n1、当事人填写《诉讼材料收转清单》（一式两份）。\n2、立案大庭工作人员对当事人提交的材料名称、数量等进行核对无误后，在接受人处签字，并加盖诉讼材料接收专用章加以确认，盖章后的《诉讼材料收转清单》当事人留存。\n3、如果当事人提供的诉状和材料不全或不符合要求的，立案庭工作人员应该列举材料补充清单，并出具一次性书面告知书，在指定期限内补正或补齐材料。\n4、立案大庭工作人员应在3个工作日内，通知到相关业务庭法官、书记员或内勤领取材料，并由领取人在另一份《诉讼材料收转清单》的领取人处签字，由立案信访大厅接待人员保存备查。" buttonTitles:nil];
    alert.hideWhenTapOutside = YES;
    [alert show:YES];
}

- (IBAction)ajxzBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"安检须知" image:nil message:@"根据最高人民法院关于《人民法院司法警察安全检查规则》的有关精神，对进入我院综合楼、审判楼的人员一律实行安全检查（执行职务的公检法人员及律师按相关规定执行）。现将有关事宜告知如下：\n1、凡需进入我院综合楼、审判楼的人员，请自觉出示身份证及有效证件经由安检门检验通过后，方能进入。\n2、通过安检门前，请自觉将随身携带的金属物品（诸如钥匙、手机、手表、打火机等）交由安检柜台，再在安检门内稍站一下通过。当安检门发出警报声后，由安检法警手持探测器进行检测，直到安检法警准予通过时，方能进入综合楼、审判楼。\n3、对易燃、易爆、易腐蚀等危险物品、枪支弹药、管制刀具及其他金属利器等安检法警认为可能具有安全隐患的物品，安检法警将分别依法作出收缴或拒绝通过的处理。\n4、凡摄影、摄像录音等新闻采访工具，非经本院有关部门特许，一律不得通过安检。如需要，可将物品寄存在储物柜，人员经安检门检验通过后，方能进入综合楼、审判楼。\n5、小型提包、提袋等随身携带小件，请携带者自行打开接受安检。大包、大袋等物品不得通过安检。但如需要（经开包安检后），视安检柜台的存入情况决定可否寄存。\n6、无证件、伪造、冒用他人证件的人；未成年人；精神病人和醉酒的人；拒绝接受安检或不听从安检人员安排人的人；其他可能妨害法庭审判秩序的人，不得通过安检进入综合楼、审判楼。\n7、凡货币、金银饰品、有价证券或其他贵重物品，不准寄存。如寄存人在包裹里夹带寄存以上物品造成任何损失或损坏的，皆由寄存人负责。\n8、领取寄存物品时，由寄存人当柜认领，离柜后责任自负。当日不领取寄存物品的，本院将依法处理。" buttonTitles:nil];
    alert.hideWhenTapOutside = YES;
    [alert show:YES];
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
