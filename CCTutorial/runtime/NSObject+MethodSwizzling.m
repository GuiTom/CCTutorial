//
//  NSObject+NSObject_MethodSwizzling.m
//  CCTutorial
//
//  Created by CC on 2020/3/26.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (NSObject_MethodSwizzling)
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
