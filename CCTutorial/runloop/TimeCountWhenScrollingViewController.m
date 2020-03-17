//
//  TimeCountWhenScrolling.m
//  CCTutorial
//
//  Created by CC on 2020/3/16.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "TimeCountWhenScrollingViewController.h"

@interface TimeCountWhenScrollingViewController ()
@property(nonatomic,strong)UITextView *textView1;
@property(nonatomic,strong)UITextView *textView2;
@property(nonatomic,strong)NSTimer *timer1;
@property(nonatomic,strong)NSTimer *timer2;
@end

@implementation TimeCountWhenScrollingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView1 = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, 375, 300)];
    self.textView1.text = @"拖动这个文本框,你会发现Timer1停止计时";
    self.textView1.font =[UIFont systemFontOfSize:72];
    self.textView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textView1];
    self.timer1 = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(onTimer1) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
    self.textView2 = [[UITextView alloc] initWithFrame:CGRectMake(0, 400, 375, 300)];
    self.textView2.font =[UIFont systemFontOfSize:72];
    self.textView2.backgroundColor = [UIColor lightGrayColor];
    self.textView2.text = @"拖动这个文本框,你会发现Timer2不会停止计时";
    [self.view addSubview:self.textView2];
    self.timer2 = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(onTimer2) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer2 forMode:NSRunLoopCommonModes];
    
}
-(void)onTimer1{
    NSLog(@"%s",__func__);
}
-(void)onTimer2{
    NSLog(@"%s",__func__);
}
-(void)dealloc{
    [self.timer1 invalidate];
    [self.timer2 invalidate];
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
