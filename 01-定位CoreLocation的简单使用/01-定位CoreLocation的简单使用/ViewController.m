//
//  ViewController.m
//  01-定位CoreLocation的简单使用
//
//  Created by 董立权 on 2017/7/16.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
//用于定位的框架
#import <CoreLocation/CoreLocation.h>
//CoreLocation框架中所有数据类型的前缀都是CL
//CoreLocation中使用CLLocationManager对象来做用户定位

@interface ViewController ()<CLLocationManagerDelegate>
//位置管理者
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建位置管理者
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    //记录成员变量
    self.locationManager = manager;
    
    //在iOS8之前,只需要导入CoreLocation 会自动申请权限
    //在iOS8之后需要程序员手写
    //2.请求用户授权  必须要配置info.plist文件
    //请求app始终授权 无论程序在前台还是在后台运行 都可以定位
//    [manager requestAlwaysAuthorization];
    //请求app在使用期间授权 在前台使用时才可以使用定位
    [manager requestWhenInUseAuthorization];
    
    if([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        //临时开启后台定位 配置info.plist文件 不配置直接崩溃
        manager.allowsBackgroundLocationUpdates = YES;
    }
    
    //设置代理
    manager.delegate = self;
    
    //设置定位属性
    //每隔多远定位一次
    manager.distanceFilter = 100;
    /*
      kCLLocationAccuracyBestForNavigation //最适合导航
      kCLLocationAccuracyBest;//最好的
      kCLLocationAccuracyNearestTenMeters;//10米
      kCLLocationAccuracyHundredMeters;//100米
      kCLLocationAccuracyKilometer;//1000米
      kCLLocationAccuracyThreeKilometers;//3000米
     */
    //精确度越高,越耗电,定位时间越长
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //开启定位
    [manager startUpdatingLocation];
    
  
    
}
#pragma mark - CLLocationManagerDelegate
/*
 更新位置之后调用
 参数1:位置管理者
 参数2:位置数组
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //获取数据
    NSLog(@"%@",locations);
    //停止定位 省电
    [manager stopUpdatingLocation];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
