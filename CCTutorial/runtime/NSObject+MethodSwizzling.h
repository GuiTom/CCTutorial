//
//  NSObject+NSObject_MethodSwizzling.h
//  CCTutorial
//
//  Created by CC on 2020/3/26.
//  Copyright © 2020 kayak. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MethodSwizzling)
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;
@end

NS_ASSUME_NONNULL_END
