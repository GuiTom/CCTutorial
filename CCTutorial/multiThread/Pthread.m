//
//  Pthread.m
//  CCTutorial
//
//  Created by CC on 2020/3/22.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "Pthread.h"
#include <pthread.h>
static pthread_t thread = NULL;

@implementation Pthread
-(void)test1{
    pthread_create(&thread, NULL, &myThread, "myThread");
}
void *myThread(void *data){
    NSLog(@"pthread 线程%@",[NSThread currentThread]);
    
    pthread_exit(&thread);
}

@end
