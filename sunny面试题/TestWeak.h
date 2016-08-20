//
//  TestWeak.h
//  基础知识
//
//  Created by xiaohongjun on 16/7/31.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestWeak : NSObject
@property(nonatomic, weak) NSString *name;
@property(nonatomic, weak) NSObject *obj;
@end
