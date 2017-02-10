//
//  SWTUploadCLViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/28.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTUploadCLViewController.h"
#import "NIDropDown.h"
#import "takePhoto.h"
#import "SWTConst.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "SVProgressHUD.h"
#import "LDActionSheet.h"
#import "LDImagePicker.h"
@interface SWTUploadCLViewController ()<NIDropDownDelegate,LDActionSheetDelegate,LDImagePickerDelegate>
@property (nonatomic, strong) NIDropDown *dropDown;
@property (strong, nonatomic) IBOutlet UIImageView *showImg;
@property (strong, nonatomic) IBOutlet UITextField *fileNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *cllxBtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SWTUploadCLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)chooseCLType:(id)sender {
    NSArray *arr = @[@"诉讼状",@"原告身份证明材料",@"被告身份证明材料",@"证据材料",@"证据材料清单",@"授权委托书",@"地址确认书",@"法定代表人身份证明",@"受托人身份材料"];
    if(self.dropDown == nil) {
        CGFloat f = 240;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    self.dropDown = nil;
}

- (IBAction)chooseFile:(id)sender {
    LDActionSheet *actionSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"相册", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
    imagePicker.delegate = self;
    [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
}
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    self.showImg.image = editedImage;
}
- (IBAction)uploadSuccessAndBack:(id)sender {
    
    if ([self.cllxBtn.titleLabel.text isEqualToString:@"请选择材料类型"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择材料类型"];
        return;
    }
    if (self.fileNameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }
    if (self.showImg.image) {
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",self.fileNameTextField.text];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
        params[@"loginname"] = [userDefault objectForKey:@"apploginname"];
        params[@"outusername"] = [userDefault objectForKey:@"name"];
        params[@"flag"] = @1;
        params[@"file"] = [UIImageJPEGRepresentation(self.showImg.image, 0) base64EncodedDataWithOptions:0];
        params[@"mlmc"] = self.cllxBtn.titleLabel.text;
        params[@"filename"] = fileName;
        params[@"ylainfoid"] = self.uploadYlaInfoId;
        
        NSError *playerError = nil;
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        NSMutableURLRequest *request =
        [serializer multipartFormRequestWithMethod:@"POST"//请求方法为post
                                         URLString:UploadUrl//上传文件URL
                                        parameters:params//上传的其他参数
                         constructingBodyWithBlock:^(id<AFMultipartFormData> formData)//设置请求体
         {
             [formData appendPartWithFileData:[UIImageJPEGRepresentation(self.showImg.image, 0) base64EncodedDataWithOptions:0]//音乐媒体文件的data对象
                                         name:@"file"//与数据关联的参数名称，不能为nil
                                     fileName:fileName//上传的文件名，不能为nil
                                     mimeType:@"image/jpg"];
         } error:&playerError];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestOperation *operation =
        [manager HTTPRequestOperationWithRequest:request
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             NSLog(@"Success %@", responseObject);//上传成功后的语句块
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             [SVProgressHUD showErrorWithStatus:@"上传失败"];

                                             NSLog(@"Failure %@", error.description);//上传失败的语句块
                                         }];
        [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                            long long totalBytesWritten,//已上传的字节数
                                            long long totalBytesExpectedToWrite)//总字节数
         {
             double f =  ((double)totalBytesWritten / totalBytesExpectedToWrite);
             [SVProgressHUD showProgress:f status:@"上传中" maskType:SVProgressHUDMaskTypeBlack];
             if (f >= 1.000000) {
                 self.showImg.image = nil;
                 self.fileNameTextField.text = @"";
                 [SVProgressHUD showSuccessWithStatus:@"上传成功"];
             }
         }];
        [operation start];

        
        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript",@"text/plain",nil];
//        [manager POST:UploadUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.showImg.image, 0) name:@"file" fileName:fileName mimeType:@"image/jpg"];
//            NSLog(@"%@",self.showImg.image);
//        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"%@",responseObject);
//            NSError *error = nil;
//            NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                                         options:NSJSONReadingMutableContainers
//                                                                           error:&error];
//            NSLog(@"%@",responseData);
//            [self.navigationController popViewControllerAnimated:YES];
//            [MBProgressHUD showSuccess:@"上传成功"];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD showError:@"网络连接错误"];
//            NSLog(@"Error: %@", error);
//        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请选择要上传的文件"];

    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
