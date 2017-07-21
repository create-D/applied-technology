//
//  AppDelegate.m
//  30-本地推送
//
//  Created by 董立权 on 2017/7/21.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - 注册权限
/*
 UIUserNotificationTypeBadge:图标标记
 UIUserNotificationTypeSound:声音
 UIUserNotificationTypeAlert:弹窗
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //iOS8之后添加分类功能
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    //设置标识符
    category.identifier = @"category";
    //创建按钮
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    //按钮的标识符
    action.identifier = @"foreground";
    
    //iOS9增加方法 添加输入框
    action.behavior = UIUserNotificationActionBehaviorTextInput;
    
    
    //按钮的标题
    action.title = @"打开应用";
    //不打开手机 UIUserNotificationActivationModeBackground
    //打开手机 UIUserNotificationActivationModeForeground
    action.activationMode = UIUserNotificationActivationModeForeground;
    
    //创建按钮1
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    //按钮的标识符
    action1.identifier = @"background";
    //按钮的标题
    action1.title = @"稍后处理";
    //不打开手机 UIUserNotificationActivationModeBackground
    //打开手机 UIUserNotificationActivationModeForeground
    action1.activationMode = UIUserNotificationActivationModeBackground;
    
    //添加按钮
    [category setActions:@[action,action1] forContext:UIUserNotificationActionContextDefault];
    
    //设置通知的内容和信息
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObject:category]];
                                            
                                            
    //注册用户权限
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    //判断是否有本地通知
    UILocalNotification *localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotification){
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
//        label.backgroundColor = [UIColor blueColor];
//        label.text = [NSString stringWithFormat:@"%@",localNotification.userInfo];
//        label.numberOfLines = 0;
//        [self.window.rootViewController.view addSubview:label];
        [self jumpToViewWith:localNotification];
    };
    
    return YES;
}
//点按通知中的按钮时会调用
//identifier :按钮的标识符
//notification:本地推送通知

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    
}
//点按通知中的按钮时会调用
//identifier :按钮的标识符
//notification:本地推送通知
//responseInfo:用户在输入框中输入的文字
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler{
    
    if([identifier isEqualToString:@"foreground"]){
        NSLog(@"打开了应用");
    }else if([identifier isEqualToString:@"background"]){
        NSLog(@"稍后处理");
    }
    
    //获取用户输入的文字
    NSString *str = responseInfo[UIUserNotificationActionResponseTypedTextKey];
    //将文字发送给服务器 实现立即回复
    NSLog(@"%@",str);
    
    //让苹果预估方法运行时间 告诉苹果方法执行完毕
    completionHandler();
}

//接收到本地通知时调用 ->点击通知,要打开App时调用
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    NSLog(@"%@",notification.userInfo);
//    //调试:控制台 UI调试
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
//    label.backgroundColor = [UIColor blueColor];
//    label.text = [NSString stringWithFormat:@"%@",notification.userInfo];
//    label.numberOfLines = 0;
//    [self.window.rootViewController.view addSubview:label];
    [self jumpToViewWith:notification];
}
-(void)jumpToViewWith:(UILocalNotification *)localNotification {
    //获取通知中的详细信息
    NSDictionary *userInfo = localNotification.userInfo;
    //获取key的值
    NSUInteger index = [userInfo[@"key"] unsignedIntegerValue];
    //获取tabbat控制器
    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive){
        //程序在前台,不需要跳转
        return;
    }
    //跳转控制器
    tabVC.selectedIndex = index;
}


@end
