//
//  AppDelegate.m
//  17-通讯录不带界面
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    //判断状态
    if(status == kABAuthorizationStatusNotDetermined) {
        //创建通讯录
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
        //请求用户授权
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if(error){
                NSLog(@"%@",error);
            }
            if(granted){
                NSLog(@"请求授权成功");
            }
        });
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
