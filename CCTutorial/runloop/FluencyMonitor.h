//
//  FluencyMonnitor.h
//  RunLoopDemo03
//
//  Created by Harvey on 2016/12/14.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FluencyMonitor : NSObject

+ (instancetype)shareMonitor;



/**
 开始监控
 */
- (void)start;

// 停止监控
- (void)stop;

@end
