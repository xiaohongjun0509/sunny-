//
//  ViewController.m
//  基础复习
//
//  Created by xiaohongjun on 16/7/18.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/objc-runtime.h>
#import "Person.h"
#import "SecondViewController.h"
#import "ViewController+Swizzing.h"
#import "ManagerCenter.h"
#import "InhertBase.h"
#import "GCDManager.h"
#import "LLUrlManager.h"
#import "InfiniteImageView.h"
#import "SynchronizationManager.h"
@interface ViewController (){
    NSString * _foo;
}
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSObject *obj;
@property(nonatomic, weak)  NSObject *obj1;
//@property(nonatomic, weak) NSInteger index;
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) SecondViewController *secondVC;
@property (nonatomic, strong) InfiniteImageView *infiniteImageView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong)  NSMutableArray *a;
@property (nonatomic, strong) Person *person;

@end


typedef void(^Block)(void);

static void funIMP(){
    NSLog(@"这是一个函数的实现IMP");
}

//static NSMutableArray *a;

@implementation ViewController

- (IBAction)push:(id)sender {
    
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [[SynchronizationManager new] testSynchronization];
    
}


- (void)registerObserver{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"testNotification" object:@"hello"];
    [[ManagerCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"test" object:nil];
    [[ManagerCenter defaultCenter] removeObserver:self];
    [[ManagerCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"test" object:nil];
}

- (void)test:(Entity *)noti{
    NSLog(@"接收到通知：%@",[noti object]);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    id count = [self.person.name valueForKey:@"retainCount"];
//    NSLog(@"name : %@",[self.person.name valueForKey:@"retainCount"]);
    
}
- (void)setCount:(NSInteger)count{
    [self willChangeValueForKey:@"count"];
    _count = count;
    [self didChangeValueForKey:@"count"];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSString *st = change[NSKeyValueChangeNewKey];
    
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"count"]) {
        return NO;
    }
    return YES;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) isEqualToString:NSStringFromSelector(@selector(sel1))]) {
        class_addMethod([self class], @selector(hello), (IMP)funIMP, "v@:v");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:NSStringFromSelector(@selector(sayHello))]) {
        return [Person new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        if ([[Person new] respondsToSelector:aSelector]) {
            sig = [[Person new] methodSignatureForSelector:aSelector];
        }
    }
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([[Person new] respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[Person new]];
    }
}



@end
