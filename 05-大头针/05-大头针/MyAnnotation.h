//
//  MyAnnotation.h
//  05-大头针
//
//  Created by 董立权 on 2017/7/16.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//1.导入框架 2.遵循协议 3.拷贝属性
@interface MyAnnotation : NSObject<MKAnnotation>
//大头针的经纬度
@property (nonatomic) CLLocationCoordinate2D coordinate;
//大头针的标题
@property (nonatomic, copy) NSString *title;
//大头针的子标题
@property (nonatomic, copy) NSString *subtitle;
//大头针图片
@property (nonatomic, copy) NSString *iconImage;

@end
