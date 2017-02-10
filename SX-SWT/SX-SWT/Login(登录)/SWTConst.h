//
//  SWTConst.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SWTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SWTGrayColor SWTColor(175, 175, 175)
#define SWTRedColor SWTColor(98, 9, 15)
#define SWTGlobalColor SWTColor(239, 235, 238)



//根目录地址
extern NSString *const BaseUrl;
//图片根地址
extern NSString *const ImageUrl;
extern NSString *const FyNewsImageUrl;
//新闻中心列表
extern NSString *const NewsTableUrl;
//新闻内容
extern NSString *const NewsContentUrl;
//获取立案列表
extern NSString *const GetAJInfoUrl;
//通过案件标识获取预立案和当事人信息
extern NSString *const getYlaByAjbsUrl;
//通过案件id获取当事人信息
extern NSString *const getYlaDsrByYlaId;
//删除当事人信息
extern NSString *const DeleteYlaDsrByIdUrl;
//保存或修改当事人信息
extern NSString *const SaveOrChangeDSRInfoUrl;
//保存或修改预立案信息
extern NSString *const SaveOrChangeYlaInfoUrl;
//删除预立案信息
extern NSString *const DeleteYlaInfoUrl;
//上传文件
extern NSString *const UploadUrl;
//下载文件时判断签名码是否对应
extern NSString *const checkDownWsByAjbs;
//下载文件
extern NSString *const DownLoadFileUrl;
//获取诉讼材料列表
extern NSString *const GetSsclListUrl;
//获取新闻栏目列表
extern NSString *const GetNewsColumListUrl;
//获取文书送达列表
extern NSString *const GetWSSDInfoUrl;
//获取文书送达详情
extern NSString *const GetWSSDDetailInfoUrl;
//获取文书送达当事人详情
extern NSString *const GetWSSDDsrDetailInfoUrl;
//获取文书送达审判程序详情
extern NSString *const GetWSSDSpcxDetailInfoUrl;
//用户登录
extern NSString *const LoginUrl;
//用户注册
extern NSString *const RegistUrl;
//用户修改密码
extern NSString *const ChangePwdUrl;
//登陆获取文书列表
extern NSString *const LoginToGetWsListUrl;
//庭审公告查询获取列表
extern NSString *const GetTsggListUrl;
//获取信访列表
extern NSString *const GetXFTSListUrl;
//信访图片上传
extern NSString *const UploadXFImageUrl;
//新增生成信访信息uuid或修改时给信访id赋值
extern NSString *const GetXFUUIDUrl;
//保存信访信息
extern NSString *const SaveXFInfoUrl;
//删除信访图片
extern NSString *const DeleteXFImgUrl;
//删除信访信息
extern NSString *const DeleteXFInfoUrl;
//获取信访信息和信访图片附件
extern NSString *const GetXFInfoAndImgUrl;
//信访图片显示
extern NSString *const GetXFShowImgUrl;
//获取新闻轮播信息
extern NSString *const GetNewsLunboUrl;
//审判查询列表
extern NSString *const GetSpcxListUrl;
//保存线索信息
extern NSString *const SaveXsInfoUrl;
//执行线索上传附件
extern NSString *const UpLoadXsFjUrl;
//获取线索列表
extern NSString *const GetXsInfoListUrl;
//获取失信人员列表
extern NSString *const GetGsxxBgInfoListUrl;
//获取失信人员详情
extern NSString *const GetGsxxBgInfoDetail;
//获取执行日志列表
extern NSString *const GetZxzxLogListUrl;
//诉讼信息录入
extern NSString *const SaveSsInfoUrl;
//判断当事人id和密码
extern NSString *const GetAjDsrByUserUrl;
//删除线索信息
extern NSString *const DeleteXsListInfoUrl;
//通过线索id获取线索附件列表
extern NSString *const GetXsFjListById;
//删除线索附件
extern NSString *const DeleteXsFjUrl;
//获取诉讼咨询列表
extern NSString *const GetSszxListUrl;
//提交诉讼咨询问题
extern NSString *const PostSszxProblem;
//删除诉讼材料
extern NSString *const DelSsclUrl;
//获取法院简介
extern NSString *const GetFyxxUrl;