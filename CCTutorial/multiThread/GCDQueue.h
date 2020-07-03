//
//  GCDQueue.h
//  CCTutorial
//
//  Created by CC on 2020/3/20.
//  Copyright © 2020 kayak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDQueue : NSObject
-(void)globalQueue;
-(void)mainQueue;
-(void)serialQueue;
-(void)asyncConcurrentQueue;
-(void)asyncConcurrentQueue2;
-(void)async;
-(void)syncConcurrentQueue;
-(void)sync;
-(void)deadLock1;
-(void)deadLock2;
-(void)dispatchGroupNotify;
-(void)dispatchGroupWait;
-(void)dispatchApply;
-(void)dispatch_barrier_async;

-(void)dispatch_barrier_async_read_write;
-(void)suspendAndResume;
@end

NS_ASSUME_NONNULL_END
