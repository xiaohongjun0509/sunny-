//
//  LLProxy.m
//  sunny面试题
//
//  Created by xiaohongjun on 16/7/21.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "LLProxy.h"
@interface LLProxy()

@end

@implementation LLProxy


- (id)forwardingTargetForSelector:(SEL)selector {
    NSLog(@"%@",[self.target valueForKey:@"retainCount"]);
    return self.target;
}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
//    NSMethodSignature *sig = [self.target methodSignatureForSelector:sel];
//    return sig;
//}
//
//- (void)forwardInvocation:(NSInvocation *)invocation{
//    [invocation invokeWithTarget:self.target];
//}
@end
