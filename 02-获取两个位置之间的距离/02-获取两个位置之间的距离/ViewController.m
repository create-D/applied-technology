//
//  ViewController.m
//  02-获取两个位置之间的距离
//
//  Created by 董立权 on 2017/7/16.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
//导入核心定位框架
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

//核心定位管理者
@property(nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建核心定位管理职
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    self.locationManager = manager;
    
    //请求授权
    [manager requestWhenInUseAuthorization];
    
    //设置代理
    manager.delegate = self;
    //开启定位
    [manager startUpdatingLocation];
    //计算两个位置之间的距离
    [self compareDistance];
}
//比较两个位置之间的距离
-(void)compareDistance {
    //根据精度生成位置信息
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:39 longitude:115];
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:30 longitude:120];
    
    //计算距离
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    
    NSLog(@"%.2fKm",distance/1000);
}


#pragma mark - CLLocationManagerDelegate
//时间监听位置方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"定位");
    //定位结束后关闭定位
    [manager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
