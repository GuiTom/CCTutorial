//
//  SemaphoreSample.m
//  CCTutorial
//
//  Created by CC on 2020/3/22.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "SemaphoreSample.h"

@implementation SemaphoreSample

/**
两个线程交替执行
*/
-(void)test{
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    dispatch_queue_t queue1 = dispatch_queue_create("sQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue1, ^{
        while (1) {
            NSLog(@"%@",@"thread 1 try to lock");
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            NSLog(@"%@",@"task1");
            dispatch_semaphore_signal(sema);
        }
    });
     dispatch_queue_t queue2 = dispatch_queue_create("sQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue2, ^{
        while (1) {
            NSLog(@"%@",@"thread 2 try to lock");
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            NSLog(@"%@",@"task2");
            dispatch_semaphore_signal(sema);
        }
    });
}
/**
 限制同时运行的线程数
 */
-(void)test2{
    dispatch_semaphore_t sema = dispatch_semaphore_create(2);
    for (NSInteger i = 0;i<10;i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);//sema --;
            NSLog(@"执行任务 %ld",i);
            // doing
            dispatch_semaphore_signal(sema);
            NSLog(@"任务 %ld即将结束",i);
        });
    }
}

/**
 线程交替执行
 */
-(void)test{
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue1, ^{
        while (1) {
            NSLog(@"任务1准备获取信号量");
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            NSLog(@"任务1获得信号量");
            dispatch_semaphore_signal(sema);
        }
    });
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue2, ^{
        while (1) {
            NSLog(@"任务2准备获取信号量");
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            NSLog(@"任务2获得信号量");
            dispatch_semaphore_signal(sema);
        }
    });

}

@end
