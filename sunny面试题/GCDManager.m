//
//  GCDManager.m
//  基础知识
//
//  Created by xiaohongjun on 16/7/25.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "GCDManager.h"

@implementation GCDManager

- (void)startGroupRequest{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.xhj", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSLog(@"block1");
        //这里模仿的是一个而网络请求。
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
@end
