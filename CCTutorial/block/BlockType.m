//
//  BlockType.m
//  CCTutorial
//
//  Created by CC on 2020/3/14.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "BlockType.h"

@implementation BlockType
-(void)test1{
    //1.不访问block之外的变量的block为全局block
    void (^block1)(void) = ^{
        NSLog(@"这是个全局block");
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
-(void)test2{
  
    //2.访问外部变量的block为栈block
    int x = 1;
    NSLog(@"block3 class: %@", NSStringFromClass([^{
        NSLog(@"%d",x);
    } class]));//栈block
  
}
-(void)test3{
    
    //3.对栈block进行复制(赋值)的block为堆block
    int localC = 1231;//不论是基本数据类型还是对象类型，
    void(^block3)(void) = ^{//copy操作
         NSLog(@"%d",localC);
    };
    NSLog(@"block5 class: %@", NSStringFromClass([block3 class]));//堆block

}
-(void)test4{
    __block int localC = 1231;//不论是基本数据类型还是对象类型，
    void(^block3)(void) = ^{//copy操作
         NSLog(@"%d",localC);
    };
    NSLog(@"block5 class: %@", NSStringFromClass([block3 class]));//堆block
    void (^block1)(void) = ^{//这是全局block
    };
    NSLog(@"block4 class: %@", NSStringFromClass([block1 class]));//全局block
    
    [self logBlockClassName:^{NSLog(@"%d",localC);}];//栈block，因为传参数时进行了copy操作
    void(^block4)(void) = ^{
    };
    NSLog(@"block6  class: %@", NSStringFromClass([block4 class]));//全局block
    block4 = block1;
    NSLog(@"block7  class: %@", NSStringFromClass([block4 class]));//全局block
    block4 = block3;
    NSLog(@"block8  class: %@", NSStringFromClass([block4 class]));//堆block
}
-(void)logBlockClassName:(id)blc
{
    NSLog(@"block class: %@", NSStringFromClass([blc class]));
}
@end
