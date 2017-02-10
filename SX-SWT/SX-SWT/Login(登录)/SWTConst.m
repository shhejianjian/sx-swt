//
//  SWTConst.m
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <Foundation/Foundation.h>

//154.0.66.149:8080
NSString *const BaseUrl = @"http://192.16.137.1:8080/swt";
NSString *const ImageUrl = @"http://192.16.137.1:8080/swt/newinfo/getshowimg?imgpath=/swt_new/&imgnewname=";
NSString *const FyNewsImageUrl = @"http://192.16.137.1:8080";

NSString *const NewsTableUrl = @"newinfo/appNewsInfo";
//新闻内容
NSString *const NewsContentUrl = @"newinfo/appNewsFjById";
//获取立案列表
NSString *const GetAJInfoUrl = @"yla/appGetYlaList";
//获取文书送达列表
NSString *const GetWSSDInfoUrl = @"sdzxyw/getDzsdList";
//通过案件标识获取预立案信息
NSString *const getYlaByAjbsUrl = @"yla/getYlaByAjbs";
//通过案件id获取当事人信息
NSString *const getYlaDsrByYlaId = @"yla/appGetYlaDsrList";
//删除诉讼材料
NSString *const DelSsclUrl = @"yla/appDelYlaSscl";
//删除当事人信息
NSString *const DeleteYlaDsrByIdUrl = @"yla/appDelYlaDsr";
//获取新闻栏目列表
NSString *const GetNewsColumListUrl = @"column/getColumnList";
//保存或修改当事人信息
NSString *const SaveOrChangeDSRInfoUrl = @"yla/appSaveYlaDsr";
//保存或修改预立案信息
NSString *const SaveOrChangeYlaInfoUrl = @"yla/appSaveYlaInfo";
//删除预立案信息
NSString *const DeleteYlaInfoUrl = @"yla/appDelYlaInfo";
//上传文件
NSString *const UploadUrl = @"http://192.16.137.1:8080/swt/yla/uploadSscl";
////下载文件
//NSString *const DownLoadFileUrl = @"http://154.0.66.149:8080/swt/sdzxyw/downWsCheckByAjbs";
//下载文件时判断签名码是否对应
NSString *const checkDownWsByAjbs = @"sdzxyw/downWsCheckByAjbs";
////下载文件
NSString *const DownLoadFileUrl = @"http://1.85.16.50:9001/sdzx/sdzxController/downWsByApp?zjh=610126199008206315&signature_code=e8bb2829";
//获取诉讼材料列表
NSString *const GetSsclListUrl = @"yla/appGetYlaSsclList";
//获取文书送达详情
NSString *const GetWSSDDetailInfoUrl = @"spajxx/getAjjbxxByAjbs";
//获取文书送达当事人详情
NSString *const GetWSSDDsrDetailInfoUrl = @"spajxx/getAjdsrByAjbs";
//获取文书送达审判程序详情
NSString *const GetWSSDSpcxDetailInfoUrl = @"spajxx/getAjspzzByAjbs";
//用户登录
NSString *const LoginUrl = @"zxxs/outUserLogin";
//用户注册
NSString *const RegistUrl = @"usermanager/appRegister";
//用户修改密码
NSString *const ChangePwdUrl = @"usermanager/appUserUpdatePwd";
//登陆获取文书列表
NSString *const LoginToGetWsListUrl = @"sdzxyw/getSdzxywByDsr";
//庭审公告查询获取列表
NSString *const GetTsggListUrl = @"tsgg/getTsggList";
//审判查询列表
NSString *const GetSpcxListUrl = @"spajxx/getAjjbxxList";
//判断当事人id和密码
NSString *const GetAjDsrByUserUrl = @"spajxx/getAjdsrByUser";
//获取信访列表
NSString *const GetXFTSListUrl = @"xfinfo/appGetXfList";
//信访图片上传
NSString *const UploadXFImageUrl = @"http://192.16.137.1:8080/swt/xfinfo/uploadXfImg";
//新增生成信访信息uuid或修改时给信访id赋值
NSString *const GetXFUUIDUrl = @"xfinfo/getXfInfoUUID";
//保存信访信息
NSString *const SaveXFInfoUrl = @"xfinfo/appSaveXfInfo";
//删除信访图片
NSString *const DeleteXFImgUrl = @"xfinfo/delXfImg";
//删除信访信息
NSString *const DeleteXFInfoUrl = @"xfinfo/delXfInfo";
//获取信访信息和信访图片附件
NSString *const GetXFInfoAndImgUrl = @"xfinfo/appGetXfFjList";
//信访图片显示
NSString *const GetXFShowImgUrl = @"xfinfo/getshowimg";
//获取新闻轮播信息
NSString *const GetNewsLunboUrl = @"newinfo/appNewsLunBo";
//保存线索信息
NSString *const SaveXsInfoUrl = @"zxxs/appSaveXsInfo";
//执行线索上传附件
NSString *const UpLoadXsFjUrl = @"http://192.16.137.1:8080/swt/zxxs/appUploadxsfj";
//获取线索列表
NSString *const GetXsInfoListUrl = @"zxxs/appGetXsList";
//通过线索id获取线索附件列表
NSString *const GetXsFjListById = @"zxxs/appGetXsFjList";
//删除线索信息
NSString *const DeleteXsListInfoUrl = @"zxxs/delXs";
//删除线索附件
NSString *const DeleteXsFjUrl = @"zxxs/delXsfj";
//获取失信人员列表
NSString *const GetGsxxBgInfoListUrl = @"spajxx/getGsbgxxList";
//获取失信人员详情
NSString *const GetGsxxBgInfoDetail = @"spajxx/viewGsbgxxById";
//获取执行日志列表
NSString *const GetZxzxLogListUrl = @"zxzx/getZxzxlogList";
//诉讼信息录入
NSString *const SaveSsInfoUrl = @"ssinfo/saveSsInfo";
//获取诉讼咨询列表
NSString *const GetSszxListUrl = @"ssinfo/getSszxList";
//提交诉讼咨询问题
NSString *const PostSszxProblem = @"ssinfo/saveQuestion";
//获取法院简介
NSString *const GetFyxxUrl = @"fyxx/getFyxx";
