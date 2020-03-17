//
//  NSObject+Associated.m
//  CCTutorial
//
//  Created by CC on 2020/3/15.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "NSObject+Associated.h"
#import <objc/runtime.h>
@implementation NSObject(Associated)

- (void)setAname:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)aname {
    return objc_getAssociatedObject(self, @selector(name));
}
@end
