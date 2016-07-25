//
//  Entity.h
//  基础复习
//
//  Created by xiaohongjun on 16/7/20.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entity : NSObject
@property (nonatomic, strong) id object;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy) NSString *postName;
@property (nonatomic, strong) id observer;
@end
