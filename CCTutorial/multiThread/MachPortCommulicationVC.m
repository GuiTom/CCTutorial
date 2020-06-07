//
//  MachPortCommulicationVC.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/7.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "MachPortCommulicationVC.h"
#import "MachPortWorkerClass.h"
@interface MachPortCommulicationVC ()<NSMachPortDelegate>
@property(nonatomic,strong)MachPortWorkerClass *worker;
@property(nonatomic,strong)NSPort *myPort;

@end

@implementation MachPortCommulicationVC
#define kMsg1 100
#define kMsg2 101

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initButtons];
    [self initPort];
}
-(void)initButtons{
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *buttonA = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    [buttonA setTitle:@"子线程向主线程发消息" forState:UIControlStateNormal];
    [buttonA addTarget:self action:@selector(onClickButtonA:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonA];
    UIButton *buttonB = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 200, 30)];
    [buttonB setTitle:@"主线程向子线程发消息" forState:UIControlStateNormal];
    [buttonB addTarget:self action:@selector(onClickButtonB:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonB];
}
-(void)onClickButtonA:(UIButton*)sender{
    [self.worker sendPortMessage];
}
-(void)onClickButtonB:(UIButton*)sender{
//    [self.worker.myPort sendBeforeDate:[NSDate date] msgid:kMsg2 components:@[@"3",@"4"].mutableCopy from:self.myPort reserved:0];
    //向子线的port发送消息
    [self.worker.myPort sendBeforeDate:[NSDate date]
                         msgid:kMsg2
                            components:@[@"3",@"4"].mutableCopy
                                  from:self.myPort
                      reserved:0];
}
-(void)initPort{
    //1. 创建主线程的port
    // 子线程通过此端口发送消息给主线程
    NSPort *myPort = [NSMachPort port];

    //2. 设置port的代理回调对象
    myPort.delegate = self;
    self.myPort = myPort;
    //3. 把port加入runloop，接收port消息
    [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];

    NSLog(@"---myport %@", myPort);
    //4. 启动次线程,并传入主线程的port
    self.worker = [[MachPortWorkerClass alloc] init];
    [NSThread detachNewThreadSelector:@selector(launchThreadWithPort:)
                             toTarget:self.worker
                           withObject:myPort];
}


/**
 *  如果实现了这个协议方法，就不会调用handlePortMessage方法
 *  msg 其实还是NSPortMessage,与handlePortMessage等价
 */
//- (void)handleMachMessage:(void *)msg{
//    NSLog(@"%s",__FUNCTION__);
//
//}
/**
 接受到子线程的消息
 */
- (void)handlePortMessage:(NSMessagePort*)message{

    NSLog(@"接到子线程传递的消息！%@",message);

    //1. 消息id
    NSUInteger msgId = [[message valueForKeyPath:@"msgid"] integerValue];

    //2. 当前主线程的port
    NSPort *localPort = [message valueForKeyPath:@"localPort"];

    //3. 接收到消息的port（来自其他线程）
    NSPort *remotePort = [message valueForKeyPath:@"remotePort"];

    if (msgId == kMsg1)
    {
        [remotePort sendBeforeDate:[NSDate date]
                                     msgid:kMsg2
                                components:nil
                                      from:localPort
                                  reserved:0];
       

    } else if (msgId == kMsg2){
        NSLog(@"操作2....\n");
    }
}


@end
