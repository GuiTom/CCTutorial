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
 限制同时运行的线程数
 */
-(void)test{
    dispatch_semaphore_t sema = dispatch_semaphore_create(2);
    for (NSInteger i = 0;i<10;i++) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
             NSLog(@"执行任务 %ld",i);
            // doing
            dispatch_semaphore_signal(sema);
             NSLog(@"任务 %ld即将结束",i);
        });
    }
}
@end
