//
//  AppDelegate.m
//  12-应用间跳转(转)
//
//  Created by 董立权 on 2017/7/18.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSLog(@"%@",url);
    //转换成字符串
    NSString *urlstr = url.absoluteString;
    //获取//范围
    NSRange range =[urlstr rangeOfString:@"//"];
    //获取跳转的字符串
    NSString *str = [urlstr substringFromIndex:range.location + range.length];
    //根据截取的字符串,跳转不同的界面
    self.str = str;
    //获取跟控制器
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    //跳转回跟控制器
    [nav popToRootViewControllerAnimated:NO];
    //获取控制器
    ViewController *vc = nav.childViewControllers[0];
    if([str containsString:@"page1"]){
        [vc performSegueWithIdentifier:@"page1" sender:nil];
    }else if([str containsString:@"page2"]){
        [vc performSegueWithIdentifier:@"page2" sender:nil];
    }
    //跳转控制器
    
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
