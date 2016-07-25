//
//  ManagerCenter.m
//  基础复习
//
//  Created by xiaohongjun on 16/7/20.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "ManagerCenter.h"

@interface ManagerCenter()

@property (nonatomic, strong) NSMutableArray *observers;

@end


@implementation ManagerCenter

- (NSMutableArray *)observers{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _observers = [NSMutableArray array];
    });
    return _observers;
}

+(instancetype)defaultCenter{
    static dispatch_once_t onceToken;
    static ManagerCenter *center;
    dispatch_once(&onceToken,^{
        center = [ManagerCenter new];
    });
    return center;
}

-(void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object{
    Entity *entity = [[Entity alloc] init];
    entity.selector = selector;
    entity.object = object;
    entity.postName = name;
    entity.observer = observer;
    [self.observers addObject:entity];
}

- (void)postEntityName:(NSString *)name object:(id)object{
    Entity *newEntity = [Entity new];
    newEntity.object = object;
    for (Entity *entity in _observers) {
        if ([name isEqualToString:entity.postName]) {
            [entity.observer performSelector:entity.selector withObject:newEntity];
        }
    }
}

- (void)removeObserver:(id)observer{
    NSMutableArray *toDelete = [NSMutableArray array];
    for (Entity *entity in _observers) {
        if (entity.observer == observer) {
            [toDelete addObject:entity];
        }
    }
    if (toDelete.count) {
        [self.observers removeObjectsInArray:toDelete];
    }
}

- (void)removeObserver:(NSObject *)observer forName:(NSString *)name{
    NSMutableArray *toDelete = [NSMutableArray array];
    for (Entity *entity in _observers) {
        if (entity.observer == observer && [entity.postName isEqualToString:name]) {
            [toDelete addObject:entity];
        }
    }
    if (toDelete.count) {
        [toDelete removeObjectsInArray:self.observers];
    }
}

@end
