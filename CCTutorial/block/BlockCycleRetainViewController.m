//
//  BlockCycleRetainViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/14.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "BlockCycleRetainViewController.h"
int a = 7;
@interface BlockCycleRetainViewController ()
@property(nonatomic,copy)void(^block)(void);

@end

@implementation BlockCycleRetainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //self变量默认是带__strong修饰符的
    self.block=^{
        NSLog(@"%@",self.view);
    };
//    __weak typeof(self)weakSelf = self;
//    self.block=^{
//          NSLog(@"%@",weakSelf.view);
//    };
}
-(void)viewDidDisappear:(BOOL)animated{
    //进入本页面然后退出本页面会看到内存泄露的打印
    __weak typeof(self)weakSelf = self;
    NSLog(@"本对象的内存地址是%p",self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%d",a);
        NSLog(@"%@",weakSelf);
        if(weakSelf){
            NSLog(@"self指针还没销毁，说明内存已经泄露啦");
            NSLog(@"weakSelf指向的地址是%p",weakSelf);
        }else {//注释掉循环强引那一行用会走这里
            NSLog(@"self指针已经销毁，说明内存没有泄露");
            NSLog(@"weakSelf指向的地址是%p",weakSelf);
        }
    });
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
