//
//  MethodForward2.m
//  CCTutorial
//
//  Created by CC on 2020/3/15.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "MethodForward2.h"

@implementation MethodForward2
-(void)test{
    NSLog(@"%s",__FUNCTION__);
}
-(void)test2{
    NSLog(@"%s",__FUNCTION__);
}
@end
