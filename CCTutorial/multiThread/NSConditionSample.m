//
//  NSConditionSample.m
//  CCTutorial
//
//  Created by CC on 2020/3/22.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSConditionSample.h"

@implementation NSConditionSample
{
    NSMutableArray *products;
    NSCondition *condition;
}
-(instancetype)init{
    if(self=[super init]){
        products = @[].mutableCopy;
        condition = [[NSCondition alloc] init];
      
    }
    return self;
}
-(void)test{
    [NSThread detachNewThreadSelector:@selector(consume) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(produce) toTarget:self withObject:nil];
}
-(void)consume{
   
   while (1) {
       [condition lock];
       if(products.count<=0){
           NSLog(@"商品已耗尽，等待生产者生产");
           [condition wait];
       }else {
           [products removeLastObject];
           NSLog(@"消费了一个产品,还剩%ld个",products.count);
       }
       [condition unlock];
   }
  
}
-(void)produce{
    while (1) {
        [condition lock];
        [products addObject:@"apple"];
        NSLog(@"生产了一个产品,共有库存%ld个",products.count);
        [condition signal];
        [condition unlock];
    }
   
}
@end
