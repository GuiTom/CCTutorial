//
//  HomeViewController.m
//  CCKit
//
//  Created by CC on 2020/1/16.
//  Copyright © 2020 CC. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataSource.h"
#import "BlockTransmitViewController.h"
#import "Block__blockViewController.h"
#import "Block_TypeViewController.h"
#import "BlockCycleRetainViewController.h"
#import "MethodForward.h"
#import "MethodSwizling.h"
#import "NSObject+Associated.h"
#import "ThreadKeepaliveViewController.h"
#import "TimeCountWhenScrollingViewController.h"
#import "CrashDefenderViewController.h"
#import "FluencyMonitorVC.h"
#import "MemoryLeakViewController.h"
#import "GCDQueue.h"
#import "Pthread.h"
#import "NSThreadSample.h"
#import "NSOpreationSample.h"
#import "NSLockSample.h"
#import "SemaphoreSample.h"
#import "NSConditionSample.h"
#import "EventTransmitViewController.h"
#import "EventResponseAreaChangeViewController.h"
#import "TimerLeakViewController.h"
#import "AsyncRenderViewController.h"
#import "TableViewAutoSizeController.h"
#import "RoundConerViewController.h"
#import "NSConditonLockSample.h"
#import "MachPortCommulicationVC.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *table;

@end

