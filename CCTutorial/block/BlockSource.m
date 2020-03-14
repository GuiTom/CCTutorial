//
//  BlockSource.m
//  CCTutorial
//
//  Created by CC on 2020/3/13.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "BlockSource.h"

@implementation BlockSource
-(void)myTest{
    int a = 1;
    int(^ccCallBack)(void) = ^{
        int b = a + 1;
        return b;
    };
    int res = ccCallBack();
    NSLog(@"result%d",res);
}
@end
