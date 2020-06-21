//
//  NSConditonLockSample.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/5.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSConditonLockSample.h"

@implementation NSConditonLockSample
{
    NSConditionLock *conditionLock;
}
/**
 */
-(void)test{
    conditionLock = [[NSConditionLock alloc] initWithCondition:2];
    [[[NSThread alloc] initWithTarget:self selector:@selector(onThread1) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(onThread2) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(onThread3) object:nil] start];
}
-(void)onThread1{
    
    [conditionLock lockWhenCondition:1];
    NSLog(@"%s",__FUNCTION__);
    [conditionLock unlock];
}
-(void)onThread2{
    [conditionLock lockWhenCondition:2];
    NSLog(@"%s",__FUNCTION__);
    [conditionLock unlockWithCondition:3];
}
-(void)onThread3{
    [conditionLock tryLockWhenCondition:3];
    NSLog(@"%s",__FUNCTION__);
    [conditionLock unlockWithCondition:1];
}
@end
