//
//  InhertBase.m
//  基础复习
//
//  Created by xiaohongjun on 16/7/20.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "InhertBase.h"

@interface Base(Inhert)
- (void)print;
@end

@implementation InhertBase
- (void)print{
    [super print];
    NSLog(@"inhertClass");
}
@end
