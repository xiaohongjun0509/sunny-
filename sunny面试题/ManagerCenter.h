//
//  ManagerCenter.h
//  基础复习
//
//  Created by xiaohongjun on 16/7/20.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface ManagerCenter : NSObject
+ (instancetype)defaultCenter;
- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object;
- (void)postEntityName:(NSString *)name object:(id)object;
- (void)removeObserver:(NSObject *)observer forName:(NSString *)name;
- (void)removeObserver:(id)observer;
@end
