//
//  LLUrlManager.m
//  基础知识
//
//  Created by xiaohongjun on 16/7/27.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "LLUrlManager.h"

@interface LLUrlManager()
//@property (nonatomic, strong) NSMutableDictionary *handlerSet;
@end
//静态全局变量
static NSDictionary *handlerSet;

@implementation LLUrlManager
+ (void)initialize{
    handlerSet = @{@"sohu":@"SecondViewController",
                                  @"handB":@"ControllerB"};
    
}

+(LLBaseHandler *)handleUrl:(NSString *)urlPath{
    NSAssert(urlPath.length, @"url为空，请检查配置");
    NSURL *url = [NSURL URLWithString:urlPath];
    if (url) {
        NSDictionary *params = [self praseParams:url];
        NSString *schema = [self praseSchema:url];
        LLBaseHandler *handler = [self praseHandler:schema withParams:params];
        return handler;
    
    }
    return nil;
}

//解析参数
+ (NSDictionary *)praseParams:(NSURL *)url{
//    @"http://schema?name=123&passwd=123"
    NSArray *array = [url.query componentsSeparatedByString:@"&"];
    if (array) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *item = obj;
            NSArray *keyValue = [item componentsSeparatedByString:@"="];
            NSString *key = [keyValue firstObject];
            NSString *value = [keyValue lastObject];
            [params setValue:value forKey:key];
        }];
        return params;
    }else{
        return nil;
    }
}

//解析schema
+(NSString *)praseSchema:(NSURL *)url{
    return url.host;
}

+(LLBaseHandler *)praseHandler:(NSString *)schema withParams:(NSDictionary *)params{
    if (schema && [handlerSet.allKeys containsObject:schema]) {
        NSString *clzName = [handlerSet valueForKey:schema];
        Class class = NSClassFromString(clzName);
        if(class){
            LLBaseHandler *handler = [[class alloc] initHandlerWithParams:params];
            return handler;
        }else{
            return nil;
        }
    }
    return nil;
}


@end
