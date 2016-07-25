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
@interface ViewController (){
    NSString * _foo;
}
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSObject *obj;
@property(nonatomic, weak)  NSObject *obj1;
//@property(nonatomic, weak) NSInteger index;
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) SecondViewController *secondVC;

@end


static void funIMP(){
    NSLog(@"这是一个函数的实现IMP");
}

@implementation ViewController

//@synthesize count = _a;
//@dynamic count;
- (IBAction)push:(id)sender {
    
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
//    self.count = 3;
//    NSArray *a1 = @[@"1",@"2"];
//    NSArray *a2 = [a1 copy];
//    NSArray *a3 = [a1 mutableCopy];
//    _a  = 3;
//    self.count = 12;
//    [a1 high];
//    [self hello:@"helo"];
//    [self performSelector:@selector(sayWorld) withObject:nil afterDelay:0];
//    ((void (*)(id, SEL))objc_msgSend)(self, @selector(h));
//    dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)
//    dispatch_barrier_async(<#dispatch_queue_t queue#>, <#^(void)block#>)
//    [self addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    self.count = 3;
//    [self setValue:@"hello" forKey:@"foo"];
//    [self setValue:@"world" forKey:@"_foo"];
//    self.dict = [NSMutableDictionary dictionary];
//    [self.dict setValue:@"value1" forKey:@"key1"];
//    [self.dict setObject:@"value2" forKey:@"key2"];
//    [self.dict setValue:nil forKey:@"key1"];
////    [self.dict setObject:nil forKey:@"key2"];
//    [self.dict valueForKey:@"@key3"];
//    [self.dict objectForKey:@"key4"];
    
//    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//    //do something
//    dispatch_semaphore_signal(sem);
//    [self registerObserver];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification" object:@"hello"];
//    [[ManagerCenter defaultCenter] postEntityName:@"test" object:@"world"];
//    InhertBase *inhert = [InhertBase new];
//    [inhert print];
    GCDManager *manager = [GCDManager new];
    [manager startGroupRequest];
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
//    [self.secondVC doSomeThing:nil];
//    self.secondVC = nil;
    
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
