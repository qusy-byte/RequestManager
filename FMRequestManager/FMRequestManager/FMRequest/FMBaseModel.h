//
//  FMBaseModel.h
//  FMRequestManager
//
//  Created by Jadyn_Qu on 2018/6/11.
//  Copyright © 2018年 Jadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMBaseModel : NSObject

/**
 消息提示msg
 */
@property (nonatomic,copy) NSString *msg;
/**
 请求结果
 */
@property (nonatomic,copy) NSString *result;
/**
 请求状态码
 */
@property (nonatomic,assign) NSInteger status;
/**
 返回数据
 */
@property (nonatomic,strong) id data;

@end
