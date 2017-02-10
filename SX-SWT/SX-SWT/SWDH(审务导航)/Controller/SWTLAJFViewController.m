//
//  SWTLAJFViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/23.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTLAJFViewController.h"
#import "SWTDHImgViewController.h"
#import <MapKit/MapKit.h>
#import "FSRotatingCamera.h"
#import "SWTMainDHViewController.h"
#import "STAlertView.h"

#define DEFAULT_COORDINATE CLLocationCoordinate2DMake(34.19259129,108.96039605)
@interface SWTLAJFViewController ()<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UIButton *startOrStopRoate;

@property (nonatomic, strong) FSRotatingCamera *rotCamera;
@property (nonatomic, assign) BOOL rotating;


@end

@implementation SWTLAJFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.startOrStopRoate setTitle:@"Stop" forState:UIControlStateNormal];
    
    self.mapView.centerCoordinate = DEFAULT_COORDINATE;
    self.mapView.delegate = self;
    self.mapView.showsBuildings = YES;
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = DEFAULT_COORDINATE;
    annotationPoint.title = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
    [self.mapView addAnnotation:annotationPoint];
    
    self.rotCamera = [[FSRotatingCamera alloc] initWithMapView:self.mapView];
    [self.rotCamera startRotatingWithCoordinate:DEFAULT_COORDINATE];
    // Do any additional setup after loading the view from its nib.
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if ([self.rotCamera isStopped] == NO) {
        [self.rotCamera continueRotating];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)startDh:(id)sender {
    SWTMainDHViewController *dhImgVC = [[SWTMainDHViewController alloc]init];
    [self.navigationController pushViewController:dhImgVC animated:YES];
}
- (IBAction)startStopAction:(id)sender {
    if ([self.startOrStopRoate.titleLabel.text isEqualToString:@"Start"] == YES) {
        [self.startOrStopRoate setTitle:@"Stop" forState:UIControlStateNormal];
        [self.rotCamera startRotatingWithCoordinate:DEFAULT_COORDINATE];
    } else {
        [self.startOrStopRoate setTitle:@"Start" forState:UIControlStateNormal];
        [self.rotCamera stopRotating];
    }
}
- (IBAction)gjlxBtnClick:(id)sender {
    STAlertView *alert = [[STAlertView alloc] initWithTitle:@"公交路线" image:nil message:@"1、乘坐地铁2号线到达会展中心站，步行110米后到达公交161路国展中心站上车:乘坐公交161路到西安建设大厦站(3站，车程约7分钟)下车后步行约300米即可到达。\n2、公交242路，500路:乘坐公交242路，500路到水厂路站下车后步行约360米即可到达。" buttonTitles:nil];
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
