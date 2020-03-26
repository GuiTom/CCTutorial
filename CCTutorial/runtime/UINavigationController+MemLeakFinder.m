//
//  UINavigationController+MemLeakFinder.m
//  CCTutorial
//
//  Created by CC on 2020/3/26.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "UINavigationController+MemLeakFinder.h"
#import "NSObject+MethodSwizzling.h"
#import <objc/message.h>
@implementation UINavigationController (MemLeakFinder)
+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleSEL:@selector(swizzled_popViewControllerAnimated:) withSEL:@selector(popViewControllerAnimated:)];
    });
}
-(UIViewController*)swizzled_popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [self swizzled_popViewControllerAnimated:animated];
    void(*action)(id,SEL) = (void(*)(id,SEL))objc_msgSend;
    SEL funSel = NSSelectorFromString(@"willDealloc");
    action(vc, funSel);
    return vc;
}
@end
