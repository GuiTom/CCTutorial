//
//  CrashDefenderViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/17.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "CrashDefenderViewController.h"
#import "CrashDefender.h"
@interface CrashDefenderViewController ()
@property(nonatomic,strong)UIButton *button;
@end

@implementation CrashDefenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[CrashDefender sharedInstance] startCaptureCrash];
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 100, 30)];
    [self.button setTitle:@"制造崩溃" forState:UIControlStateNormal];
    //仅仅能防止一次崩溃
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onClick:(UIButton*)sender{
    NSString *info = nil;
    NSDictionary *dic = @{
        @"a":info
    };
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
