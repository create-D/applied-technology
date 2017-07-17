//
//  MyAnnotationView.m
//  05-大头针
//
//  Created by 董立权 on 2017/7/17.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "MyAnnotationView.h"
#import "MyAnnotation.h"
@implementation MyAnnotationView

+(instancetype)annotationViewWithMapView:(MKMapView *)mapView{
    //获取ID
    static NSString *ID = @"annotation";
    //获取大头针
    //MKAnnotationView:默认没有界面 能消失图片
    //MKPinAnnotationView:默认有界面,不能显示图片
    MyAnnotationView *annotationView = (MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    //判断并创建大头针
    if(annotationView == nil) {
        annotationView = [[MyAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
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
    
    return  annotationView;
}
-(void)setAnnotation:(MyAnnotation *)annotation {
    [super setAnnotation:annotation];
    //设置图片
    //MyAnnotation *anno = (MyAnnotation *)annotation;
    self.image = [UIImage imageNamed:annotation.iconImage];
    
}

@end
