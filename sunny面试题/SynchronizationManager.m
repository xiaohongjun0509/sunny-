//
//  SynchronizationManager.m
//  基础知识
//
//  Created by xiaohongjun on 16/8/16.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "SynchronizationManager.h"
#import <libkern/OSAtomic.h>
#import <pthread.h>

@implementation SynchronizationManager

- (void)testSynchronization{
//    同步的几种实现的方式
    dispatch_queue_t queue = dispatch_queue_create("xhj", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        @synchronized (self) {
//            NSLog(@"线程1开始执行");
//            sleep(3);
//            NSLog(@"线程1结束执行");
//        }
//    });
//    
//    dispatch_async(queue, ^{
//        @synchronized (self) {
//            sleep(1);
//            NSLog(@"线程2开始执行");
//            NSLog(@"线程2结束执行");
//        }
//    });
    
    
//    NSLock *lock = [NSLock new];
//    dispatch_async(queue, ^{
//        [lock lock];
//        NSLog(@"线程1开始执行");
//        sleep(3);
//        NSLog(@"线程1结束执行");
//        [lock unlock];
//        
//    });
//    
//    dispatch_async(queue, ^{
//        sleep(1);
//        [lock lock];
//        NSLog(@"线程2开始执行");
//        NSLog(@"线程2结束执行");
//        [lock unlock];
//    });
    


//   dispatch_semaphore_t sem =  dispatch_semaphore_create(1);//当信号量为1的时候可以当成锁来用。
//    dispatch_async(queue, ^{
//        sleep(2);
//        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//        NSLog(@"线程1开始执行");
//        sleep(3);
//        NSLog(@"线程1结束执行");
//        dispatch_semaphore_signal(sem);
//
//    });
//
//    dispatch_async(queue, ^{
//        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//        NSLog(@"线程2开始执行");
//        sleep(2);
//        NSLog(@"线程2结束执行");
//        dispatch_semaphore_signal(sem);
//        
//    });
    
    
//    __block OSSpinLock theLock = OS_SPINLOCK_INIT;
//    dispatch_async(queue, ^{
//        OSSpinLockLock(&theLock);
//        NSLog(@"线程2开始执行");
//        sleep(3);
//        NSLog(@"线程2结束执行");
//        OSSpinLockUnlock(&theLock);
//    });
//    
//    
//    dispatch_async(queue, ^{
//        OSSpinLockLock(&theLock);
//        sleep(3);
//        NSLog(@"线程1开始执行");
//        sleep(3);
//        NSLog(@"线程1结束执行");
//        OSSpinLockUnlock(&theLock);
//    });
//
    
//    recurive 类型的pthread_mutex
//    pthread_mutexattr_t attr;
//    pthread_mutexattr_init(&attr);
//    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
//    pthread_mutex_t lock ;
//    pthread_mutex_init(&lock, &attr);
//    pthread_mutexattr_destroy(&attr);
    
    __block pthread_mutex_t theLock;
    pthread_mutex_init(&theLock, NULL);
    dispatch_async(queue, ^{
        pthread_mutex_lock(&theLock);
        NSLog(@"线程1开始执行");
        sleep(3);
        NSLog(@"线程1结束执行");
        pthread_mutex_unlock(&theLock);
    });
    
    dispatch_async(queue, ^{
        pthread_mutex_lock(&theLock);
        NSLog(@"线程2开始执行");
        sleep(3);
        NSLog(@"线程2结束执行");
        pthread_mutex_unlock(&theLock);
    });
}

@end
