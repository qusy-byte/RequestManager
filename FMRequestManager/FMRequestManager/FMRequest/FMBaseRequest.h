//
//  FMBaseRequest.h
//  FMRequestManager
//
//  Created by Jadyn_Qu on 2018/6/11.
//  Copyright © 2018年 Jadyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMRequestManager.h"
#import "FMBaseModel.h"

typedef NS_ENUM(NSInteger,FMRequestType) {
    FMRequestTypeGet = 0,    // get请求
    FMRequestTypePost,      // post请求
    FMRequestTypePut    // put请求
};

/**
 请求成功回调
 
 @param responseModel 请求返回数据
 */
typedef void(^FMRequestSuccess)(FMBaseModel * responseModel);

/**
 请求完成（非成功回调）

 @param responseCode 响应码
 @param responseMessage 消息提示
 */
typedef void(^FMRequestComplection)(NSInteger responseCode,NSString *responseMessage);
/**
 请求失败

 @param responseError 失败原因
 */
typedef void(^FMRequestFailer)(NSError *responseError);


@interface FMBaseRequest : NSObject

/**
 请求url
 */
@property (nonatomic,copy) NSString *urlString;

/**
 请求参数
 */
@property (nonatomic,copy) NSDictionary *parames;

/**
 请求参数类型
 */
@property (nonatomic,assign) FMRequestSeializerType requestSeialzier;

/**
 请求返回结果解析类型
 */
@property (nonatomic,assign) FMResponseSeializerType responseSeialzier;

/**
 请求方式
 */
@property (nonatomic,assign) FMRequestType requestType;

/** 构造方法 */
+ (instancetype)fm_request;
+ (instancetype)fm_requestWithUrl:(NSString *)urlString;
+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType;
+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType requestSeializerType:(FMRequestSeializerType)requestSeializer;
+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType responseSeializerType:(FMResponseSeializerType)responseSeializer;
+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType requestSeializerType:(FMRequestSeializerType)requestSeializer responseSeializerType:(FMResponseSeializerType)responseSeializer;

/** 发送请求 */
- (void)fm_sendRequest;
- (void)fm_sendRequestWithComplection:(FMRequestComplection)complection failer:(FMRequestFailer)failer;
- (void)fm_sendRequestWithSuccess:(FMRequestSuccess)success complection:(FMRequestComplection)complection failer:(FMRequestFailer)failer;

/** 取消当前请求 */
- (void)cancelCurrentRequest;

@end







