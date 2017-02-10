//
//  SWTPlayVideoViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/19.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTPlayVideoViewController.h"
#import "XSMediaPlayer.h"

//#import "WMPlayer.h"
//#define TheUserDefaults [NSUserDefaults standardUserDefaults]
//
//#define kHistoryTime @"HistoryTime"
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

@interface SWTPlayVideoViewController ()
//<WMPlayerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
//@property (strong, nonatomic) IBOutlet WMPlayer *wmPlayer;
@property(nonatomic,retain)XSMediaPlayer *player;

@end

@implementation SWTPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    _player = [[XSMediaPlayer alloc]initWithFrame:CGRectMake(0, 150,SCREEN_WIDTH, 250)];
        _player.videoURL = [NSURL fileURLWithPath:self.videoPath];
//    _player.videoURL = [NSURL URLWithString:@"http://f01.v1.cn/group2/M00/01/62/ChQB0FWBQ3SAU8dNJsBOwWrZwRc350-m.mp4"];
    [self.view addSubview:_player];

    
//    if ([TheUserDefaults doubleForKey:kHistoryTime]) {//如果有存上次播放的时间点记录，直接跳到上次纪录时间点播放
//        double time = [TheUserDefaults doubleForKey:kHistoryTime];
//        self.wmPlayer.seekTime = time;
//    }
//
//    [self.wmPlayer setURLString:@"http://baobab.wdjcdn.com/1455782903700jy.mp4"];
//    self.wmPlayer.delegate = self;
//    self.wmPlayer.closeBtn.hidden = YES;
//    [self.view addSubview:self.wmPlayer];
//    [self.wmPlayer play];

    // Do any additional setup after loading the view from its nib.
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view.backgroundColor = [UIColor blackColor];
    }
}
// 哪些页面支持自动转屏
- (BOOL)shouldAutorotate{
    return YES;
}

// viewcontroller支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    // MoviePlayerViewController这个页面支持转屏方向
    return UIInterfaceOrientationMaskAllButUpsideDown;
    
}
//- (void)releaseWMPlayer
//{
//    [self.wmPlayer.player.currentItem cancelPendingSeeks];
//    [self.wmPlayer.player.currentItem.asset cancelLoading];
//    [self.wmPlayer pause];
//    
//    
//    [self.wmPlayer removeFromSuperview];
//    [self.wmPlayer.playerLayer removeFromSuperlayer];
//    [self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
//    self.wmPlayer.player = nil;
//    self.wmPlayer.currentItem = nil;
//    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
//    [self.wmPlayer.autoDismissTimer invalidate];
//    self.wmPlayer.autoDismissTimer = nil;
//    
//    
//    self.wmPlayer.playOrPauseBtn = nil;
//    self.wmPlayer.playerLayer = nil;
//    self.wmPlayer = nil;
//}
//- (void)dealloc
//{
//    double time = [self.wmPlayer currentTime];
//    [TheUserDefaults setDouble:time forKey:kHistoryTime];
//    NSLog(@"TestViewController dealloc");
//    [self releaseWMPlayer];
//    
//}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.wmPlayer resetWMPlayer];
//    [super touchesBegan:touches withEvent:event];
//    [self.wmPlayer setURLString:self.videoPath];
//    [self.wmPlayer play];
//    
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
//    
//}
//-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
//    NSLog(@"didSingleTaped");
//}
//-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
//    NSLog(@"didDoubleTaped");
//}
//
/////播放状态
//-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
//    NSLog(@"wmplayerDidFailedPlay");
//}
//-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
//    NSLog(@"wmplayerDidReadyToPlay");
//    
//}
////播放完毕的代理方法
//-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
//    NSLog(@"wmplayerFinishedPlay");
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
