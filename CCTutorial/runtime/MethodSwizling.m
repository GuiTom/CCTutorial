//
//  MethodSwizling.m
//  CCTutorial
//
//  Created by CC on 2020/3/15.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "MethodSwizling.h"
#import <objc/runtime.h>
@implementation MethodSwizling
+(void)load{
    //交换两个方法的函数指针(IMP),但不交换方法名选择器。
    Method m1 = class_getInstanceMethod([self class], @selector(test1));
    Method m2 = class_getInstanceMethod([self class], @selector(test2));
    method_exchangeImplementations(m1, m2);
}
-(void)test1{
    //调用[self test2]的时候，代码会执行到这里，因为这个
    //函数指针已经和test2的函数指针交换
    NSLog(@"%s",__func__);
}
-(void)test2{
    //调用[[MethodSwizling alloc] test1]的时候，代码会执行到这里，因为这个
    //函数指针已经和test1的函数指针交换
    NSLog(@"%s",__func__);
    
    [self test2];
    
}
@end
