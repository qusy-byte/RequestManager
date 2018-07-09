//
//  FMRequestManager.h
//  FMRequestManager
//
//  Created by Jadyn_Qu on 2018/6/11.
//  Copyright © 2018年 Jadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FMRequestManagerSuccess)(id responseObj);
typedef void(^FMRequestManagerFailer)(NSError *error);

/**
 请求解析器类型
 */
typedef NS_ENUM(NSUInteger, FMRequestSeializerType) {
    /**
     *  默认类型 JSON  如果使用这个请求解析器类型,那么请求数据将会是JSON格式
     */
    FMRequestSeializerTypeDefault,
    /**
     *  JSON类型 如果使用这个请求解析器类型,那么请求数据将会是JSON格式
     */
    FMRequestSeializerTypeJSON,
    /**
     *  Plist类型 如果使用这个请求解析器类型,那么请求数据将会是Plist格式
     */
    FMRequestSeializerTypePlist,
    /**
     *  Data类型 如果使用这个请求解析器类型,那么请求数据将会是二进制格式
     */
    FMRequestSeializerTypeData
};

/**
 数据解析器类型
 */
typedef NS_ENUM(NSUInteger, FMResponseSeializerType) {
    /**
     *  默认类型 JSON  如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    FMResponseSeializerTypeDefault,
    /**
     *  JSON类型 如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    FMResponseSeializerTypeJSON,
    /*
     *  XML类型 如果使用这个响应解析器类型,那么请求返回的数据将会是XML格式
     */
    FMResponseSeializerTypeXML,
    /**
     *  Plist类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Plist格式
     */
    FMResponseSeializerTypePlist,
    /*
     *  Compound类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Compound格式
     */
    FMResponseSeializerTypeCompound,
    /**
     *  Image类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Image格式
     */
    FMResponseSeializerTypeImage,
    /**
     *  Data类型 如果使用这个响应解析器类型,那么请求返回的数据将会是二进制格式
     */
    FMResponseSeializerTypeData
};

@interface FMRequestManager : NSObject

/**
 get请求

 @param urlString 请求链接
 @param parames 请求参数
 @param requestType 请求类型
 @param reponseType 返回结果类型
 @param requestSuccess 成功回调
 @param requestFailer 失败回调
 @return 返回当前任务
 */
+ (NSURLSessionDataTask *)Get:(NSString *)urlString parames:(id)parames requestSeializerType:(FMRequestSeializerType)requestType responseSeializerType:(FMResponseSeializerType)reponseType success:(FMRequestManagerSuccess)requestSuccess failer:(FMRequestManagerFailer)requestFailer;

/**
 Post请求
 
 @param urlString 请求链接
 @param parames 请求参数
 @param requestType 请求类型
 @param reponseType 返回结果类型
 @param requestSuccess 成功回调
 @param requestFailer 失败回调
 @return 返回当前任务
 */
+ (NSURLSessionDataTask *)Post:(NSString *)urlString parames:(id)parames requestSeializerType:(FMRequestSeializerType)requestType responseSeializerType:(FMResponseSeializerType)reponseType success:(FMRequestManagerSuccess)requestSuccess failer:(FMRequestManagerFailer)requestFailer;

/**
 取消所有请求
 */
+ (void)cancelAllRequests;

@end
















