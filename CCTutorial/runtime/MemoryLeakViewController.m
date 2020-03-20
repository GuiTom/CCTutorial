//
//  MemoryLeakViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/18.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "MemoryLeakViewController.h"
#import <objc/runtime.h>
@interface MemoryLeakViewController ()

@end
static UIViewController *vc = nil;
@implementation MemoryLeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    vc = self;//添加强引用
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30)];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    label.text = @"点击返回按钮，2秒过后，控制台会打印测试结果。\n注意如果泄露对象是你不再使用的对象，那才算真正的内存泄露";
    [label sizeToFit];
 
}

@end
