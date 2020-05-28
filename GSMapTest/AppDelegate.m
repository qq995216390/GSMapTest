//
//  AppDelegate.m
//  GSMapGD
//
//  Created by GS on 2020/5/27.
//  Copyright © 2020 YY. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if (@available(iOS 13, *)) {
    }else{
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = GSWhite_Color;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }


    [AMapServices sharedServices].apiKey = @"2b9b12e992c01584a2cb04dbbbb034d8";

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