@implementation HomeViewController
static NSString *cellId = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
   
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.table];
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [HomeDataSource shareInstance].dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *cells = [[HomeDataSource shareInstance].dataSource objectAtIndex:section][@"cells"];
    
    return cells.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSDictionary *cellData = [HomeDataSource shareInstance].dataSource[indexPath.section][@"cells"][indexPath.row];
    cell.textLabel.text = cellData[@"title"];
    cell.textLabel.numberOfLines = 0;
    return cell;
}
#pragma mark UIScrollViewDelegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [UILabel new];
    NSString *headerTitle = [HomeDataSource shareInstance].dataSource[section][@"header"];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor grayColor];
    label.text = headerTitle;
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 60.0f;
    }else {
        return 44.0f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSDictionary *sectiondata = [HomeDataSource shareInstance].dataSource[indexPath.section];
   NSArray *cellDatas = sectiondata[@"cells"];
   NSDictionary *cellData = cellDatas[indexPath.row];
   NSString *title = cellData[@"title"];
   NSString *header = sectiondata[@"header"];
    if([header isEqualToString:@"block相关"]){
        if([title isEqualToString:@"block的本质"]){
            NSLog(@"\n在终端里面cd到本工程中的'block'文件夹下,运行 clang -rewrite-objc BlockSource.m,查看BlockSource.cpp源码，搜索myTest,定位到block的实现部分");
        }else if([title isEqualToString:@"block的变量截取"]){
            [self.navigationController pushViewController:[BlockTransmitViewController new] animated:YES];
        }else if([title isEqualToString:@"__block修饰符"]){
          [self.navigationController pushViewController:[Block__blockViewController new] animated:YES];
        }else if([title isEqualToString:@"block按存储区分类"]){
          [self.navigationController pushViewController:[Block_TypeViewController new] animated:YES];
        }else if([title isEqualToString:@"block循环引用造成内存泄露的例子"]){
          [self.navigationController pushViewController:[BlockCycleRetainViewController new] animated:YES];
        }
        
    }else if([header isEqualToString:@"runtime相关"]){
        if([title isEqualToString:@"消息转发流程"]){
            [[MethodForward new] test];
        }else if([title isEqualToString:@"消息转发代理解决timer内存泄露问题"]){
            [self.navigationController pushViewController:[TimerLeakViewController new] animated:YES];
        }else if([title isEqualToString:@"方法动态交换"]){
            [[MethodSwizling new] test1];
        }else if([title isEqualToString:@"内测泄露检测"]){
            [self.navigationController pushViewController:[MemoryLeakViewController new] animated:YES];
        }else if([title isEqualToString:@"关联对象"]){
            NSObject *obj = [NSObject new];
            obj.aname = @"abc";
            NSLog(@"obj.name:%@",obj.aname);
        }
    }else if([header isEqualToString:@"runloop相关"]){
        if([title isEqualToString:@"线程保活"]){
            [self.navigationController pushViewController:[ThreadKeepaliveViewController new] animated:YES];
        }else if([title isEqualToString:@"边滑动边计时"]){
            [self.navigationController pushViewController:[TimeCountWhenScrollingViewController new] animated:YES];
        }else if([title isEqualToString:@"性能监测"]){
           
            [self.navigationController pushViewController:[FluencyMonitorVC new] animated:YES];
        }else if([title isEqualToString:@"APP保活"]){
//             sleep(3);
            [self.navigationController pushViewController:[CrashDefenderViewController new] animated:YES];
        }
    }else if([header isEqualToString:@"UI相关"]){
        if([title isEqualToString:@"UI事件传递内部实现"]){
            [self.navigationController pushViewController:[EventTransmitViewController new] animated:YES];
        }else if([title isEqualToString:@"UI事件传递之改变事件响应区域"]){
            [self.navigationController pushViewController:[EventResponseAreaChangeViewController new] animated:YES];
        }else if([title isEqualToString:@"异步渲染(卡顿优化)"]){
            [self.navigationController pushViewController:[AsyncRenderViewController new] animated:YES];
        }else if([title isEqualToString:@"高性能加圆角"]){
            
            [self.navigationController pushViewController:[RoundConerViewController new] animated:YES];
        }
            
    }
    else if([header isEqualToString:@"多线程"]){
        if([title isEqualToString:@"pthread"]){
            [[Pthread alloc] test1];
        }if([title isEqualToString:@"NSThread"]){
            [[[NSThreadSample alloc] init] test3];
        }else if([title isEqualToString:@"GCD队列分类(全局并发队列)"]){
            [[GCDQueue alloc] globalQueue];
        }else if([title isEqualToString:@"GCD队列分类(主串行队列)"]){
            [[GCDQueue alloc] mainQueue];
        }else if([title isEqualToString:@"GCD队列分类(自建串行队列)"]){
            [[GCDQueue alloc] serialQueue];
        }else if([title isEqualToString:@"GCD队列分类(异步执行自建并发队列)"]){
            [[GCDQueue alloc] asyncConcurrentQueue];
        }else if([title isEqualToString:@"GCD队列分类(同步执行自建并发队列)"]){
            [[GCDQueue alloc] syncConcurrentQueue];
        }else if([title isEqualToString:@"GCD dispatch_group_notify"]){
            [[GCDQueue alloc] dispatchGroupNotify];
        }else if([title isEqualToString:@"GCD dispatch_group_wait"]){
            [[GCDQueue alloc] dispatchGroupWait];
        }else if([title isEqualToString:@"GCD dispatch_apply"]){
            [[GCDQueue alloc] dispatchApply];
        }else if([title isEqualToString:@"GCD dispatch_barrier_async"]){
            [[GCDQueue alloc] dispatch_barrier_async];
        }else if([title isEqualToString:@"CGD异步"]){
            [[GCDQueue alloc] async];
        }else if([title isEqualToString:@"CGD同步"]){
            [[GCDQueue alloc] sync];
        }else if([title isEqualToString:@"CGD暂停继续"]){
            [[GCDQueue alloc] suspendAndResume];
        }else if([title isEqualToString:@"CGD队列死锁的例子"]){
            [[GCDQueue alloc] deadLock2];
        }else if([title isEqualToString:@"线程同步之互斥锁"]){
            [[[NSLockSample alloc] init] test];
        }else if([title isEqualToString:@"线程同步之条件锁NSCondition"]){
            [[[NSConditionSample alloc] init] test];
        }else if([title isEqualToString:@"线程同步之条件锁NSConditionLock"]){
            [[[NSConditonLockSample alloc] init] test];
        }else if([title isEqualToString:@"线程同步之信号量"]){
            [[[SemaphoreSample alloc] init] test];
        }else if([title isEqualToString:@"NSOpreation"]){
            [[[NSOpreationSample alloc] init] test4];
        }else if([title isEqualToString:@"线程通信之NSPort"]){
            [self.navigationController pushViewController:[MachPortCommulicationVC new] animated:YES];
        }
    }
}

@end
