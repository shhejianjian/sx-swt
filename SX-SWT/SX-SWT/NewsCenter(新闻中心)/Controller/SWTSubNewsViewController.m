//
//  SWTSubNewsViewController.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import "SWTSubNewsViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SWTHttpTool.h"
#import "SWTConst.h"
#import "SWTSubNews.h"
#import "UIImageView+WebCache.h"
#import "SWTMainNews.h"
#import "SWTSubNewTitleCell.h"
#import "SWTSecondCell.h"
#import "SWTThirdCell.h"
#import "SVProgressHUD.h"
//#import "UIView+WHC_AutoLayout.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "SWTLoadFileViewController.h"
#import "SWTPlayVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "XWScanImage.h"
#import "SWTPlayVoiceViewController.h"



static NSString *ID1=@"SWTSubNewTitleCell";
static NSString *ID2=@"SWTSecondCell";
static NSString *ID3=@"SWTThirdCell";


@interface SWTSubNewsViewController () <AVAudioPlayerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) SWTSubNews *subNewsForContent;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *ImgArr;
@property (nonatomic, copy) NSString *filePath;

@end

@implementation SWTSubNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewsContent];
    self.navigationController.navigationBarHidden = YES;
//    self.backBtn.titleLabel.font = [UIFont fontWithName:@"Material-Design-Iconic-Font" size:25];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
     [self.myTableView registerNib:[UINib nibWithNibName:@"SWTSubNewTitleCell" bundle:nil] forCellReuseIdentifier:ID1];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTSecondCell" bundle:nil] forCellReuseIdentifier:ID2];
    [self.myTableView registerNib:[UINib nibWithNibName:@"SWTThirdCell" bundle:nil] forCellReuseIdentifier:ID3];
    
}

