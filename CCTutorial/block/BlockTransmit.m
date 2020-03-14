//
//  BlockTransmit.m
//  CCTutorial
//
//  Created by CC on 2020/3/13.
//  Copyright © 2020 kayak. All rights reserved.
//
int abc = 1;
#import "BlockTransmit.h"
static int a = 7;
@implementation BlockTransmit
{
    int aa;
}
-(void)test1{
    //局部变量，截获值
    int a = 1;
    int(^ccCallBack)(void) = ^{
        int b = a + 1;
        return b;
    };
    a = 2;
    int res = ccCallBack();
    NSLog(@"result: %d",res);//2
}
-(void)test2{
    //局部静态变量，截获指针
   static int a = 1;
    int(^ccCallBack)(void) = ^{
        int b = a + 1;
        return b;
    };
    a = 3;
    int res = ccCallBack();
    NSLog(@"result: %d",res);//4
}
-(void)test3{
    //全局静态变量，不截获
    int(^ccCallBack)(void) = ^{
        int b = a + 1;
        return b;
    };
    int res = ccCallBack();
    NSLog(@"result: %d",res);//8
}

-(void)test4{
    //全局变量，不截获

     int(^ccCallBack)(void) = ^{
        int b = abc;
        return b;
    };
    abc = 11;
    int res = ccCallBack();
    NSLog(@"result: %d",res);//11
}
-(void)test5{
    //对象类型,连同所有权修饰符一期截获
    __strong id object = [NSObject new];
    id(^ccCallBack)(void) = ^{
        return object;//上面声明的时候是 __strong 修饰符，那么这里截获的也是带__strong修饰符的指针
    };
    id _object = ccCallBack();
    NSLog(@"result: %@",_object);
}
@end
