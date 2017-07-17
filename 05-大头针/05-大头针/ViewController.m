//
//  ViewController.m
//  05-大头针
//
//  Created by 董立权 on 2017/7/16.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
@interface ViewController ()<MKMapViewDelegate>
//地图
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//位置管理者
@property (nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation ViewController
//添加大头针
- (IBAction)addAnnotation:(id)sender {
    //删除多个大头针
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //创建大头针
    MyAnnotation *annotation = [[MyAnnotation alloc] init];
    
    //设置属性
    //位置
    annotation.coordinate = CLLocationCoordinate2DMake(38, 114);
    //标题
    annotation.title = @"标题";
    //子标题
    annotation.subtitle = @"子标题";
    //设置图片
    annotation.iconImage = @"cls";
    //将大头针添加到地图
    [self.mapView addAnnotation:annotation];
    
    //删除大头针
//    [self.mapView removeAnnotation:annotation];

}

 -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     //1.获取用户点击的位置
     CGPoint point = [[touches anyObject] locationInView:self.mapView];
     //2.将位置转换成经纬度
     CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
     //3.反地理编码获取地标
 
     //3.1创建反地理编码对象
     CLGeocoder *geocoder = [[CLGeocoder alloc] init];
     //3.2将经纬度转换为位置
     CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
     //3.3反地理编码
     [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
         if(error){
             NSLog(@"%@",error);
             return ;
         }
         //4.添加大头针 设置属性
         //4.1获取地标
         CLPlacemark *placemark = placemarks[0];
         //4.2创建大头针
         MyAnnotation *annotation = [[MyAnnotation alloc] init];
         annotation.coordinate = coordinate;//经纬度
         annotation.title = placemark.locality;//城市名
         annotation.subtitle = placemark.name;//具体地名
         annotation.iconImage = @"自拍照";
         dispatch_async(dispatch_get_main_queue(), ^{
             //4.3添加到地图
             [self.mapView addAnnotation:annotation];
         });
     }];
 }


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置地图代理
    self.mapView.delegate = self;
    
    //创建位置管理者,请求授权
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    //设置用户跟踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
}
#pragma mark - MKMapViewDelegate - 自定义MKAnnotationView
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MyAnnotation *)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        //返回nil,代表大头针的样式交由系统处理
        return nil;
    }
    
    MyAnnotationView *annotationView = [MyAnnotationView annotationViewWithMapView:mapView];
    
    
    //返回大头针
    return annotationView;
}

#pragma mark - MKMapViewDelegate - MKAnnotationView
/*
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MyAnnotation *)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        //返回nil,代表大头针的样式交由系统处理
        return nil;
    }
    //获取ID
    static NSString *ID = @"annotation";
    //获取大头针
    //MKAnnotationView:默认没有界面 能消失图片
    //MKPinAnnotationView:默认有界面,不能显示图片
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    //判断并创建大头针
    if(annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    //自定义大头针后.默认不会显示标题和子标题
    //调出标题和子标题
    annotationView.canShowCallout = YES;
    //如果没有设置标题 以下代码全部失效
    //左边界面
    annotationView.leftCalloutAccessoryView = [[UISwitch alloc] init] ;
    //右边界面
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //中间界面 会覆盖大头针的子标题
    annotationView.detailCalloutAccessoryView = [[UISwitch alloc] init];
    
    //设置图片
    //MyAnnotation *anno = (MyAnnotation *)annotation;
    annotationView.image = [UIImage imageNamed:annotation.iconImage];
    
    //返回大头针
    return annotationView;
}
*/
//大头针即将显示在界面时调用
//views:地图上所有的大头针
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
    for (MKAnnotationView *view in views) {
        NSLog(@"%@",view);
        //自己的位置不设置动画
        //MKModernUserLocationView:是私有类不能直接使用
        if([view isKindOfClass:NSClassFromString(@"MKModernUserLocationView")]){
            continue;
        }
        //1.保存大头针最终的位置
        CGRect viewFrame = view.frame;
        //2.修改大头针的位置
        view.frame = CGRectMake(viewFrame.origin.x, 0, viewFrame.size.width, viewFrame.size.height);
    
        //3.动画回归
        [UIView animateWithDuration:2.0 animations:^{
            view.frame = viewFrame;
        }];
    }
}

#pragma mark - MKMapViewDelegate - MKPinAnnotationView
/*
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        //返回nil,代表大头针的样式交由系统处理
        return nil;
    }
    //获取ID
    static NSString *ID = @"annotation";
    //获取大头针
    //MKAnnotationView:默认没有界面 能消失图片
    //MKPinAnnotationView:默认有界面,不能显示图片
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    //判断并创建大头针
    if(annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    //设置大头针颜色 只有三种颜色
    //annotationView.pinColor = MKPinAnnotationColorGreen;
    annotationView.pinTintColor = [UIColor yellowColor];
    //设置动画掉落效果
    annotationView.animatesDrop = YES;
    //自定义大头针后.默认不会显示标题和子标题
    //调出标题和子标题
    annotationView.canShowCallout = YES;
    //如果没有设置标题 以下代码全部失效
    //左边界面
    annotationView.leftCalloutAccessoryView = [[UISwitch alloc] init] ;
    //右边界面
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //中间界面 会覆盖大头针的子标题
    annotationView.detailCalloutAccessoryView = [[UISwitch alloc] init];
    //返回大头针
    return annotationView;
}
*/




@end
