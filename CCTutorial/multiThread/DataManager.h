//
//  DataManager.h
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/27.
//  Copyright © 2020 kayak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject
+(instancetype)sharedManager;
-(id)getVaueForKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