- (void)loadNewsContent {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    params[@"outuserid"] = [userDefault objectForKey:@"loginId"];
    
    params[@"outusername"] = [userDefault objectForKey:@"name"];
    
    params[@"flag"] = @1;
    if (self.mainLbModel) {
        params[@"id"] = self.mainLbModel.id;
        params[@"columncode"] = @"fyxw";
    } else {
        params[@"id"] = _NewsModel.infoid;
        params[@"columncode"] = _NewsModel.column_code;
    }
    [SVProgressHUD showWithStatus:@"正在加载"];

    [SWTHttpTool post:NewsContentUrl params:params success:^(id json) {
        self.subNewsForContent = [SWTSubNews mj_objectWithKeyValues:json[@"newsinfo"]];
        self.ImgArr = [SWTSubNews mj_objectArrayWithKeyValuesArray:json[@"fjlist"]];
        
        for (SWTSubNews *subnew in self.ImgArr) {
            NSLog(@"subnew:%@--%@--%@",subnew.path,subnew.save_name,subnew.news_id);
        }
        
        [SVProgressHUD dismiss];
        
        [self.myTableView reloadData];
        NSLog(@"%@==%@",json,params);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.mainLbModel = nil;
    self.NewsModel = nil;
    [SVProgressHUD dismiss];

}
#pragma mark - tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        
        return self.ImgArr.count;
        
    } else if ( section == 2) {
        return 1;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        SWTSubNewTitleCell *firstCell = [self.myTableView dequeueReusableCellWithIdentifier:ID1];
        firstCell.subNewsModel = self.subNewsForContent;
        cell = firstCell;
    } else if (indexPath.section == 1) {
        
        
        SWTSecondCell *secondCell = [self.myTableView dequeueReusableCellWithIdentifier:ID2];
        secondCell.subNewsModel = self.ImgArr[indexPath.row];
        
        if ([self.subNewsForContent.column_name isEqualToString:@"通知公告"]) {
            secondCell.newsInfoModel = self.subNewsForContent;
        }
        NSLog(@"0000-%@",self.subNewsForContent.column_name);
        cell = secondCell;
        
        
    } else if (indexPath.section == 2) {

        SWTThirdCell *thirdCell = [self.myTableView dequeueReusableCellWithIdentifier:ID3];
        thirdCell.subNewsModel = self.subNewsForContent;
            thirdCell.contentLabel.hidden = YES;
            thirdCell.contentWebView.hidden = NO;
            NSString *str =[NSString stringWithFormat:@"<html><body>%@</body></html>",self.subNewsForContent.content];
            [thirdCell.contentWebView loadHTMLString:str baseURL:nil];
            thirdCell.contentWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
            thirdCell.contentWebView.multipleTouchEnabled=YES;
            thirdCell.contentWebView.userInteractionEnabled=YES;
        cell = thirdCell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 0) {
        return 200;
//        return [SWTSubNewTitleCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
    } else if (indexPath.section ==1) {
        SWTSubNews *subnew = self.ImgArr[indexPath.row];
        if ([subnew.save_name isEqualToString:@""] || [subnew.save_name isEqualToString:@"null"]) {
            return 0;
        } else {
            return 300;
//            return [SWTSecondCell whc_CellHeightForIndexPath:indexPath tableView:tableView]+20;
        }
    } else if (indexPath.section == 2) {
        SWTThirdCell *cell = (SWTThirdCell *)[self tableView:self.myTableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
    return 0;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    SWTSecondCell *cell = (SWTSecondCell *)[self tableView:self.myTableView cellForRowAtIndexPath:indexPath];
    // 获取Documents路径
    // [patchs objectAtIndex:0]
    NSString *documentsDirectory = [patchs objectAtIndex:0];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory error:nil];
    SWTSubNews *subnews = self.ImgArr[indexPath.row];

    if (indexPath.section == 0) {
        NSLog(@"头部");
    } else if (indexPath.section == 1) {
        
        
        if ([self.subNewsForContent.column_name isEqualToString:@"法院新闻"] || [self.subNewsForContent.column_name isEqualToString:@"通知公告"]) {
            
            if ([files containsObject:subnews.save_name]) {
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                long long fileSize = [self fileSizeAtPath:_filePath];
                if (fileSize > 0) {
                    SWTLoadFileViewController *loafFileVC = [[SWTLoadFileViewController alloc]init];
                    loafFileVC.path = _filePath;
                    [self.navigationController pushViewController:loafFileVC animated:YES];
                } else {
                    [SVProgressHUD showWithStatus:@"正在加载"];
                    //初始化队列
                    NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                    //下载地址
                    NSURL *url = nil;
                    NSString *str = [NSString stringWithFormat:@"%@/inContentRemind/downloadFile?attachmentpath=%@&attachmentname=%@&outuserid=%@&outusername=%@&flag=1",BaseUrl,subnews.path,subnews.save_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                    NSLog(@"str:%@",str);
                    url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                    NSString *rootPath = [self dirDoc];
                    _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                    NSLog(@"++--++--%@",_filePath);
                    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                    NSLog(@"url:%@",url);
                    op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"下载成功");
                        [SVProgressHUD dismiss];
                        SWTLoadFileViewController *loafFileVC = [[SWTLoadFileViewController alloc]init];
                        loafFileVC.path = _filePath;
                        [self.navigationController pushViewController:loafFileVC animated:YES];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"下载失败:%@--%@",operation,error);
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
                    }];
                    //开始下载
                    [queue addOperation:op];
                }
            } else {
                [SVProgressHUD showWithStatus:@"正在加载"];
                //初始化队列
                NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                //下载地址
                NSURL *url = nil;
                NSString *str = [NSString stringWithFormat:@"%@/inContentRemind/downloadFile?attachmentpath=%@&attachmentname=%@&outuserid=%@&outusername=%@&flag=1",BaseUrl,subnews.path,subnews.save_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                NSLog(@"++--++--%@",_filePath);
                AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"下载成功");
                    [SVProgressHUD dismiss];
                    SWTLoadFileViewController *loafFileVC = [[SWTLoadFileViewController alloc]init];
                    loafFileVC.path = _filePath;
                    [self.navigationController pushViewController:loafFileVC animated:YES];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"下载失败:%@--%@",operation,error);
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"网络连接错误"];

                }];
                //开始下载
                [queue addOperation:op];
            }
            
        } else {
        
        
        if ([subnews.fj_type isEqualToString:@"0"]) {
            
//            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
//            [cell.showImg addGestureRecognizer:tapGestureRecognizer1];
//            //让UIImageView和它的父类开启用户交互属性
//            [cell.showImg setUserInteractionEnabled:YES];
            if (cell.showImg.image) {
                [XWScanImage scanBigImageWithImageView:cell.showImg];
            }

            NSLog(@"picture");
        } else if ([subnews.fj_type isEqualToString:@"1"]) {
            
            if ([files containsObject:subnews.save_name]) {
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                long long fileSize = [self fileSizeAtPath:_filePath];
                if (fileSize > 0) {
                    SWTLoadFileViewController *loafFileVC = [[SWTLoadFileViewController alloc]init];
                    loafFileVC.path = _filePath;
                    [self.navigationController pushViewController:loafFileVC animated:YES];
                } else {
                    [SVProgressHUD showWithStatus:@"正在加载"];
                    //初始化队列
                    NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                    //下载地址
                    NSURL *url = nil;
                    if ([self.subNewsForContent.column_name isEqualToString:@"法院新闻"] || [self.subNewsForContent.column_name isEqualToString:@"通知公告"]) {
                        NSString *str = [NSString stringWithFormat:@"%@/inContentRemind/downloadFile?attachmentpath=%@&attachmentname=%@&outuserid=%@&outusername=%@&flag=1",BaseUrl,subnews.path,subnews.save_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                        url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                    } else {
                        NSString *str = [NSString stringWithFormat:@"%@/newinfo/downloadNewFj?path=%@&fjnewname=%@&fjrowname=%@&flag=1&outuserid=%@&outusername=%@",BaseUrl,subnews.path,subnews.save_name,subnews.raw_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                        url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    }
                    NSString *rootPath = [self dirDoc];
                    _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                    NSLog(@"++--++--%@",_filePath);
                    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                    op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"下载成功");
                        [SVProgressHUD dismiss];
                        SWTLoadFileViewController *loafFileVC = [[SWTLoadFileViewController alloc]init];
                        loafFileVC.path = _filePath;
                        [self.navigationController pushViewController:loafFileVC animated:YES];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"下载失败:%@--%@",operation,error);
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];

                    }];
                    //开始下载
                    [queue addOperation:op];
                }
                
            } else {
                [SVProgressHUD showWithStatus:@"正在加载"];
                //初始化队列
                NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                //下载地址
                NSURL *url = nil;
                if ([self.subNewsForContent.column_name isEqualToString:@"法院新闻"] || [self.subNewsForContent.column_name isEqualToString:@"通知公告"]) {
                    NSString *str = [NSString stringWithFormat:@"%@/inContentRemind/downloadFile?attachmentpath=%@&attachmentname=%@&outuserid=%@&outusername=%@&flag=1",BaseUrl,subnews.path,subnews.save_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                    url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                } else {
                    NSString *str = [NSString stringWithFormat:@"%@/newinfo/downloadNewFj?path=%@&fjnewname=%@&fjrowname=%@&flag=1&outuserid=%@&outusername=%@",BaseUrl,subnews.path,subnews.save_name,subnews.raw_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                    url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                }
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                NSLog(@"++--++--%@",_filePath);
                AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"下载成功");
                    [SVProgressHUD dismiss];
                    SWTLoadFileViewController *loafFileVC = [[SWTLoadFileViewController alloc]init];
                    loafFileVC.path = _filePath;
                    [self.navigationController pushViewController:loafFileVC animated:YES];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"下载失败:%@--%@",operation,error);
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"网络连接错误"];

                }];
                //开始下载
                [queue addOperation:op];
            }
            
            
        } else if ([subnews.fj_type isEqualToString:@"2"]) {
            
            if ([files containsObject:subnews.save_name]) {
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                long long fileSize = [self fileSizeAtPath:_filePath];
                if (fileSize > 0) {
                    SWTPlayVideoViewController *playVideoVC = [[SWTPlayVideoViewController alloc]init];
                    playVideoVC.videoPath = _filePath;
                    [self.navigationController pushViewController:playVideoVC animated:YES];
                } else {
                    [SVProgressHUD showWithStatus:@"正在加载"];
                    
                    //初始化队列
                    NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                    //下载地址
                    NSURL *url = nil;
                    NSString *str = [NSString stringWithFormat:@"%@/newinfo/downloadNewFj?path=%@&fjnewname=%@&fjrowname=%@&flag=1&outuserid=%@&outusername=%@",BaseUrl,subnews.path,subnews.save_name,subnews.raw_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                    url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                    NSString *rootPath = [self dirDoc];
                    _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                    NSLog(@"++--++--%@",_filePath);
                    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                    op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"下载成功");
                        [SVProgressHUD dismiss];
                        SWTPlayVideoViewController *playVideoVC = [[SWTPlayVideoViewController alloc]init];
                        playVideoVC.videoPath = _filePath;
                        [self.navigationController pushViewController:playVideoVC animated:YES];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"下载失败:%@--%@",operation,error);
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];

                    }];
                    //开始下载
                    [queue addOperation:op];
                }
                
            } else {
                [SVProgressHUD showWithStatus:@"正在加载"];
                
                //初始化队列
                NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                //下载地址
                NSURL *url = nil;
                NSString *str = [NSString stringWithFormat:@"%@/newinfo/downloadNewFj?path=%@&fjnewname=%@&fjrowname=%@&flag=1&outuserid=%@&outusername=%@",BaseUrl,subnews.path,subnews.save_name,subnews.raw_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                NSLog(@"++--++--%@",_filePath);
                AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"下载成功");
                    [SVProgressHUD dismiss];
                    SWTPlayVideoViewController *playVideoVC = [[SWTPlayVideoViewController alloc]init];
                    playVideoVC.videoPath = _filePath;
                    [self.navigationController pushViewController:playVideoVC animated:YES];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"下载失败:%@--%@",operation,error);
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"网络连接错误"];

                }];
                //开始下载
                [queue addOperation:op];
            }
        } else if ([subnews.fj_type isEqualToString:@"3"]) {
            if ([files containsObject:subnews.save_name]) {
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                long long fileSize = [self fileSizeAtPath:_filePath];
                if (fileSize > 0) {
                    SWTPlayVoiceViewController *playVocieVC = [[SWTPlayVoiceViewController alloc]init];
                    playVocieVC.myFilePath = _filePath;
                    playVocieVC.subNewsModel = subnews;
                    [self.navigationController pushViewController:playVocieVC animated:YES];
                } else {
                    [SVProgressHUD showWithStatus:@"正在加载"];
                    //初始化队列
                    NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                    //下载地址
                    NSURL *url = nil;
                    NSString *str = [NSString stringWithFormat:@"%@/newinfo/downloadNewFj?path=%@&fjnewname=%@&fjrowname=%@&flag=1&outuserid=%@&outusername=%@",BaseUrl,subnews.path,subnews.save_name,subnews.raw_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                    url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                    NSString *rootPath = [self dirDoc];
                    _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                    NSLog(@"++--++--%@",_filePath);
                    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                    op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"下载成功");
                        [SVProgressHUD dismiss];
                        
                        SWTPlayVoiceViewController *playVocieVC = [[SWTPlayVoiceViewController alloc]init];
                        playVocieVC.myFilePath = _filePath;
                        playVocieVC.subNewsModel = subnews;
                        [self.navigationController pushViewController:playVocieVC animated:YES];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"下载失败:%@--%@",operation,error);
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];

                    }];
                    //开始下载
                    [queue addOperation:op];
                }
            } else {
                [SVProgressHUD showWithStatus:@"正在加载"];
                //初始化队列
                NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
                //下载地址
                NSURL *url = nil;
                NSString *str = [NSString stringWithFormat:@"%@/newinfo/downloadNewFj?path=%@&fjnewname=%@&fjrowname=%@&flag=1&outuserid=%@&outusername=%@",BaseUrl,subnews.path,subnews.save_name,subnews.raw_name,[userDefault objectForKey:@"loginId"],[userDefault objectForKey:@"name"]];
                url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",subnews.save_name]];
                NSLog(@"++--++--%@",_filePath);
                AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
                op.outputStream = [NSOutputStream outputStreamToFileAtPath:_filePath append:NO];
                [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"下载成功");
                    [SVProgressHUD dismiss];
                    
                    SWTPlayVoiceViewController *playVocieVC = [[SWTPlayVoiceViewController alloc]init];
                    playVocieVC.myFilePath = _filePath;
                    playVocieVC.subNewsModel = subnews;
                    [self.navigationController pushViewController:playVocieVC animated:YES];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"下载失败:%@--%@",operation,error);
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"网络连接错误"];

                }];
                //开始下载
                [queue addOperation:op];
            }
        }

    }
        
    } else if (indexPath.section == 2) {
        NSLog(@"文本");
    }
    
}

//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

-(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)covertToDateStringFromString:(NSString *)Str
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[[Str substringWithRange:NSMakeRange(6, 13)]longLongValue]/1000.0];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [dateFormatter stringFromDate:date];
}
- (NSMutableArray *)titleArr {
	if(_titleArr == nil) {
		_titleArr = [[NSMutableArray alloc] init];
	}
	return _titleArr;
}

- (NSMutableArray *)ImgArr {
	if(_ImgArr == nil) {
		_ImgArr = [[NSMutableArray alloc] init];
	}
	return _ImgArr;
}


@end
