//
//  OSUnfairLock.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/7.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "OSUnfairLock.h"
#import <os/lock.h>
@implementation OSUnfairLock
os_unfair_lock theLock ;
-(void)test{
    theLock = OS_UNFAIR_LOCK_INIT;
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(download1) object:nil];
    [thread1 start];
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(download2) object:nil];
    [thread2 start];
}
-(void)download1
{
    NSLog(@"第一个线程获取锁");
    os_unfair_lock_lock(&theLock);
    NSLog(@"第一个线程同步操作开始");
    sleep(8);
    NSLog(@"第一个线程同步操作结束");
    os_unfair_lock_unlock(&theLock);
}
-(void)download2
{
     NSLog(@"第二个线程获取锁");
    os_unfair_lock_lock(&theLock);
    NSLog(@"第二个线程同步操作开始");
    sleep(1);
    NSLog(@"第二个线程同步操作结束");
    os_unfair_lock_unlock(&theLock);
}
@end
