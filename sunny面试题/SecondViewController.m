//
//  SecondViewController.m
//  基础复习
//
//  Created by xiaohongjun on 16/7/20.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "SecondViewController.h"
#import "LLProxy.h"
#import "TestWeak.h"
#import "InfiniteImageView.h"
@interface SecondViewController()

@property (nonatomic, weak) NSTimer *timer;
@property(nonatomic, weak) NSObject *obj;
@property (nonatomic, strong) LLProxy *proxy;
@property (nonatomic, strong) InfiniteImageView *infiniteImageView;
@end
@implementation SecondViewController

//- (IBAction)dooo:(id)sender {
//    [self doSomeThing:nil];
//}


- (void)setupInfiniteImageView{
    self.infiniteImageView = [[InfiniteImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
    self.infiniteImageView.images = @[@"11",@"12",@"13",@"14",@"15"];
    [self.view addSubview:self.infiniteImageView];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupInfiniteImageView];
//    [self setupTimer];
}
- (void)setupTimer{
//    self.timer = [[NSTimer alloc] init];
    LLProxy *target = [LLProxy alloc];
    target.target = self;
    self.proxy = target;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:target selector:@selector(time) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//    self.obj = [NSObject new];
}

- (void)time{
    NSLog(@"1");
}


//- (void)doSomeThing:(id)sender {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayAction) object:nil];
//    [self performSelector:@selector(delayAction) withObject:nil afterDelay:5];
//}

- (void)delayAction{
    NSLog(@"delayAction");
}

- (void)dealloc{
    NSLog(@"dealloc");
    [self.timer invalidate];
    self.timer = nil;
}



@end
