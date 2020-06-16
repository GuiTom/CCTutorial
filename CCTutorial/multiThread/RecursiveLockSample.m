//
//  RecursiveLockSample.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/15.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "RecursiveLockSample.h"
@interface RecursiveLockSample()
@property(nonatomic,strong)NSRecursiveLock *lock;
@end
@implementation RecursiveLockSample
-(void)test{
    self.lock = [[NSRecursiveLock alloc] init];
    [self test2];
}
-(void)test2{
    for (int i=0; i<3; i++) {
        [self.lock lock];
        NSLog(@"%d",i);
    }
}
@end
