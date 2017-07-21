//
//  ViewController.m
//  30-本地推送
//
//  Created by 董立权 on 2017/7/21.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    //创建本地推送通知
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    
//    //设置发送通知的时间
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    //发送通知的消息体
//    localNotification.alertBody = @"发送通知的消息体";
//    //发送通知的声音
//    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    //在消息体上添加一行内容
//    localNotification.alertTitle = @"标题";
//    //iOS10没有效果 iOS10之前在锁屏时显示 滑动以查看后面文字
//    localNotification.alertAction = @"锁屏时调用";
//    //图标标记的数字 默认值就是0,如果是0,表示没有改变
//    localNotification.applicationIconBadgeNumber = 10;
//    
//    //本地推送通知携带的信息
//    localNotification.userInfo = @{@"content":@"hehe",@"key":@(2)};
//    
//    
//    //发送本地推送通知 -> 加入通知的调度池
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    
//    
//}

- (IBAction)page1:(id)sender {
    [self postLocalNotificationWithAlertBody:@"page1" andUserInfo:@{@"content":@"session",@"key":@(1)}];
}

- (IBAction)page2:(id)sender {
    [self postLocalNotificationWithAlertBody:@"page2" andUserInfo:@{@"content":@"session",@"key":@(2)}];
}
-(void)postLocalNotificationWithAlertBody:(NSString *)alertBody andUserInfo:(NSDictionary *)userInfo {
    //创建本地推送通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    //设置发送通知的时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //发送通知的消息体
    localNotification.alertBody = alertBody;
    //发送通知的声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //设置分类
    localNotification.category = @"category";
    
    //本地推送通知携带的信息
    localNotification.userInfo = userInfo;

    //发送本地推送通知 -> 加入通知的调度池
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


@end
