//
//  UIViewController+MemLeakFinder.m
//  CCTutorial
//
//  Created by CC on 2020/3/18.
//  Copyright © 2020 kayak. All rights reserved.
//
#import "NSObject+MethodSwizzling.h"
#import "UIViewController+MemLeakFinder.h"

#import <objc/runtime.h>

@implementation UIViewController (MemLeakFinder)
//+(void)load{
//    NSLog(@"交换方法 %@",NSStringFromClass([self class]));
//    [self swizzleSEL:@selector(swizzled_viewDidDisappear:) withSEL:@selector(viewDidDisappear:)];
//}
+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleSEL:@selector(swizzled_dismissViewControllerAnimated: completion:) withSEL:@selector(dismissViewControllerAnimated: completion:)];
    });
}
-(void)swizzled_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self swizzled_dismissViewControllerAnimated:flag completion:completion];
    [self willDealloc];
}

-(void)willDealloc{
  __weak id weakSelf = self;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       __strong id strongSelf = weakSelf;
      if(strongSelf){
          NSLog(@"内存已经泄露拉 %@",NSStringFromClass([strongSelf class]));
      }
   });
}

@end
