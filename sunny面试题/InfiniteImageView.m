//
//  InfiniteImageView.m
//  基础知识
//
//  Created by xiaohongjun on 16/7/28.
//  Copyright © 2016年 xiaohongjun. All rights reserved.
//

#import "InfiniteImageView.h"
#import "LLProxy.h"
#import "TestWeak.h"
@interface InfiniteImageView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) LLProxy *proxy;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) TestWeak *test;
@end

#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height
#define INDEX (self.scrollView.contentOffset.x + self.scrollView.frame.size.width * 0.5) / self.scrollView.frame.size.width

@implementation InfiniteImageView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
        [self setupGes];
    }
    return self;
}

- (void)setImages:(NSArray *)images{
    self.scrollView.contentOffset = CGPointMake(WIDTH, 0);
    self.imageIndex = 0;
    _images = images;
    [self updateContent];
    [self setupTimer];
}

- (void)updateContent{
    //当前显示的图片在数组中的位置
    NSInteger index = self.imageIndex;
    NSInteger preIndex = self.imageIndex == 0 ? (self.images.count - 1) : index - 1;
    NSInteger nextIndex = self.imageIndex == self.images.count - 1 ? 0 : index + 1;
    
    UIImageView *imageView = self.imageViews[1];
    imageView.image = [UIImage imageNamed:self.images[index]];
    UIImageView *preImage = self.imageViews[0];
    preImage.image = [UIImage imageNamed:self.images[preIndex]];
    UIImageView *nextImage = self.imageViews[2];
    nextImage.image = [UIImage imageNamed:self.images[nextIndex]];
}

- (void)setupUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    self.imageViews = [NSMutableArray array];
    //只需要三个imageView就可以实现重用
    for(NSInteger i = 0; i < 3; i ++){
        CGRect frame = CGRectMake(i * WIDTH, 0, WIDTH, HEIGHT);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.scrollView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//  不让scrollView产生回弹的效果。来避免露出空白的背景。
    self.scrollView.bounces = NO;

}
- (void)setupGes{
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(stopTimer:)];
    [self.scrollView addGestureRecognizer:self.longPress];
}

- (void)stopTimer:(UIGestureRecognizer *)ges{
    if (ges.state == UIGestureRecognizerStateBegan) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (ges.state == UIGestureRecognizerStateEnded) {
        [self startTimer];
    }
}

- (void)setupTimer{
    [self.timer invalidate];
    self.timer = nil;
    self.proxy = [LLProxy alloc];
    self.proxy.target = self;
    NSObject *obj = [NSObject new];
    self.proxy.obj = obj;
    [self startTimer];
}

- (void)scrollToNext{
//    NSLog(@"%@----%@",self.proxy.target,[self.proxy.target valueForKey:@"retainCount"]);
    self.currentIndex = INDEX;
    [self.scrollView setContentOffset:CGPointMake(WIDTH * 2, 0) animated:YES];
}

- (void)startTimer{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(addTimerToThread) object:nil];
    [thread start];
}

- (void)addTimerToThread{
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort new] forMode:NSRunLoopCommonModes];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    [runLoop run];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)dealloc{
    //控件销毁的时候必须要将这个timer销毁。
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.currentIndex = INDEX;
}

//这个函数只有在setContentOffset的时候才会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = INDEX;
    if (self.currentIndex - index == 1) {
        self.imageIndex--;
        if (self.imageIndex < 0) {
            self.imageIndex = self.images.count - 1;
        }
    }else if(self.currentIndex - index == -1){
        self.imageIndex++;
        if (self.imageIndex == self.images.count) {
            self.imageIndex = 0;
        }
    }
    //滚动一个屏幕的时候更新下内容。
    [self updateContent];
    
    [scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    [self.timer invalidate];
//    self.timer = nil;
//}

@end
