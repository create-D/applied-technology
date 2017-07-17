//
//  ViewController.m
//  07-画线
//
//  Created by 董立权 on 2017/7/17.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet MKMapView *mapVIew;
@property (nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创新位置管理者,并授权
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    
    //设置代理
    self.mapVIew.delegate = self;
    
}
//画线
- (IBAction)beginNav:(id)sender {
    //1.地理编码获取地标
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    if(self.addressTextField.text.length == 0) return;
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error){
        if(error){
            NSLog(@"%@",error);
            return ;
        }
        //1.1获取地标
        CLPlacemark *placemark = [placemarks firstObject];
        //2.转换类型
        MKPlacemark *mkPlacemark = [[MKPlacemark alloc] initWithPlacemark:placemark];
        //3.获取目的地的mapItem
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:mkPlacemark];
        
        //4.获取起点的mapItem
        MKMapItem *currentMapItem = [MKMapItem mapItemForCurrentLocation];
        //5.创建请求对象
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        //目的地
        request.destination = mapItem;
        //起点
        request.source = currentMapItem;
        //6.创建方向对象
        MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
        //6.1向苹果请求数据,获取路线
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                NSLog(@"%@",error);
                return ;
            }
            //遍历数组,获取所有折线
            for (MKRoute *route in response.routes) {
                //获取折线
                MKPolyline *polyline = route.polyline;
                //将折线添加到地图上
                [self.mapVIew addOverlay:polyline];
            }
        }];
        
    }];
    
}

#pragma mark - MKMapViewDelegate 渲染颜色(线条)
//当有覆盖物添加到地图上时调用
//overlay:即将添加到地图上的覆盖物
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    //创建渲染对象
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    //设置颜色
    renderer.strokeColor = [UIColor redColor];
    //设置线宽
    renderer.lineWidth = 1;
    
    //返回渲染对象
    return renderer;
}



@end
