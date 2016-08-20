//
//  GCDManager.m
//  基础知识
//
//  Created by xiaohongjun on 16/7/25.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "GCDManager.h"

@implementation GCDManager
//这个原始的方法可能不会起到所有的网络请求回来在执行操作的效果。
- (void)startGroupRequest{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.xhj", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSLog(@"block1");
        //这里模仿的是一个而网络请求。异步执行的。
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
            NSLog(@"网络请求回来了");
        });
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"block3");
    });
    //当这个group中的queue队列中的block执行完成之后才会得到通知。但是，这个block里面有可能还会嵌套一个异步的网络请求。这时候就会出问题了。
    dispatch_group_notify(group, queue, ^{
        NSLog(@"finished");
    });
    
}

- (void)startGroupRequestNew{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.xhj", DISPATCH_QUEUE_CONCURRENT);
    [self startAsyncRequest:group queue:queue delay:3 content:@"API1"];
    [self startAsyncRequest:group queue:queue delay:4 content:@"API2"];
    [self startAsyncRequest:group queue:queue delay:5 content:@"API3"];
    dispatch_group_notify(group, queue, ^{
        NSLog(@"all api finished");
    });
    
    
}

- (void)startAsyncRequest:(dispatch_group_t)group queue:(dispatch_queue_t)queue delay:(NSInteger)delay content:(NSString *)content{
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSString *str = [NSString stringWithFormat:@"执行----%@",content];
        NSLog(@"%@",str);
        //这里模仿的是一个而网络请求。异步执行的。
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, ^{
            NSString *str = [NSString stringWithFormat:@"网络请求回来了---- %@",content];
            NSLog(@"%@",str);
            dispatch_group_leave(group);
        });
    });
}
@end
