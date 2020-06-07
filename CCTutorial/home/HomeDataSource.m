
//
//  HomeDataSource.m
//  CCKit
//
//  Created by CC on 2020/1/16.
//  Copyright © 2020 CC. All rights reserved.
//
#import <objc/message.h>
#import "HomeDataSource.h"
@interface HomeDataSource()

@end
@implementation HomeDataSource
+(instancetype)shareInstance{
    static HomeDataSource * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HomeDataSource alloc] init];
    });
  
    return instance;
}
-(instancetype)init{
    if(self = [super init]){
        [self initDataSource];
    }
    return self;
}
-(void)initDataSource{
    if(!_dataSource){
        _dataSource = @[
            @{
                @"header":@"UI相关",
                @"cells":@[
                        @{@"title":@"UI事件传递内部实现"},
                        @{@"title":@"UI事件传递之改变事件响应区域"},
                        @{@"title":@"异步渲染(卡顿优化)"},
                        @{@"title":@"高性能加圆角"},
                        ]
                },
            @{
                @"header":@"block相关",
                @"cells":@[
                        @{@"title":@"block的本质"},
                        @{@"title":@"block按存储区分类"},
                        @{@"title":@"block的变量截取"},
                        @{@"title":@"__block修饰符"},
                        @{@"title":@"block循环引用造成内存泄露的例子"},
                        
                ]
            },
            @{
                @"header":@"runtime相关",
                @"cells":@[
                        @{@"title":@"runtime相关API"},
                        @{@"title":@"消息转发流程"},
                        @{@"title":@"消息转发代理解决timer内存泄露问题"},
                        @{@"title":@"方法动态交换"},
                        @{@"title":@"关联对象"},
                        @{@"title":@"内测泄露检测"},
                ]
            },
            @{
                  @"header":@"runloop相关",
                  @"cells":@[
                          @{@"title":@"线程保活"},
                          @{@"title":@"边滑动边计时"},
                          @{@"title":@"性能监测"},
                          @{@"title":@"APP保活"},
                  ]
              },

            @{
                  @"header":@"多线程",
                  @"cells":@[
                          @{@"title":@"pthread"},
                          @{@"title":@"NSThread"},
                          @{@"title":@"GCD队列分类(全局并发队列)"},
                          @{@"title":@"GCD队列分类(主串行队列)"},
                          @{@"title":@"GCD队列分类(自建串行队列)"},
                          @{@"title":@"GCD队列分类(异步执行自建并发队列)"},
                          @{@"title":@"GCD队列分类(同步执行自建并发队列)"},
                          @{@"title":@"GCD dispatch_group_notify"},
                          @{@"title":@"GCD dispatch_group_wait"},
                          @{@"title":@"GCD dispatch_apply"},
                          @{@"title":@"GCD dispatch_barrier_async"},
                          @{@"title":@"CGD暂停继续"},
                          @{@"title":@"CGD异步"},
                          @{@"title":@"CGD同步"},
                          @{@"title":@"CGD队列死锁的例子"},
                          @{@"title":@"线程同步之互斥锁"},
                          @{@"title":@"线程同步之条件锁NSCondition"},
                          @{@"title":@"线程同步之条件锁NSConditionLock"},
                          @{@"title":@"线程同步之信号量"},
                          @{@"title":@"NSOpreation"},
                          @{@"title":@"线程通信之NSPort"},
                  ]
              }
        ].mutableCopy;
    }
}
@end
