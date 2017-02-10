//
//  XTTextField.m
//  LocationDemo
//
//  Created by xietao on 15/2/6.
//  Copyright (c) 2015年 xietao. All rights reserved.
//

#import "XTTextField.h"

const NSInteger kGaryViewTag = 98102;

@interface XTTextField ()


@end

@implementation XTTextField

- (id)initWithDelegate:(id<XTTextFieldDelegate>)delegate{
    self = [[[NSBundle mainBundle] loadNibNamed:@"XTTextField" owner:self options:nil] objectAtIndex:0];
    
    if (self) {
        self.delegate = delegate;
        self.textView.layer.cornerRadius = 10;
        self.textView.delegate = self;
        self.cancelEditButton.layer.cornerRadius=8;
        self.finishEditButton.layer.cornerRadius = 8;
        self.finishEditButton.layer.masksToBounds = YES;
      
        UIViewController *vc = (UIViewController*)self.delegate;
        [vc.view addSubview:self];
        // 约束宽度 与superview宽度一致
        [vc.view addConstraint:[NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        // 加入位置约束
        _keyboardHeightConstraint = [NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        [vc.view addConstraint:_keyboardHeightConstraint];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    self.textView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    self.textView.delegate = nil;
}

- (IBAction)cancelAction:(id)sender {
    [self.textView resignFirstResponder];
    [self setBgViewShow:NO andHeight:-self.frame.size.height];
}

- (IBAction)finishEditAction:(id)sender {
    if ( self.finishAction ) {
        self.finishAction(self.textView.text);
    }
    [self.textView resignFirstResponder];
    [self setBgViewShow:NO andHeight:-self.frame.size.height];

    self.textView.text = nil;
    self.previewLabel.hidden = NO;
    self.finishEditButton.enabled = NO;
}

- (void)becomeFirstResponder{
    [self.textView becomeFirstResponder];
}
/**
 *  设置输入框位置
 *
 *  @param isShow 是否显示
 *  @param height 弹起高度
 */

- (void)setBgViewShow:(BOOL)isShow andHeight:(float)height{
    if (isShow) {
        self.hidden = NO;
        UIControl *garyView = (UIControl *)[self.superview viewWithTag:kGaryViewTag];
        if ( !garyView ) {
            garyView = [[UIControl alloc]initWithFrame:self.superview.bounds];
            [garyView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
            [garyView setTag:kGaryViewTag];
            [garyView addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventTouchUpInside];
            [self.superview addSubview:garyView];
            [self.superview insertSubview:garyView belowSubview:self];
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            // 位置约束 弹出高度=键盘高度+自身高度
            _keyboardHeightConstraint.constant = height+self.frame.size.height;
            [self.superview setTranslatesAutoresizingMaskIntoConstraints:YES];
            [self.superview layoutIfNeeded];
        }completion:^(BOOL finished) {
        }];
        
    }else{
        for (UIView *subview in self.superview.subviews) {
            if ( subview.tag == kGaryViewTag ) {
                [subview removeFromSuperview];
            }
        }
        // 位置约束 回到底部
        [UIView animateWithDuration:0.3 animations:^{
            _keyboardHeightConstraint.constant = 0;
            [self.superview setTranslatesAutoresizingMaskIntoConstraints:YES];
            [self.superview layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}
- (void)endEditing
{
    [self.textView resignFirstResponder];
    [self setBgViewShow:NO andHeight:-self.frame.size.height];


}
#pragma mark - NSNotificationCenter
- (void)keyboardWillShown:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    [self setBgViewShow:YES andHeight:keyboardSize.height];
    if ([self.delegate respondsToSelector:@selector(xtTextFieldWillBeginEditing:)]) {
        [self.delegate xtTextFieldWillBeginEditing:self.textView];
    }
}

- (void)keyboardWillHidden:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    // 隐藏输入框
    [self setBgViewShow:NO andHeight:keyboardSize.height];
    if ([self.delegate respondsToSelector:@selector(xtTextFieldWillEndEditing:)]) {
        [self.delegate xtTextFieldWillEndEditing:self.textView];
    }
}


#pragma mark - UITextViewDelegate
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSLog(@"text%@",text);
//    // 获取textFiled中得内容
//    NSMutableString *goalStr = [[NSMutableString alloc]initWithString:textView.text];
//    [goalStr replaceCharactersInRange:range withString:text];
//    if ( goalStr.length == 0 ){
//        self.finishEditButton.enabled = NO;
//        self.previewLabel.hidden = NO;
//    }
//    else{
//        self.finishEditButton.enabled = YES;
//        self.previewLabel.hidden = YES;
//    }
//    return YES;
//}
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length != 0) {
        self.previewLabel.hidden = YES;
        self.finishEditButton.enabled = YES;
    }else{
        self.previewLabel.hidden = NO;
        self.finishEditButton.enabled = NO;
    }
 }


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    NSLog(@"%@",textView.text);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"%@",textField.text);
}
@end
