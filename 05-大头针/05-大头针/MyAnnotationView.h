//
//  MyAnnotationView.h
//  05-大头针
//
//  Created by 董立权 on 2017/7/17.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MyAnnotationView : MKAnnotationView

+(instancetype)annotationViewWithMapView:(MKMapView *)mapView;

@end
