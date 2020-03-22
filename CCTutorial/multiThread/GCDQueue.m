//
//  GCDQueue.m
//  CCTutorial
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "GCDQueue.h"

@implementation GCDQueue
/**
 全局队列，是系统帮忙创建的并发队列
 */
-(void)globalQueue{
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t queue3 = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    NSLog(@"%p <--> %p <-> %p",queue1,queue2,queue3);//地址不相同，说明不是同一个队列

}
/**
 主队列，是主线程运行的，系统帮忙创建的串行队列
 */
-(void)mainQueue{
    NSLog(@"执行任务1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}
-(void)serialQueue{
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    for (int i=0; i<5; i++) {
        dispatch_sync(queue, ^{
          
            NSLog(@"一个接一个执行 %i %d",i,[NSThread currentThread].isMainThread);
        });
    }
}
-(void)concurrentQueue{
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_get_main_queue();
    
    for (int i=0; i<5; i++) {
        dispatch_async(queue, ^{
              NSLog(@"不分先后地执行 %i %p %p",i,[NSThread currentThread],[NSThread mainThread]);
        });
    }
}
-(void)async{
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务1");
        dispatch_async(queue, ^{
           NSLog(@"执行任务2");
        });
        NSLog(@"执行任务3");
    });
}
-(void)sync{
    //并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"执行任务1");
    dispatch_sync(queue, ^{
        NSLog(@"执行任务2");
        dispatch_sync(queue, ^{
             NSLog(@"执行任务3");
         });
    });
 
    NSLog(@"执行任务4");
}
/**
 队列死锁的例子
 向当前串行队列添加同步任务会造成死锁
 */
-(void)deadLock{
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    NSLog(@"执行任务1");
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        dispatch_sync(queue, ^{//这里发生死锁
           NSLog(@"执行任务3");//这个任务会无法执行
        });
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}
@end
