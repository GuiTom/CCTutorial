//
//  NSObject+Associated.h
//  CCTutorial
//
//  Created by CC on 2020/3/15.
//  Copyright © 2020 kayak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(Associated)

- (void)setAname:(NSString *)name;
- (NSString *)aname;

@end

NS_ASSUME_NONNULL_END
