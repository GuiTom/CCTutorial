//
//  FluencyMonnitor.m
//  RunLoopDemo03
//
//  Created by Harvey on 2016/12/14.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import "FluencyMonitor.h"

@interface FluencyMonitor ()

@property(nonatomic,assign)double seconds;
@property(nonatomic,assign)double maxInterVal;

@end

@implementation FluencyMonitor
{
    CFRunLoopObserverRef observer;
}
static FluencyMonitor *instance = nil;

+ (instancetype)shareMonitor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
       
    });
    
    return instance;
}
-(double)getTimeStampUs{
    return   [[NSDate date] timeIntervalSince1970];
}
/**
 开始监控
 */
- (void)start
{
    self.maxInterVal = 0.017;//seconds
    
    [self addObserver];
}

- (void)addObserver{
    // 创建一个监听者
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        NULL,
        NULL
    };
    observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, runLoopObserverCallback, &context);

    CFRunLoopAddObserver(CFRunLoopGetMain(),observer,kCFRunLoopDefaultMode);

    CFRelease(observer);

    
}
-(void)stop{
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}
static void runLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void * info) {
    FluencyMonitor*Self = (__bridge FluencyMonitor*)info;
    if(activity == kCFRunLoopAfterWaiting){//开始处理任务
        Self.seconds = [Self getTimeStampUs];
        
    }else if(activity == kCFRunLoopBeforeWaiting){//任务处理完成
        double ts = [Self getTimeStampUs];
        float interval = ts-Self.seconds;
        NSLog(@"inteval %f s", interval);
        if(interval>Self.maxInterVal){
            NSLog(@"卡顿啦");
        }
        Self.seconds = ts;
    }
};

@end
