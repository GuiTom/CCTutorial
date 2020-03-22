//
//  NSLockSample.m
//  CCTutorial
//
//  Created by CC on 2020/3/22.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSLockSample.h"
static NSInteger productCount;

@implementation NSLockSample
{
    NSLock *locker;
}
-(instancetype)init{
    if(self=[super init]){
        locker = [NSLock new];
    }
    return self;
}
-(void)test{
    
    [NSThread detachNewThreadSelector:@selector(consume) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(produce) toTarget:self withObject:nil];
}
-(void)consume{
    NSLog(@"%s",__func__);
    for (int i=0; i<10000; i++) {
        [locker lock];
            if(productCount>0){
                productCount--;
                NSLog(@"消费了一个，还剩%ld个",productCount);
            }
        
        [locker unlock];
    }

}
-(void)produce{
    NSLog(@"%s",__func__);
    for (int i=0; i<10000; i++) {
        [locker lock];
            productCount++;
            NSLog(@"生产了一个，共有%ld个",productCount);
        [locker unlock];
    }
}
@end
