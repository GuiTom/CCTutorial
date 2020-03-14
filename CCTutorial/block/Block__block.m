//
//  Block__block.m
//  CCTutorial
//
//  Created by CC on 2020/3/13.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "Block__block.h"

@implementation Block__block


-(void)test1{
    __block int c = 7;//如果要在block中进行赋值，就需要__block修饰符
     void(^ccCallBack)(void) = ^{
        //加了__block之后，block中的c实际上是一个结构体对象的成员
          NSLog(@"result: %d",c);
     };
    c = 3;
    ccCallBack();
 
}

-(void)test2{
    __block id obj = nil;//如果要在block中进行赋值，就需要__block修饰符
     id(^ccCallBack)(void) = ^{
        //加了__block之后，block中的obj实际上是一个结构体对象的成员
        NSLog(@"result:%@",obj);//NSObject
         return obj;
     };
     obj = [NSObject new];
     id res = ccCallBack();
     NSLog(@"result:%@",res);//NSObject
}
//__block修饰的变量在block里面被包装成结构体
//变量C变成了下面的对象
//struct __Block_byref_c_0 {
//  void *__isa;
//__Block_byref_c_0 *__forwarding;
// int __flags;
// int __size;
// int c;
//};

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
@end
