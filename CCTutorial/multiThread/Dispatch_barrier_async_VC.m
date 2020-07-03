//
//  Dispatch_barrier_async_VC.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/27.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "Dispatch_barrier_async_VC.h"
#import "DataManager.h"
@interface Dispatch_barrier_async_VC ()

@end

@implementation Dispatch_barrier_async_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurentQueue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<100; i++) {
        if(i%5){
            dispatch_async(concurrentQueue, ^{
                [[DataManager sharedManager] setValue:@"value1" forKey:@"key1"];
            });
            dispatch_async(concurrentQueue, ^{
                [[DataManager sharedManager] setValue:@"value2" forKey:@"key1"];
            });
        }else {
            dispatch_async(concurrentQueue, ^{
                [[DataManager sharedManager] getVaueForKey:@"key1"];
            });
        }
    }
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
