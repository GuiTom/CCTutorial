//
//  FluencyMonitorVC.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/7.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "FluencyMonitorVC.h"

@interface FluencyMonitorVC ()

@property(nonatomic,assign)double seconds;
@end

@implementation FluencyMonitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addMonitor];
    [self initButtons];
}

-(void)initButtons{
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *buttonA = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    [buttonA setTitle:@"模拟UI卡顿" forState:UIControlStateNormal];
    [buttonA addTarget:self action:@selector(onClickButtonA:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonA];
}
-(void)onClickButtonA:(UIButton*)buttonA{
    usleep(17000);//休眠17ms,模拟UI卡顿
}
-(double)getTimeStampUs{
    return   [[NSDate date] timeIntervalSince1970];
}
- (void)addMonitor{
    // 创建一个监听者
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        NULL,
        NULL
    };
   CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, runLoopObserverCallback, &context);

    CFRunLoopAddObserver(CFRunLoopGetMain(),observer,kCFRunLoopDefaultMode);

    CFRelease(observer);

    
}
static void runLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void * info) {
    FluencyMonitorVC*Self = (__bridge FluencyMonitorVC*)info;
    if(activity == kCFRunLoopAfterWaiting){//开始处理任务
        Self.seconds = [Self getTimeStampUs];
        
    }else if(activity == kCFRunLoopBeforeWaiting){//任务处理完成
        double ts = [Self getTimeStampUs];
        float interval = ts-Self.seconds;
//        NSLog(@"inteval %f s", interval);
        if(interval>0.017f){
            NSLog(@"卡顿啦");
        }
        Self.seconds = ts;
    }


};

@end
