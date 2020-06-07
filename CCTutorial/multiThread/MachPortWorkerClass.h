//
//  MachPortWorkerClass.h
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/7.
//  Copyright © 2020 kayak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MachPortWorkerClass : NSObject
@property(nonatomic,strong)NSPort *myPort;
- (void)sendPortMessage;
- (void)launchThreadWithPort:(NSPort *)port;
@end

NS_ASSUME_NONNULL_END
