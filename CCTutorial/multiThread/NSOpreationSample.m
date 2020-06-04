//
//  NSOpreationSample.m
//  CCTutorial
//
//  Created by CC on 2020/3/22.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSOpreationSample.h"

@implementation NSOpreationSample
/**
 开启一个线程任务
 */
-(void)test{
    NSInvocationOperation *io = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(InvocationOperationSelector) object:nil];
    [io start];
}
-(void)InvocationOperationSelector{
    NSLog(@"这是NSInvocationOperation执行的任务   %@",[NSThread currentThread]);
}
/**
 添加任务
 */
-(void)test2{
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"这是NSBlockOperation执行的任务 %@",[NSThread currentThread]);
            NSLog(@"本行是否在block里面运行，取决于NSBlockOperation对象里面有多少任务");
        }
    }];
    
    [bo addExecutionBlock:^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"这是让NSBlockOperation另外执行的任务 %@",[NSThread currentThread]);
            NSLog(@"本行是否在block里面运行，取决于NSBlockOperation对象里面有多少任务");
        }
    }];
    
    [bo addExecutionBlock:^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"这是让NSBlockOperation另外执行的任务2 %@",[NSThread currentThread]);
            NSLog(@"本行是否在block里面运行，取决于NSBlockOperation对象里面有多少任务");
        }
    }];
    [bo start];
}
/**
 NSOpreationQueue 必须创建新的线程
 */
-(void)test3{
     NSOperationQueue *queue = [[NSOperationQueue alloc]init];
     
     NSInvocationOperation *io = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(InvocationOperationSelector) object:nil];
    
      NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
         for (int i = 0; i<2; i++) {
             [NSThread sleepForTimeInterval:2];
             NSLog(@"这是NSBlockOperation执行的任务 %@",[NSThread currentThread]);
         }
     }];
     [queue addOperation:io];
     [queue addOperation:bo];
}
/**
 线程顺序执行
 */
-(void)test4{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];

    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这是bo1执行的任务 %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这是bo2执行的任务 %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bo3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这是bo3执行的任务 %@",[NSThread currentThread]);
    }];
    //bo1依赖于bo2
    [bo1 addDependency:bo2];
    //bo2依赖于bo3
    [bo2 addDependency:bo3];

    [queue addOperations:@[bo1,bo2,bo3] waitUntilFinished:YES];
    
    NSLog(@"如果上面waitUntilFinished是YES，我就会最后执行");
}
/**
 限制最大并发数
 */
-(void)test5{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i<5; i++) {
            NSLog(@"第%d次 执行任务 %@",i+1,[NSThread currentThread]);
        }
    }];

    [bo addExecutionBlock:^{
        for (int i = 0; i<5; i++) {
            NSLog(@"第%d次 执行额外任务 %@",i+1,[NSThread currentThread]);
        }
    }];
    
    [queue addOperation:bo];
}
/**
 线程间通信
 */
-(void)test6{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    

    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
      
        NSLog(@"这是子线程%@",[NSThread currentThread]);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"回到主线程刷新UI%@",[NSThread currentThread]);
        }];
    }];
    [queue addOperation:bo];
}
@end
