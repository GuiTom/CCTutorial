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
 异步执行，串行队列
 主队列，是主线程运行的，系统帮忙创建的串行队列
 */
-(void)mainQueue{
    NSLog(@"执行任务1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}
/**
 同步执行，串行队列
自建的串行队列中同步执行任务
*/
-(void)serialQueue{
    NSLog(@"执行任务1");
    //这里的 queue与dispatch_get_main_queue()得到的 queue的区别只是不在主线程
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    for (int i=0; i<5; i++) {
        NSLog(@"执行任务2");
        dispatch_sync(queue, ^{
          
            NSLog(@"一个接一个执行 %i %d",i,[NSThread currentThread].isMainThread);
        });
    }
    NSLog(@"执行任务3");
}
/**
异步执行，并发队列
*/
-(void)asyncConcurrentQueue{
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
   
    
    for (int i=0; i<5; i++) {
        dispatch_async(queue, ^{
              NSLog(@"不分先后地执行 %i %p %p",i,[NSThread currentThread],[NSThread mainThread]);
        });
    }
    NSLog(@"执行任务2");
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
    NSLog(@"执行任务4");
}
/**
异步执行，并发队列
*/
-(void)syncConcurrentQueue{
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
   
    for (int i=0; i<5; i++) {
        dispatch_sync(queue, ^{
              NSLog(@"先后地执行 %i %p %p",i,[NSThread currentThread],[NSThread mainThread]);
        });
    }
    NSLog(@"执行任务2");
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
 演示 GCD串行队列的暂停和继续
暂停和继续只对串行队列有效
 */
-(void)suspendAndResume{
     
    //并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
            NSLog(@"1执行中");
            sleep(5);
            NSLog(@"1执行完");
        
    });
    dispatch_async(queue, ^{
        NSLog(@"2执行中");
            sleep(1);
            NSLog(@"2执行完");
        
    });
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"挂起");
        dispatch_suspend(queue);
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            NSLog(@"重新开始");
            dispatch_resume(queue);
    
        });
    });

}
/**
 队列死锁的例子
 向当前串行队列添加同步任务会造成死锁
 */
-(void)deadLock1{
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
/**
 队列死锁的例子
 向当前串行队列添加同步任务会造成死锁
 */
-(void)deadLock2{
    NSLog(@"执行任务1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}
/**
 在指定的时间之后将 bloc 添加到队列
 */
-(void)dispatchAfter{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull*NSEC_PER_SEC);
    NSLog(@"执行任务1");
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}
/**
并发地执行任务，并等待所有任务执行完毕
*/
-(void)dispatchGroupNotify{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行任务1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行任务2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行任务3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"任务执行完毕");
    });

}
/**
并发地执行任务，并等待所有任务执行完毕
*/
-(void)dispatchGroupWait{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行任务1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行任务2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"执行任务3");
    });
    
    //等待任务执行完毕,与dispatch_group_notify有同样的的作用
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"任务执行完毕");
}
/**
 并发地执行任务，并等待所有任务执行完毕
 */
-(void)dispatchApply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(5,queue, ^(size_t index) {
        NSLog(@"%zu",index);
    });
    NSLog(@"任务执行完毕");
}
/**
 栅栏调用
 */
-(void)dispatch_barrier_async{
    dispatch_queue_t queue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
    __block NSInteger value =1;
    dispatch_async(queue, ^{
        NSLog(@"1 value is: %ld",(long)value);
    });
    dispatch_async(queue, ^{
        NSLog(@"2 value is: %ld",(long)value);
    });
    dispatch_async(queue, ^{
        NSLog(@"3 value is: %ld",(long)value);
    });
    dispatch_barrier_sync(queue, ^{
        value = 2;
        
    });
    dispatch_async(queue, ^{
        NSLog(@"4 value is: %ld",(long)value);
    });
    dispatch_async(queue, ^{
        NSLog(@"5 value is: %ld",(long)value);
    });
}
@end
