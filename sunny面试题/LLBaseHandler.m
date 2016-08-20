//
//  LLBaseHandler.m
//  基础知识
//
//  Created by xiaohongjun on 16/7/27.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "LLBaseHandler.h"
@interface LLBaseHandler(){
    UIViewController *_controller;
}

@end

@implementation LLBaseHandler

- (instancetype)initHandlerWithParams:(NSDictionary *)params{
    return [super init];
}

- (UIViewController *)viewController{
    return _controller;
}
@end
