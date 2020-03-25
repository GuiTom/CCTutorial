//
//  EventTransmitViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/23.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "EventTransmitViewController.h"
#import "ViewA.h"
#import "ViewB.h"
@interface EventTransmitViewController ()

@end

@implementation EventTransmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ViewA *viewA = [[ViewA alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];

    viewA.backgroundColor = [UIColor redColor];
    ViewB *viewB = [[ViewB alloc] initWithFrame:CGRectMake(20, 10, 150, 200)];
    viewB.backgroundColor = [UIColor yellowColor];
    
    UITapGestureRecognizer *tapGesA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickViewA:)];
    UITapGestureRecognizer *tapGesB = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickViewB:)];
    [viewA addGestureRecognizer:tapGesA];
//    [viewB addGestureRecognizer:tapGesB];//
    [self.view addSubview:viewA];
    [viewA addSubview:viewB];
    //思考题:为什么一个不加事件响应函数的UIButton 不可以事件穿透，而不加响应事件响应函数的UIView不可以事件穿透？
  
}
-(void)onClickViewA:(UITapGestureRecognizer*)tapGes{
    NSLog(@"%s %@",__FUNCTION__,tapGes.view);
    
}
-(void)onClickViewB:(UITapGestureRecognizer*)tapGes{
    NSLog(@"%s %@",__FUNCTION__,tapGes.view);
//    UIResponder *resp = tapGes.view;
//    while (resp) {
//        NSLog(@"resp: %@",resp);
//        resp = resp.nextResponder;
//    }
    
}
@end
