//
//  EventResponseAreaChangeViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/24.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "EventResponseAreaChangeViewController.h"
#import "ViewC.h"
@interface EventResponseAreaChangeViewController ()

@end

@implementation EventResponseAreaChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ViewC *view = [[ViewC alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickViewC:)];
    [view addGestureRecognizer:tapGes];
}
-(void)onClickViewC:(UITapGestureRecognizer*)tapGes{
     NSLog(@"%s %d",__FUNCTION__,__LINE__);
    NSLog(@"%@",tapGes.view);
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
