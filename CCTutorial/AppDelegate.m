//
//  AppDelegate.m
//  CCTutorial
//
//  Created by CC on 2020/3/13.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *navVC =[[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    return YES;
}




@end
