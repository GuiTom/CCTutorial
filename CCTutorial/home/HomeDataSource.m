
//
//  HomeDataSource.m
//  CCKit
//
//  Created by CC on 2020/1/16.
//  Copyright © 2020 CC. All rights reserved.
//

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
                        @{@"title":@"方法交换"},
                        @{@"title":@"weak的实现"},
                        @{@"title":@"内测泄露检测"},
                ]
            },
            @{
                  @"header":@"runloop相关",
                  @"cells":@[
                          @{@"title":@"边滑动边计时"},
                          @{@"title":@"性能监测"},
                          @{@"title":@"APP保活"},
                  ]
              },
            @{
                  @"header":@"UI相关",
                  @"cells":@[
                          @{@"title":@"UI时间传递"},
                          @{@"title":@"响应者链"},
                          @{@"title":@"异步渲染"},
                  ]
              },
            @{
                  @"header":@"多线程相关",
                  @"cells":@[
                          @{@"title":@"GCD队列分类"},
                          @{@"title":@"CGD同步与异步"},
                          @{@"title":@"线程同步之信号量"},
                          @{@"title":@"线程同步之互斥锁"},
                  ]
              }
        ].mutableCopy;
    }
}
@end
