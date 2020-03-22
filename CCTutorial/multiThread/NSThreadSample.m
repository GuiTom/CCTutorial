//
//  NSThreadSample.m
//  CCTutorial
//
//  Created by CC on 2020/3/22.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSThreadSample.h"

@implementation NSThreadSample
-(void)test{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(onThreadCome:) object:@"abc"];
    [thread start];
}
-(void)onThreadCome:(NSString*)name{
    NSLog(@"name %@",name);
}
-(void)test2{
    [NSThread detachNewThreadSelector:@selector(onThreadCome:) toTarget:self withObject:@"abcd"];
}
@end
