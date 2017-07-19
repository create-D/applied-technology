//
//  ViewController.m
//  21-距离传感器
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //打开距离传感器(默认是关闭)
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    //接受距离传感器的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChangeNotification) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

-(void)proximityStateDidChangeNotification {
    if([UIDevice currentDevice].proximityState == YES){
        NSLog(@"有人靠近");
    }else {
        NSLog(@"走了");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
