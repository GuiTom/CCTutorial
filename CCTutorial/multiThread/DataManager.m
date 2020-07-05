//
//  DataManager.m
//  CCTutorial
//
//  Created by Jerry Chen on 2020/6/27.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
{
   
    dispatch_queue_t queue;
}
static NSMutableDictionary *dataDict ;
+(instancetype)sharedManager{
    static DataManager *manger;
    dispatch_once_t once;
    dispatch_once(&once, ^{
        manger = [[DataManager alloc] init];
    });
    return manger;
}
-(instancetype)init{
    if(self = [super init]){
        dataDict = @[].mutableCopy;
        queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}
-(id)getVaueForKey:(NSString*)key{
    __block id value;
    dispatch_sync(queue, ^{
        value = [dataDict objectForKey:key];
    });
    return value;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    dispatch_barrier_async(queue, ^{
        [dataDict setValue:value forKey:key];
    });
}
@end
