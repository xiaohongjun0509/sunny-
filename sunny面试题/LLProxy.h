//
//  LLProxy.h
//  sunny面试题
//
//  Created by xiaohongjun on 16/7/21.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLProxy : NSProxy
@property(nonatomic, weak) id target;
@property(nonatomic, weak) NSString *name;
@property(nonatomic, weak) NSObject *obj;
@end
