//
//  SWTPlayVoiceViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/8/22.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTPlayVoiceViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+time.h"
#import "MZTimerLabel.h"
@interface SWTPlayVoiceViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (strong, nonatomic) IBOutlet UISlider *mySlider;
@property (strong, nonatomic) IBOutlet UILabel *currentLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
//播放
@property (nonatomic, strong)AVAudioPlayer *player;
@property (strong, nonatomic) IBOutlet UIImageView *roateImgView;

@end

@implementation SWTPlayVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.roateImgView.layer.cornerRadius = 100;
    self.roateImgView.layer.masksToBounds = YES;
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];

    NSError *playError;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.myFilePath] error:&playError];
    self.player.volume = 1;
    [self.player play];
    self.titleLabel.text = self.subNewsModel.raw_name;
    self.totalLabel.text = [NSString convertTime:self.player.duration];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateSliderValue) userInfo:nil repeats:YES];
    [self.mySlider setThumbImage:[UIImage imageNamed:@"Slider_控制点"] forState:UIControlStateNormal];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)myslider:(UISlider *)sender {
    [self.player setCurrentTime:sender.value*self.player.duration];

}
- (IBAction)playOrPauserBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([sender isSelected]) {
        [self.player pause];
    } else {
        [self.player play];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.player pause];
}

-(void)updateSliderValue
{
    self.mySlider.value = self.player.currentTime/self.player.duration;
    self.currentLabel.text = [self setCurrentTime:self.player.currentTime];

}
- (NSString *)setCurrentTime:(NSTimeInterval)currentTime {
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d", minute,second];
    return currentTimeStr;
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
