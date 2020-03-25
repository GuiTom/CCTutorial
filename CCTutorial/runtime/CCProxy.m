//
//  CCProxy.m
//  CCTutorial
//
//  Created by CC on 2020/3/25.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "CCProxy.h"

@implementation CCProxy

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}
-(void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}
@end
