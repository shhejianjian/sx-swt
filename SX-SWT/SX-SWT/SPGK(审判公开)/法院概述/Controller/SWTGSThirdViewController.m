//
//  SWTGSThirdViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTGSThirdViewController.h"
#import "SWTLXFSCell.h"
//static NSString *ID=@"SWTLXFSCell";
#import <MapKit/MapKit.h>
#import "FSRotatingCamera.h"
#define DEFAULT_COORDINATE CLLocationCoordinate2DMake(34.19259129,108.96039605)

@interface SWTGSThirdViewController () <SWTLXFSCellDelegate,MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *fyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

//@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIButton *telNumberLabel;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) IBOutlet UIButton *stopOrStartBtn;
@property (nonatomic, strong) FSRotatingCamera *rotCamera;
@property (nonatomic, assign) BOOL rotating;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end

@implementation SWTGSThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.stopOrStartBtn setTitle:@"Stop" forState:UIControlStateNormal];
    
    self.fyNameLabel.text = [NSString stringWithFormat:@"法院名称：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"]];
    self.addressLabel.text = [NSString stringWithFormat:@"法院地址：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectFyAddress"]];
    [self.telNumberLabel setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectFyLxdh"] forState:UIControlStateNormal];
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            CLPlacemark *pl = [placemarks firstObject];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(pl.location.coordinate.latitude, pl.location.coordinate.longitude);
            
            NSLog(@"coordinate: %f,%f",coordinate.latitude,coordinate.longitude);
            
            self.coordinate = coordinate;
            self.myMapView.centerCoordinate = coordinate;
            self.myMapView.delegate = self;
            self.myMapView.showsBuildings = YES;
            
            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = coordinate;
            annotationPoint.title = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectCourtName"];
            [self.myMapView addAnnotation:annotationPoint];
            self.rotCamera = [[FSRotatingCamera alloc] initWithMapView:self.myMapView];
            [self.rotCamera startRotatingWithCoordinate:coordinate];
            
            NSLog(@"%f,%f",coordinate.latitude,coordinate.longitude);
            
//            CLLocation *cl = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//            [geocoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {
//                
//                
//                NSLog(@"placemarks:%@",placemarks);
//                
//                for (CLPlacemark *place in placemarks) {
//                    NSLog(@"name = %@",place.name);                                    //  位置名
//                    NSLog(@"thoroughfare = %@",place.thoroughfare);                    //  街道
//                    NSLog(@"subAdministrativeArea = %@",place.subAdministrativeArea);  //  子街道
//                    NSLog(@"locality = %@",place.locality);                            //  市
//                    NSLog(@"subLocality = %@",place.subLocality);                      //  区
//                    NSLog(@"country = %@",place.country);
////                    NSLog(@"所在城市====%@ %@ %@ %@", state, city, subLocality, street);
//                }
//            }];
            
        }else {
            NSLog(@"错误");
        }
        
    }];
    
//        CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];

    
}


-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if ([self.rotCamera isStopped] == NO) {
        [self.rotCamera continueRotating];
    }
}
- (IBAction)startStopAction:(id)sender {
    if ([self.stopOrStartBtn.titleLabel.text isEqualToString:@"Start"] == YES) {
        [self.stopOrStartBtn setTitle:@"Stop" forState:UIControlStateNormal];
        [self.rotCamera startRotatingWithCoordinate:self.coordinate];
    } else {
        [self.stopOrStartBtn setTitle:@"Start" forState:UIControlStateNormal];
        [self.rotCamera stopRotating];
    }
}

- (IBAction)callNumber:(id)sender {
    NSString *message = [NSString stringWithFormat:@"确认拨打此电话？Tel:%@",self.telNumberLabel.titleLabel.text];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.telNumberLabel.titleLabel.text]]];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


//#pragma mark - tableViewDelegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//
//{
//    
//    return 12;
//    
//}
//
//
//- (SWTLXFSCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    SWTLXFSCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (!cell) {
//        
//        cell=[[SWTLXFSCell alloc]init];
//        
//    }
//    cell.delegate = self;
//    if (indexPath.row == 0) {
//        cell.fymcLabel.text = @"法院名称：陕西省高级人民法院";
//        cell.fydzLabel.text = @"法院地址：西安市雁塔区雁塔五路80号";
//        [cell.lxdhBtn setTitle:@"029—85558715" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"sxgjrmfy"];
//    } else if (indexPath.row == 1) {
//        cell.fymcLabel.text = @"法院名称：西安市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：西安市未央区北二环东段139号";
//        [cell.lxdhBtn setTitle:@"029—87658306 " forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"xaszjrmfy"];
//    } else if (indexPath.row == 2) {
//        cell.fymcLabel.text = @"法院名称：铜川市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：陕西省铜川市王益区红旗街27号";
//        [cell.lxdhBtn setTitle:@"0919-3189633" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"tcszjrmfy"];
//    } else if (indexPath.row == 3) {
//        cell.fymcLabel.text = @"法院名称：宝鸡市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：陕西省宝鸡市中山西路57号";
//        [cell.lxdhBtn setTitle:@"0917-3653609" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"njszjrmfy"];
//    } else if (indexPath.row == 4) {
//        cell.fymcLabel.text = @"法院名称：咸阳市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：咸阳市渭阳西路54号";
//        [cell.lxdhBtn setTitle:@"029-33571429" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"xyszjrmfy"];
//    } else if (indexPath.row == 5) {
//        cell.fymcLabel.text = @"法院名称：渭南市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：陕西省渭南市东风街西段8号（高新技术开发区）";
//        [cell.lxdhBtn setTitle:@"0913—2117550" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"渭南市"];
//    } else if (indexPath.row == 6) {
//        cell.fymcLabel.text = @"法院名称：汉中市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：陕西省汉中市汉台区西环路南段 ";
//        [cell.lxdhBtn setTitle:@"0916-2531119" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"汉中市"];
//    } else if (indexPath.row == 7) {
//        cell.fymcLabel.text = @"法院名称：安康市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：安康市兴安东路24号";
//        [cell.lxdhBtn setTitle:@"0915-3213500" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"安康市"];
//    } else if (indexPath.row == 8) {
//        cell.fymcLabel.text = @"法院名称：商洛市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：商洛市商州区金凤路5号";
//        [cell.lxdhBtn setTitle:@"0914—2386538" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"商洛市"];
//    } else if (indexPath.row == 9) {
//        cell.fymcLabel.text = @"法院名称：延安市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：延安市宝塔区南关街53号";
//        [cell.lxdhBtn setTitle:@"0911-2112762" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"延安市"];
//    } else if (indexPath.row == 10) {
//        cell.fymcLabel.text = @"法院名称：榆林市中级人民法院";
//        cell.fydzLabel.text = @"法院地址：榆林市湖滨南路5号";
//        [cell.lxdhBtn setTitle:@"0912-3233321" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"榆林市"];
//    } else if (indexPath.row == 11) {
//        cell.fymcLabel.text = @"法院名称：西安市铁路运输中级人民法院";
//        cell.fydzLabel.text = @"法院地址：西安市碑林区安东街9号";
//        [cell.lxdhBtn setTitle:@"029-83198088" forState:UIControlStateNormal];
//        cell.mapImg.image = [UIImage imageNamed:@"运输中院"];
//    }
//    
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 250;   
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//}


//- (void)didSelect:(SWTLXFSCell *)cell atIndexPath:(NSInteger)index {

//}



@end
