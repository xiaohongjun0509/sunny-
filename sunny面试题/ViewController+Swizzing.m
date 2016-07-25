//
//  ViewController+Swizzing.m
//  基础复习
//
//  Created by xiaohongjun on 16/7/20.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "ViewController+Swizzing.h"
#import <objc/runtime.h>
@implementation ViewController (Swizzing)
+(void)initialize{
     Method origM = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method replaceM = class_getInstanceMethod([self class], @selector(replaceViewDidLoad));
    method_exchangeImplementations(origM, replaceM);
    
}

- (void)replaceViewDidLoad{
    [self replaceViewDidLoad];
    NSLog(@"replaceViewDidLoad");
}
@end
