//
//  NSConditonLockSample.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/5.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSConditonLockSample.h"

@implementation NSConditonLockSample
/**
 1 初始化一个条件锁，条件为0
 2 由于线程1 和线程4条件不满足，所以循环一段时间休眠，等待满足条件满足时唤醒；线程3尝试加锁，不会阻塞线程，但是条件不满足所以直接休眠；线程2休眠1秒后尝试加锁。满足条件所以加锁成功；
 3 线程2伴随重置加锁条件2进行解锁；
 4 此时线程4满足条件，系统唤醒进行加锁，并且重置加锁条件14
 5 此时线程1满足条件，系统唤醒进行加锁，并且解锁，此时条件为1

 作者：lltree
 链接：https://www.jianshu.com/p/ab5616da2715
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
-(void)test{
    //主线程中
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:1];
        NSLog(@"线程1");
        sleep(2);
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:0]) {
            NSLog(@"线程2");
            [lock unlockWithCondition:2];
            NSLog(@"线程2解锁成功");
        }
        else {
            NSLog(@"线程2尝试加锁失败");
        }
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // sleep(2);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:2]) {
            NSLog(@"线程3");
            [lock unlock];
            NSLog(@"线程3解锁成功");
        }
        else {
            NSLog(@"线程3尝试加锁失败");
        }
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // sleep(3);//以保证让线程2的代码后执行
        
        [lock lockWhenCondition:2];
        NSLog(@"线程4");
        [lock unlockWithCondition:1];
        NSLog(@"线程4解锁成功");
        
    });
}
@end
