//
//  MethodForward.m
//  CCTutorial
//
//  Created by CC on 2020/3/14.
//  Copyright © 2020 kayak. All rights reserved.
//
#import "MethodForward2.h"
#import "MethodForward.h"
#import <objc/runtime.h>
@implementation MethodForward
/**
 这个函数就是问你是否要重新走一遍消息转发流程
 返回NO就去调用forwardingTargetForSelector
 返回YES就重新启动消息转发流程objc_sendMsg消息发送流程
 返回YES的情况下在消息转发过程中还是没有找到该方法，则直接调用forwardingTargetForSelector
 */
+(BOOL)resolveInstanceMethod:(SEL)aSelector{
      if(aSelector == @selector(test)){
          NSLog(@"%s",__func__);
//          Method m = class_getInstanceMethod(self, @selector(myMethod));
//          IMP imp = method_getImplementation(m);
//          class_addMethod(self, @selector(test),imp, "v@:");
          return NO;
      }else {
          return YES;
      }
}


-(void)myMethod{
    NSLog(@"%s",__func__);
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if(aSelector==@selector(test)){
        NSLog(@"%s",__func__);
//        return [MethodForward2 new];//可以转给别的对象接收
        return self;//返回nil或self就去调用methodSignatureForSelector
    }else {
        return [super forwardingTargetForSelector:aSelector];
    }
    
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if(aSelector == @selector(test)){
        //^代表返回值为空,@代表第一个参数是id类型,:代表方法名
        NSLog(@"%s",__func__);
       //如果不能返回一个正确的签名，则结束转发流程，报 selector Not recognized错误.
       return [NSMethodSignature signatureWithObjCTypes:"^@:"];
    }else {
        return [super methodSignatureForSelector:aSelector];
    }
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    [anInvocation invokeWithTarget:[MethodForward2 new]];
    NSLog(@"%s",__func__);
}

@end
