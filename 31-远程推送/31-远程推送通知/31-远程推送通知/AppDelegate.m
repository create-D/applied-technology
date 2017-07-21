//
//  AppDelegate.m
//  31-远程推送通知
//
//  Created by 董立权 on 2017/7/21.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.请求用户授权
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    //2.获取deviceToken  向苹果发送服务
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    if(launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
        label.text = [NSString stringWithFormat:@"%@",launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
        label.numberOfLines = 0;
        [self.window.rootViewController.view addSubview:label];
    }
    
    return YES;
}

//当苹果加密成功后,返回deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",deviceToken);
    // <b4414893 ae9b7181 70dafb71 646c16bc be1d1696 76b429b5 33af9f77 c8eed356>
}
//当苹果加密失败,返回原因
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@",error);
}
//接收到了远程推送通知 程序在前台和后台运行时能够接受
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
}

@end
