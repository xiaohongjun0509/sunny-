//
//  LLOperation.m
//  基础复习
//
//  Created by xiaohongjun on 16/7/20.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "LLOperation.h"

@interface LLOperation()

@property (readwrite, getter=isCancelled) BOOL cancelled;
@property (readwrite, getter=isExecuting) BOOL executing;
@property (readwrite, getter=isFinished) BOOL finished;
@property (readwrite, getter=isConcurrent) BOOL concurrent;

@end


@implementation LLOperation
/*
 * 在这里开始你的自定义的task。如果不是定义并发的operation的时候，你就没有必要来重写这个方法，除非你通过自定义的start的方法来开始这个operation。
 */
- (void)main{
    
}

- (void)start{
    if([self isCancelled]){
        [self performSelector:@selector(cancelOperation) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO modes:@[NSRunLoopCommonModes]];
        [self setValue:@(YES) forKey:@"finished"];
        return;
    }else if ([self isReady] && ![self isFinished] && ![self isExecuting]){
        
    }
}


+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    //这里取消一些变量的自动的KVO的通知。
    return YES;
}


- (void)cancelOperation{
//    当operation被取消的时候，来调用这个方法。当然，这里只是一个test 方法。
}

//- (void)setFinished:(BOOL)

@end
