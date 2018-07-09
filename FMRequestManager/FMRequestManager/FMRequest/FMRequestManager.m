//
//  FMRequestManager.m
//  FMRequestManager
//
//  Created by Jadyn_Qu on 2018/6/11.
//  Copyright © 2018年 Jadyn. All rights reserved.
//

#import "FMRequestManager.h"
#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (Shared)

/**
 设置单例

 @return 请求管理类
 */
+ (instancetype)shareManager;

@end

@implementation AFHTTPSessionManager (Shared)

+ (instancetype)shareManager {
    static AFHTTPSessionManager * _requestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestManager = [AFHTTPSessionManager manager];
        _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return _requestManager;
}

@end

@interface FMRequestManager ()

@end

@implementation FMRequestManager

#pragma mark
#pragma mark --- 请求方法 ---
+ (NSURLSessionDataTask *)Get:(NSString *)urlString parames:(id)parames requestSeializerType:(FMRequestSeializerType)requestType responseSeializerType:(FMResponseSeializerType)reponseType success:(FMRequestManagerSuccess)requestSuccess failer:(FMRequestManagerFailer)requestFailer {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    
    // 设置请求类型
    if (requestType != FMRequestSeializerTypeDefault) {
        manager.requestSerializer = requestSearalizerWithSerilizerType(requestType);
    }
    
    // 设置返回数据解析类型
    if (reponseType != FMResponseSeializerTypeDefault && reponseType != FMResponseSeializerTypeJSON) {
        manager.responseSerializer = responseSearalizerWithSerilizerType(reponseType);
    }
    
    NSURLSessionDataTask *dataTask = [manager GET:urlString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailer) {
            requestFailer(error);
        }
    }];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)Post:(NSString *)urlString parames:(id)parames requestSeializerType:(FMRequestSeializerType)requestType responseSeializerType:(FMResponseSeializerType)reponseType success:(FMRequestManagerSuccess)requestSuccess failer:(FMRequestManagerFailer)requestFailer {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    
    // 设置请求类型
    if (requestType != FMRequestSeializerTypeDefault) {
        manager.requestSerializer = requestSearalizerWithSerilizerType(requestType);
    }
    
    // 设置返回数据解析类型
    if (reponseType != FMResponseSeializerTypeDefault && reponseType != FMResponseSeializerTypeJSON) {
        manager.responseSerializer = responseSearalizerWithSerilizerType(reponseType);
    }
    
    NSURLSessionDataTask *dataTask = [manager POST:urlString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailer) {
            requestFailer(error);
        }
    }];
    
    return dataTask;
}

#pragma mark
#pragma mark --- 请求、返回数据格式的类型设置 ---
AFHTTPRequestSerializer * requestSearalizerWithSerilizerType(FMRequestSeializerType requestType) {
    switch (requestType) {
        case FMRequestSeializerTypeDefault:
            return [AFHTTPRequestSerializer serializer];
            break;
            
        case FMRequestSeializerTypeJSON:
            return [AFJSONRequestSerializer serializer];
            break;
            
        case FMRequestSeializerTypeData:
            return [AFHTTPRequestSerializer serializer];
            break;
            
        case FMRequestSeializerTypePlist:
            return [AFPropertyListRequestSerializer serializer];
            break;
            
        default:
            return [AFHTTPRequestSerializer serializer];
            break;
    }
}

AFHTTPResponseSerializer * responseSearalizerWithSerilizerType(FMResponseSeializerType responseType) {
    switch (responseType) {
        case FMResponseSeializerTypeDefault:
            return [AFJSONResponseSerializer serializer];
            break;
            
        case FMResponseSeializerTypeJSON:
            return [AFJSONResponseSerializer serializer];
            break;
            
        case FMResponseSeializerTypeData:
            return [AFHTTPResponseSerializer serializer];
            break;

        case FMResponseSeializerTypeXML:
            return [AFXMLParserResponseSerializer serializer];
            break;
            
        case FMResponseSeializerTypePlist:
            return [AFPropertyListResponseSerializer serializer];
            break;
            
        case FMResponseSeializerTypeImage:
            return [AFImageResponseSerializer serializer];
            break;
            
        case FMResponseSeializerTypeCompound:
            return [AFCompoundResponseSerializer serializer];
            break;
            
        default:
            return [AFJSONResponseSerializer serializer];
            break;
    }
}

+ (void)cancelAllRequests {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shareManager];
    
    [manager.dataTasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];

}

@end
