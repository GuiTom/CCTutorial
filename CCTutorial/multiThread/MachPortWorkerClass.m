//
//  MachPortWorkerClass.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/7.
//  Copyright © 2020 kayak. All rights reserved.
//


#import "MachPortWorkerClass.h"

@interface MachPortWorkerClass() <NSMachPortDelegate> {
    NSPort *remotePort;
    
}
@end

#define kMsg1 100

#define kMsg2 102
@implementation MachPortWorkerClass


- (void)launchThreadWithPort:(NSPort *)port {

    @autoreleasepool {

        //1. 保存主线程传入的port
        remotePort = port;

        //2. 设置子线程名字
        [[NSThread currentThread] setName:@"MyWorkerClassThread"];

        //3. 开启runloop
        [[NSRunLoop currentRunLoop] run];

        //4. 创建自己port
        _myPort = [NSPort port];

        //5.
        _myPort.delegate = self;

        //6. 将自己的port添加到runloop
        //作用1、防止runloop执行完毕之后推出
        //作用2、接收主线程发送过来的port消息
        [[NSRunLoop currentRunLoop] addPort:_myPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];



    }
}

/**
 *   完成向主线程发送port消息
 */
- (void)sendPortMessage {

    NSMutableArray *array  =[[NSMutableArray alloc]initWithArray:@[@"1",@"2"]];
    //发送消息到主线程，操作1
    [remotePort sendBeforeDate:[NSDate date]
                         msgid:kMsg1
                    components:array
                          from:_myPort
                      reserved:0];
}


#pragma mark - NSPortDelegate

/**
 *  接收到主线程port消息
 */
- (void)handlePortMessage:(NSPortMessage *)message
{
    NSLog(@"接收到主线程的消息...\n");

 
}

/**
 *  如果实现了这个协议方法，就不会调用handlePortMessage方法
 *  msg 其实还是NSPortMessage,与handlePortMessage等价
 */
//- (void)handleMachMessage:(void *)msg{
//    NSLog(@"%s",__FUNCTION__);
//    
//}
@end
