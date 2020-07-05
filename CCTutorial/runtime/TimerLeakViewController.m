//
//  TimerLeakViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/25.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "TimerLeakViewController.h"
#import "CCProxy.h"
@interface TimerLeakViewController ()
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation TimerLeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger useMethod = 2;
    if(useMethod == 1){
        //1.self 和timer发生循环强引用
        self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(test1) userInfo:nil repeats:YES];
    }else {
        //2.self和timer之间的调用让proxy去转发，proxy弱引用 self
        CCProxy *proxy = [CCProxy alloc];
        proxy.target = self;
        self.timer = [NSTimer timerWithTimeInterval:1.0f target:proxy selector:@selector(test1) userInfo:nil repeats:YES];
    
    }
    //RunLoop会对timer强引用
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    //操作提示
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
    tipLabel.text = @"进入页面后，timer开始工作，如果采用的是第一种方法，\n退出页面后，timer不会自动销毁，继续打印\n若采用的是第二钟方法代理调用，退出页面后，timer自动销毁停止调用打印";
    tipLabel.numberOfLines = 0;
    [tipLabel sizeToFit];
    [self.view addSubview:tipLabel];
    self.view.backgroundColor = [UIColor grayColor];
}
-(void)test1{
    NSLog(@"%s",__FUNCTION__);
}
-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
    [self.timer invalidate];//将timer从NSRunloop中移除了
    
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
