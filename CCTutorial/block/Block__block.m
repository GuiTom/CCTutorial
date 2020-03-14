//
//  Block__block.m
//  CCTutorial
//
//  Created by CC on 2020/3/13.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "Block__block.h"

@implementation Block__block
//__block修饰的变量在block里面被包装成结构体
//变量C变成了下面的对象
//struct __Block_byref_c_0 {
//  void *__isa;
//__Block_byref_c_0 *__forwarding;
// int __flags;
// int __size;
// int c;
//};

-(void)test1{
    //1.不访问block之外的变量的block为全局block
    void (^block1)(void) = ^{
        
    };
    NSLog(@"block1 class: %@", NSStringFromClass([block1 class]));//全局block
    NSLog(@"block2 class: %@", NSStringFromClass([^{} class]));//全局block
    //2.访问外部变量的block为栈block
    int x = 1;
    
    NSLog(@"block3 class: %@", NSStringFromClass([^{
        NSLog(@"%d",x);
    } class]));//栈block
    //3.对栈block进行复制(赋值)的block为堆block
    __block int localC = 1231;//不论是基本数据类型还是对象类型，
     void(^block3)(void) = ^{
         NSLog(@"%d",localC);
    };
    NSLog(@"block4 class: %@", NSStringFromClass([block3 class]));//堆block
   
 
}

//obj变成了下面的对象
//struct __Block_byref_obj_1 {
//  void *__isa;
//__Block_byref_obj_1 *__forwarding;
// int __flags;
// int __size;
// void (*__Block_byref_id_object_copy)(void*, void*);
// void (*__Block_byref_id_object_dispose)(void*);
// id obj;
//};
-(void)test2{
    __block id obj = nil;//如果要在block中进行赋值，就需要__block修饰符
     id(^ccCallBack)(void) = ^{
        //加了__block之后，block中的obj实际上是一个结构体对象的成员
         return obj;
     };
     obj = [NSObject new];
     id res = ccCallBack();
     NSLog(@"result:%@",obj);//NSObject
     NSLog(@"result:%@",res);//NSObject
}

@end
