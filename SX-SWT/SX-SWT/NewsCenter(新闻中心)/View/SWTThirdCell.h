//
//  SWTThirdCell.h
//  SX-SWT
//
//  Created by 何键键 on 16/8/16.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTSubNews.h"

@interface SWTThirdCell : UITableViewCell
@property (nonatomic, strong) SWTSubNews *subNewsModel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIWebView *contentWebView;
@property (nonatomic, assign) CGFloat cellHeight;

@end
