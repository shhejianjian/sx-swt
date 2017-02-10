//
//  XTTextField.h
//  LocationDemo
//
//  Created by xietao on 15/2/6.
//  Copyright (c) 2015年 xietao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTTextField;
@protocol XTTextFieldDelegate <NSObject>

@optional
- (void)xtTextFieldDidEndEditing:(UITextView *)textField;
- (void)xtTextFieldWillEndEditing:(UITextView *)textField;
- (void)xtTextFieldWillBeginEditing:(UITextView *)textField;

@end

@interface XTTextField : UIView<UITextViewDelegate>
{
    NSLayoutConstraint          *_keyboardHeightConstraint;     // 输入框高度约束
}
@property (assign, nonatomic) id <XTTextFieldDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *cancelEditButton;
@property (weak, nonatomic) IBOutlet UIView *textViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *previewLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *finishEditButton;
@property (copy, nonatomic) void (^finishAction)(NSString *);


/**
 *  初始化
 *
 *  @param delegate
 *
 *  @return self
 */
- (id)initWithDelegate:(id<XTTextFieldDelegate>)delegate;
/**
 *  设置输入框位置
 *
 *  @param isShow 是否显示
 *  @param height 弹起高度
 */
- (void)setBgViewShow:(BOOL)isShow andHeight:(float)height;
/**
 *  取消输入框第一响应
 */
- (void)becomeFirstResponder;
/**
 *  完成按钮事件
 *
 *  @param sender
 */
- (IBAction)finishEditAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;

@end
