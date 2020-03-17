//
//  CrashHandler.h
//  RunLoopDemo04
//
//  Created by Harvey on 2016/12/15.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashDefender : NSObject
{
    BOOL ignore;
}
- (void)startCaptureCrash;
+ (instancetype)sharedInstance;

@end


