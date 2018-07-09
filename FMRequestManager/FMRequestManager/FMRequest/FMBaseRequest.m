//
//  FMBaseRequest.m
//  FMRequestManager
//
//  Created by Jadyn_Qu on 2018/6/11.
//  Copyright © 2018年 Jadyn. All rights reserved.
//

#import "FMBaseRequest.h"
#import <MJExtension.h>

@interface FMBaseRequest ()

/**
 请求任务
 */
@property (nonatomic,strong) NSURLSessionDataTask *dataTask;

@end

@implementation FMBaseRequest

#pragma mark
#pragma mark --- 构造方法 ---
+ (instancetype)fm_request {
    return [[self alloc] init];
}

+ (instancetype)fm_requestWithUrl:(NSString *)urlString {
    return [self fm_requestWithUrl:urlString requestType:FMRequestTypeGet];
}

+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType {
    return [self fm_requestWithUrl:urlString requestType:requestType requestSeializerType:FMRequestSeializerTypeDefault responseSeializerType:FMResponseSeializerTypeDefault];
}

+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType requestSeializerType:(FMRequestSeializerType)requestSeializer {
    return [self fm_requestWithUrl:urlString requestType:requestType requestSeializerType:requestSeializer responseSeializerType:FMResponseSeializerTypeDefault];
}

+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType responseSeializerType:(FMResponseSeializerType)responseSeializer {
    return [self fm_requestWithUrl:urlString requestType:requestType requestSeializerType:FMRequestSeializerTypeDefault responseSeializerType:responseSeializer];
}

+ (instancetype)fm_requestWithUrl:(NSString *)urlString requestType:(FMRequestType)requestType requestSeializerType:(FMRequestSeializerType)requestSeializer responseSeializerType:(FMResponseSeializerType)responseSeializer {
    FMBaseRequest *request = [FMBaseRequest fm_request];
    request.urlString = urlString;
    request.requestType = requestType;
    request.requestSeialzier = requestSeializer;
    request.responseSeialzier = responseSeializer;
    return request;
}

#pragma mark
#pragma mark --- 发送请求 ---
- (void)fm_sendRequest {
    [self fm_sendRequestWithSuccess:nil complection:nil failer:nil];
}

- (void)fm_sendRequestWithComplection:(FMRequestComplection)complection failer:(FMRequestFailer)failer {
    [self fm_sendRequestWithSuccess:nil complection:complection failer:failer];
}

- (void)fm_sendRequestWithSuccess:(FMRequestSuccess)success complection:(FMRequestComplection)complection failer:(FMRequestFailer)failer {
    
    // 请求地址
    NSString *url = self.urlString;
    if (url.length == 0) {
        if (complection) {
            complection(-100,@"请检查地址或参数是否正确！");
        }
        return;
    };
    
    // 请求参数
    NSDictionary *parames = self.parames;
    if (!parames) {
        if (complection) {
            complection(-100,@"请检查地址或参数是否正确！");
        }
        return;
    };
    
    // 请求方式
    FMRequestType requestType = self.requestType;
    if (!requestType) requestType = FMRequestTypeGet;
    
    // 请求参数结构类型
    FMRequestSeializerType requestSeialzier = self.requestSeialzier;
    if (!requestSeialzier) requestSeialzier = FMRequestSeializerTypeDefault;
    
    // 返回数据解析类型
    FMResponseSeializerType responseSeialzier = self.responseSeialzier;
    if (!responseSeialzier) responseSeialzier = FMResponseSeializerTypeDefault;
    
    // 发送请求 默认get请求
    switch (requestType) {
        case FMRequestTypeGet:
            [self GET:url parames:parames requestSeializerType:requestSeialzier responseSeializerType:responseSeialzier success:success complection:complection failer:failer];
            break;
            
        case FMRequestTypePost:
            [self POST:url parames:parames requestSeializerType:requestSeialzier responseSeializerType:responseSeialzier success:success complection:complection failer:failer];
            break;
            
        case FMRequestTypePut:
            
            break;
            
        default:
            [self GET:url parames:parames requestSeializerType:requestSeialzier responseSeializerType:responseSeialzier success:success complection:complection failer:failer];
            break;
    }
}

#pragma mark
#pragma mark --- 请求 ---
- (void)GET:(NSString *)urlString parames:(id)parames requestSeializerType:(FMRequestSeializerType)requestType responseSeializerType:(FMResponseSeializerType)reponseType success:(FMRequestSuccess)success complection:(FMRequestComplection)complection failer:(FMRequestFailer)failer {
    
    self.dataTask = [FMRequestManager Get:urlString parames:parames requestSeializerType:requestType responseSeializerType:reponseType success:^(id responseObj) {
        
        // 默认解析方式为JSON 其他方式暂未处理
        if (reponseType == FMResponseSeializerTypeDefault || reponseType == FMResponseSeializerTypeJSON) {
            FMBaseModel *model = [FMBaseModel mj_objectWithKeyValues:responseObj];
            
            if (model.status == 0) {
                if (success) {
                    success(model);
                }
            }else {
                if (model.status == -10000) {
                    // 未登录处理
                }
                
                if (complection) {
                    complection(model.status,model.msg);
                }
            }
        }
        
    } failer:^(NSError *error) {
        if (failer) {
            if (error.code != -999) {
                failer(error);
            }
        }
    }];
    
}

- (void)POST:(NSString *)urlString parames:(id)parames requestSeializerType:(FMRequestSeializerType)requestType responseSeializerType:(FMResponseSeializerType)reponseType success:(FMRequestSuccess)success complection:(FMRequestComplection)complection failer:(FMRequestFailer)failer {
    
    self.dataTask = [FMRequestManager Post:urlString parames:parames requestSeializerType:requestType responseSeializerType:reponseType success:^(id responseObj) {
        // 默认解析方式为JSON 其他方式暂未处理
        if (reponseType == FMResponseSeializerTypeDefault || reponseType == FMResponseSeializerTypeJSON) {
            FMBaseModel *model = [FMBaseModel mj_objectWithKeyValues:responseObj];
            
            if (model.status == 0) {
                if (success) {
                    success(model);
                }
            }else {
                if (model.status == -10000) {
                    // 未登录处理
                }
                
                if (complection) {
                    complection(model.status,model.msg);
                }
            }
        }
    } failer:^(NSError *error) {
        if (failer) {
            if (error.code != -999) {
                failer(error);
            }
        }
    }];
}

- (void)cancelCurrentRequest {

    [self.dataTask cancel];
}


@end












