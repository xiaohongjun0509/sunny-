//
//  LLUrlManager.h
//  基础知识
//
//  Created by xiaohongjun on 16/7/27.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLBaseHandler.h"
@interface LLUrlManager : NSObject
+ (LLBaseHandler *)handleUrl:(NSString *)url;
@end
