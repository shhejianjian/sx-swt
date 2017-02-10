//
//  SWTFLYZDHViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTFLYZDHViewController.h"
#import "STAlertView.h"

@interface SWTFLYZDHViewController ()
@property (strong, nonatomic) IBOutlet UIButton *pastBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (strong, nonatomic) IBOutlet UIButton *ajxzBtn;
@property (nonatomic, assign) int index;
@end

@implementation SWTFLYZDHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.nextBtn setTitle:@"\uf2ee" forState:UIControlStateNormal];
    self.pastBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:45];
    [self.pastBtn setTitle:@"\uf2ea" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 5;
    self.pastBtn.layer.cornerRadius = 5;
    self.pastBtn.hidden = YES;
    self.index = 1;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)nextBtnClick:(UIButton *)sender {

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

    if (self.index == 2) {
        self.showImg.image = [UIImage imageNamed:@"图3"];
        self.noteLabel.text = @"到达立案大厅，在“查询咨询”窗口询问工作人员；";
        self.index = 1;
        self.pastBtn.hidden = YES;
        self.nextBtn.hidden = NO;

        return;
    }
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)yzlcBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"法律援助流程" image:nil message:@"一、民事、行政及非诉讼事项:\n  1)、当事人申请法律援助应提交的有关材料:\n    1、身份证原件、复印件。\n    2、经济困难证明。\n    3、残疾人证、失业证、低保证原件及复印件。\n    4、与案件有关的证据材料。\n    5、法律援助申请书。\n  2)、法律援助审查、审批:\n    1、当事人填写《法律援助申请表》。\n    2、援助受理工作人员进行审查。\n    3、中心负责人审批。\n    4、重大案件中心集体讨论，并报市司法局。\n  3)、法律援助受理:\n援助指派工作人员答复是否给予法律援助，并宣读《受授人须知》，指导当事人填写申请表格。\n二、刑事:\n  1)、法院指定援助案件:法院提交《指定辩护通知书》及《起诉书》或者一审判决书副本。\n  2)、法律援助审查、审批:援助指派工作人员对案件进行审查，不符合条件的，将退回法院，符合条件的案件填写相关表格，报中心负责人审批。\n①:法律援助指派:援助指派工作人员填写《法律援助指派通知书》，指派律师、法律服务工作者承办案件。\n②、案件办理及质量监督:承办律师展开法律援助工作，援助结案工作人员采取多种方式对案件进行质量监督。\n③、结案归档:办案人员将案卷材料援助结案工作人员审查，中心上报市司法局并按规定支付办案补助。" buttonTitles:nil];
    alert.hideWhenTapOutside = YES;
    [alert show:YES];
}

- (IBAction)ajxzBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"安检须知" image:nil message:@"根据最高人民法院关于《人民法院司法警察安全检查规则》的有关精神，对进入我院综合楼、审判楼的人员一律实行安全检查（执行职务的公检法人员及律师按相关规定执行）。现将有关事宜告知如下：\n1、凡需进入我院综合楼、审判楼的人员，请自觉出示身份证及有效证件经由安检门检验通过后，方能进入。\n2、通过安检门前，请自觉将随身携带的金属物品（诸如钥匙、手机、手表、打火机等）交由安检柜台，再在安检门内稍站一下通过。当安检门发出警报声后，由安检法警手持探测器进行检测，直到安检法警准予通过时，方能进入综合楼、审判楼。\n3、对易燃、易爆、易腐蚀等危险物品、枪支弹药、管制刀具及其他金属利器等安检法警认为可能具有安全隐患的物品，安检法警将分别依法作出收缴或拒绝通过的处理。\n4、凡摄影、摄像录音等新闻采访工具，非经本院有关部门特许，一律不得通过安检。如需要，可将物品寄存在储物柜，人员经安检门检验通过后，方能进入综合楼、审判楼。\n5、小型提包、提袋等随身携带小件，请携带者自行打开接受安检。大包、大袋等物品不得通过安检。但如需要（经开包安检后），视安检柜台的存入情况决定可否寄存。\n6、无证件、伪造、冒用他人证件的人；未成年人；精神病人和醉酒的人；拒绝接受安检或不听从安检人员安排人的人；其他可能妨害法庭审判秩序的人，不得通过安检进入综合楼、审判楼。\n7、凡货币、金银饰品、有价证券或其他贵重物品，不准寄存。如寄存人在包裹里夹带寄存以上物品造成任何损失或损坏的，皆由寄存人负责。\n8、领取寄存物品时，由寄存人当柜认领，离柜后责任自负。当日不领取寄存物品的，本院将依法处理。" buttonTitles:nil];
    alert.hideWhenTapOutside = YES;
    [alert show:YES];
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
