//
//  CCProxy.h
//  CCTutorial
//
//  Created by CC on 2020/3/25.
//  Copyright © 2020 kayak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCProxy : NSProxy
@property(nonatomic,weak)id target;
@end

NS_ASSUME_NONNULL_END
