//
//  SWTAddInfoViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTAddInfoViewController.h"
#import "SWTRXMainViewController.h"

#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface SWTAddInfoViewController () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *nrzyTextView;
@property (strong, nonatomic) IBOutlet UILabel *preViewLabel;
@property (strong, nonatomic) IBOutlet UITextField *ldhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *xbTextField;
@property (strong, nonatomic) IBOutlet UITextField *zyTextField;
@property (strong, nonatomic) IBOutlet UITextField *whcdTextField;
@property (strong, nonatomic) IBOutlet UITextField *jjdzTextField;
@property (strong, nonatomic) IBOutlet UITextField *ageTextField;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tjBtnTopConstraint;

@end


@implementation SWTAddInfoViewController

- (void)viewDidLoad {
    self.nrzyTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.nrzyTextView.layer.borderWidth = 1;
    [super viewDidLoad];
    if (ScreenHeight == 568) {
        self.tjBtnTopConstraint.constant = 5;
    } else {
        self.tjBtnTopConstraint.constant = 25;
    }
    self.nrzyTextView.delegate = self;
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"123" object:nil];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)notice:(id)sender{
    self.nrzyTextView.text = @"";
    self.ldhmTextField.text = @"";
    self.xbTextField.text = @"";
    self.zyTextField.text = @"";
    self.whcdTextField.text = @"";
    self.jjdzTextField.text = @"";
    self.ageTextField.text = @"";
}

- (IBAction)TjBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectWithLdhmStr:andXbStr:andAgeStr:andZyStr:andWhcdStr:andJjdzStr:andNrzyStr:)]) {
        [self.delegate didSelectWithLdhmStr:self.ldhmTextField.text andXbStr:self.xbTextField.text andAgeStr:self.ageTextField.text andZyStr:self.zyTextField.text andWhcdStr:self.whcdTextField.text andJjdzStr:self.jjdzTextField.text andNrzyStr:self.nrzyTextView.text];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.nrzyTextView.text.length != 0) {
        self.preViewLabel.hidden = YES;
    }else{
        self.preViewLabel.hidden = NO;
    }
    if (self.nrzyTextView.text.length != 0) {
        self.preViewLabel.hidden = YES;
    }else{
        self.preViewLabel.hidden = NO;
    }
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
