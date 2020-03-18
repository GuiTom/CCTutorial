//
//  UIViewController+MemLeakFinder.m
//  CCTutorial
//
//  Created by CC on 2020/3/18.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "UIViewController+MemLeakFinder.h"

#import <objc/runtime.h>

@implementation UIViewController (MemLeakFinder)
+(void)load{
    NSLog(@"交换方法 %@",NSStringFromClass([self class]));
    [self swizzleSEL:@selector(swizzled_viewDidDisappear:) withSEL:@selector(viewDidDisappear:)];
}
- (void)swizzled_viewDidDisappear:(BOOL)animated {
    [self swizzled_viewDidDisappear:animated];
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
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {

    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }

}
@end
