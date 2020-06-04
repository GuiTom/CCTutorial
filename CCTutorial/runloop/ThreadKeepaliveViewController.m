//
//  ThreadKeepaliveViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/16.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "ThreadKeepaliveViewController.h"

@interface ThreadKeepaliveViewController ()
@property(nonatomic,strong)NSThread *myThread;
@end

@implementation ThreadKeepaliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.myThread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [self.myThread start];
}
-(void)run{
    // 只要往RunLoop里面添加Source\Timer\Observer中的任意一种，就能保持runloop不退出销毁
    //NSPort 是 source 的一种
    [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
}
-(void)test{
    NSLog(@"%s",__func__);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(test) onThread:self.myThread withObject:nil waitUntilDone:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
