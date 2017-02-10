//
//  SWTMainViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/26.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTMainViewController.h"
#import "SWTFyTypeViewController.h"
#import "SWTNewsViewController.h"
#import "NSString+Times.h"
#import "SWTTopData.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTSubNews.h"
#import "MJExtension.h"
#import "XKScrollView.h"
#import "SWTSPGKMainViewController.h"
#import "SWTRXMainViewController.h"
#import "SWTZXZXMainViewController.h"
#import "SWTswdhMainViewController.h"
#import "CZZCarouselView.h"
#import "SWTAJLBViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "SWTLoadFileViewController.h"
#import "SWTNewsLunBo.h"
#import "SWTSubNewsViewController.h"
#import "SWTPlayVideoViewController.h"
#import "SWTChooseMapViewController.h"
#import "SWTLAJFViewController.h"
#import "SWTFYGSMainViewController.h"
#import "SWTWeiBoViewController.h"
#import "SWTWeiXingViewController.h"



@interface SWTMainViewController ()<CZZCarouselViewDelegate>
@property (nonatomic,strong)CZZCarouselView *carouselView;
@property (strong, nonatomic) IBOutlet UIButton *spgkBtn;
@property (strong, nonatomic) IBOutlet UIButton *ssrxBtn;
@property (strong, nonatomic) IBOutlet UIButton *swdhBtn;
@property (strong, nonatomic) IBOutlet UIButton *zxrxBtn;
@property (strong, nonatomic) IBOutlet UIButton *wslaBtn;
@property (strong, nonatomic) IBOutlet UIButton *xwzxBtn;

@property (strong, nonatomic) IBOutlet UIButton *chooseMapBtn;

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *ImageArr;
@property (nonatomic, strong) NSMutableArray *IDArr;
@end



@implementation SWTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewsTitleAndImage];
    self.tabBarController.tabBar.tintColor = SWTRedColor;
    self.chooseMapBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:20];
    [self.chooseMapBtn setTitle:@"\uf1ab" forState:UIControlStateNormal];
        // Do any additional setup after loading the view from its nib.
}



//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (void)loadNewsTitleAndImage {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [SWTHttpTool post:GetNewsLunboUrl params:params success:^(id json) {
        NSArray *arr = [SWTNewsLunBo mj_objectArrayWithKeyValuesArray:json];
        for (SWTNewsLunBo *newsLunBo in arr) {
            [self.titleArr addObject:newsLunBo.title];
            [self.ImageArr addObject:newsLunBo.imgpath];
            [self.IDArr addObject:newsLunBo];
        }
        self.carouselView = [CZZCarouselView carouselViewWithImageArray:self.ImageArr describeArray:self.titleArr];
        //  设置frame
        self.carouselView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200);
        
//          用代理处理点击图片事件，如果两个方法都实现，block优先级高于代理
            self.carouselView.delegate = self;
        
        //  设置每张图片的停留时间
        _carouselView.time = 2;
        
        //  设置分页控件的图片，不设置则为系统默认
        [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
        
        //  设置分页控制的位置，默认为PositionBottomCenter
        _carouselView.pagePosition = PositionBottomCenter;
        
        /**
         *  设置图片描述控件
         */
        //  设置背景颜色，默认为黑色半透明
        _carouselView.desLabelBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        //  设置字体，默认为13号字
        _carouselView.desLabelFont = [UIFont systemFontOfSize:14];
        //  设置文字颜色，默认为白色
        _carouselView.desLabelColor = [UIColor whiteColor];
        _carouselView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_carouselView];

        NSLog(@"++%@",json);
    } failure:^(NSError *error) {
        NSLog(@"--%@",error);
    }];
}

- (void)carouselView:(CZZCarouselView *)carouselView didClickImage:(NSInteger)index {
    SWTNewsLunBo *newsLBModel =  self.IDArr[index];
    SWTSubNewsViewController *subNewsVC = [[SWTSubNewsViewController alloc]init];
    [subNewsVC setHidesBottomBarWhenPushed:YES];
    subNewsVC.mainLbModel = newsLBModel;
    [self.navigationController pushViewController:subNewsVC animated:YES];
}




- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    NSString *courtNameIDStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
    NSLog(@"++====%@",courtNameIDStr);

}

- (IBAction)jumpToNewsCenter:(id)sender {
    SWTNewsViewController *newsCenterVC = [[SWTNewsViewController alloc]init];
    [newsCenterVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:newsCenterVC animated:YES];
}
- (IBAction)jumpToSPGK:(id)sender {
    SWTSPGKMainViewController *spgkVC = [[SWTSPGKMainViewController alloc]init];
    [spgkVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:spgkVC animated:YES];
}
- (IBAction)jumpToSSRX:(id)sender {
    SWTRXMainViewController *ssrxVC = [[SWTRXMainViewController alloc]init];
    [ssrxVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ssrxVC animated:YES];
}
- (IBAction)jumpToSPCX:(id)sender {
    SWTAJLBViewController *wslaVC = [[SWTAJLBViewController alloc]init];
    [wslaVC setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:wslaVC animated:YES];
    
}
- (IBAction)jumpToZXRX:(id)sender {
    SWTZXZXMainViewController *zxzxVC = [[SWTZXZXMainViewController alloc]init];
    [zxzxVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:zxzxVC animated:YES];
}
- (IBAction)jumpToSWDH:(id)sender {
    
//    SWTLAJFViewController
    SWTLAJFViewController *swdhVC = [[SWTLAJFViewController alloc]init];
    [swdhVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:swdhVC animated:YES];
//    SWTswdhMainViewController *swdhVC = [[SWTswdhMainViewController alloc]init];
//    [swdhVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:swdhVC animated:YES];
}


- (IBAction)chooseMapBtnClick:(id)sender {
    SWTChooseMapViewController *chooseMapVC = [[SWTChooseMapViewController alloc]init];
    [chooseMapVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chooseMapVC animated:YES];
}



- (IBAction)fygsBtnClick:(id)sender {
    SWTFYGSMainViewController *sfwtVC = [[SWTFYGSMainViewController alloc]init];
    [sfwtVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:sfwtVC animated:YES];
}
- (IBAction)gfwbBtnClick:(id)sender {
    SWTWeiBoViewController *weiboVC = [[SWTWeiBoViewController alloc]init];
    [weiboVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:weiboVC animated:YES];
}
- (IBAction)gfwxBtnClick:(id)sender {
    SWTWeiXingViewController *weiXinVC = [[SWTWeiXingViewController alloc]init];
    [weiXinVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:weiXinVC animated:YES];
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

- (NSMutableArray *)titleArr {
	if(_titleArr == nil) {
		_titleArr = [[NSMutableArray alloc] init];
	}
	return _titleArr;
}

- (NSMutableArray *)ImageArr {
	if(_ImageArr == nil) {
		_ImageArr = [[NSMutableArray alloc] init];
	}
	return _ImageArr;
}



- (NSMutableArray *)IDArr {
	if(_IDArr == nil) {
		_IDArr = [[NSMutableArray alloc] init];
	}
	return _IDArr;
}

@end
