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
-(void)concurrentQueue;
@end

NS_ASSUME_NONNULL_END
