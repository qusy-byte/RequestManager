//
//  ViewController.m
//  FMRequestManager
//
//  Created by Jadyn_Qu on 2018/6/11.
//  Copyright © 2018年 Jadyn. All rights reserved.
//

#import "ViewController.h"
#import "FMBaseRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self listenOneMoney];
    
    [self homeRequest];

//    [self canelRequest];
}

- (void)homeRequest {
    NSString *urlString = @"https://testapi.caizhidao.cn/api/czd-core-service/v1/core/home/collect";
    NSDictionary *parames = @{@"modelId":@"1",@"pageNo":@"1",@"pageSize":@"15"};
    
    FMBaseRequest *request = [FMBaseRequest fm_requestWithUrl:urlString requestType:FMRequestTypePost requestSeializerType:FMRequestSeializerTypeJSON];
    request.parames = parames;
    
    [request fm_sendRequestWithSuccess:^(FMBaseModel *responseModel) {
        NSLog(@"homeRequest = %@",responseModel.data);
    } complection:^(NSInteger responseCode, NSString *responseMessage) {
        NSLog(@"responseMessage = %@",responseMessage);
    } failer:^(NSError *responseError) {
        NSLog(@"responseError = %@",responseError);
    }];
    
}

- (void)listenOneMoney {
    NSString *urlString = @"https://testapi.caizhidao.cn/api/czd-core-service/v1/core/listen/recommend";
    NSDictionary *parames = @{@"isVisitor":@"true"};
    
    FMBaseRequest *request = [FMBaseRequest fm_requestWithUrl:urlString requestType:FMRequestTypeGet];
    request.parames = parames;
    [request fm_sendRequestWithSuccess:^(FMBaseModel *responseModel) {
        NSLog(@"listenOneMoney = %@",responseModel.data);
    } complection:^(NSInteger responseCode, NSString *responseMessage) {
        NSLog(@"responseMessage = %@",responseMessage);
    } failer:^(NSError *responseError) {
        NSLog(@"responseError = %@",responseError);
    }];
    
//    [request cancelCurrentRequest];
    
}

- (void)canelRequest {
    
    [FMRequestManager cancelAllRequests];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
