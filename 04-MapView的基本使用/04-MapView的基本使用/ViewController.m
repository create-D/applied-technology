//
//  ViewController.m
//  04-MapView的基本使用
//
//  Created by 董立权 on 2017/7/16.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#pragma mark - 导入MapKit框架
//1.导入头文件
#import <MapKit/MapKit.h>
//MapKit框架中所有数据类型的前缀都是MK
//MapKit有一个比较重要的UI控件:MKMapView,专门用于地图显示

@interface ViewController ()<MKMapViewDelegate>

//没有导入mapKit框架 在storyboard中直接使用地图 会崩溃
//xcode5之后,默认帮助程序员导入框架
//在storyboard中使用除了UIKit框架外的 都需要手动导入
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//位置管理者
@property(nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     MKMapTypeStandard = 0, //标准(默认)
     MKMapTypeSatellite,    //卫星
     MKMapTypeHybrid,       //鸟瞰(混合)
     MKMapTypeSatelliteFlyover//在中国不能使用
     MKMapTypeHybridFlyover
     */
    //修改地图类型
    self.mapView.mapType = MKMapTypeStandard;
    
    //创建位置管理者
    self.locationManager = [[CLLocationManager alloc] init];
    //请求用户授权 配置info.plist
    [self.locationManager requestWhenInUseAuthorization];
    
    /*
     MKUserTrackingModeNone
     MKUserTrackingModeFollow   //跟踪用户的位置
     MKUserTrackingModeFollowWithHeading //跟踪用户的位置和方向
     */
    //设置用户的跟踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置代理
    self.mapView.delegate = self;
    
}
#pragma mark - MKMapViewDelegate
//跟踪用户位置时调用
//mapView:地图
//userLocation:用户位置的大头针模型
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //1.反地理编码
    //1.1创建地理编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //1.2反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //1.3防错处理
        if(error){
            NSLog(@"%@",error);
            return ;
        }
        //1.4.获取地标
        CLPlacemark *placemark = [placemarks firstObject];
        //2.给标题和子标题赋值
        userLocation.title = placemark.locality;
        userLocation.subtitle = placemark.name;
    }];
}
//回到当前用户的位置
- (IBAction)backToCurrentLocation:(id)sender {
//    //将当前用户的经纬度,设置为滴入中心的经纬度
//    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
    
    //获取当前的跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.020993, 0.015407);
    
    //设置回到用户刚开始的区域 region(结构体) -- 1.心点经纬度(结构体)->精度 纬度 2.经纬度跨度->精度跨度 纬度跨度
    //self.mapView.region = MKCoordinateRegionMake(self.mapView.userLocation.location.coordinate, span);
    //设置区域,并添加动画
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.userLocation.location.coordinate, span) animated:YES];
}
//跨度改变时候调用
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"%f  %f",self.mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
}
//放大地图
- (IBAction)biggerMap:(id)sender {
    //修改经纬度跨度
    CGFloat latitudeDelta = self.mapView.region.span.latitudeDelta * 0.5;
    CGFloat longitudeDelta = self.mapView.region.span.longitudeDelta * 0.5;
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    //确定放大地图后的区域
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.centerCoordinate, span) animated:YES];
    
}
//缩小地图
- (IBAction)smallMap:(id)sender {
    //修改经纬度跨度
    CGFloat latitudeDelta = self.mapView.region.span.latitudeDelta * 2;
    CGFloat longitudeDelta = self.mapView.region.span.longitudeDelta * 2;
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    //确定缩小地图后的区域
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.centerCoordinate, span) animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
