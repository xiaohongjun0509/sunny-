//
//  LLBaseHandler.h
//  基础知识
//
//  Created by xiaohongjun on 16/7/27.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LLBaseHandler : NSObject
- (instancetype)initHandlerWithParams:(NSDictionary *)params;
- (UIViewController *)viewController;
@end
