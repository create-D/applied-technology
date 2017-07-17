//
//  RevViewController.m
//  03-地理编码和反地理编码
//
//  Created by 董立权 on 2017/7/16.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "RevViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface RevViewController ()
//精度
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
//纬度
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
//详细地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@end

@implementation RevViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//反地理编码
- (IBAction)revGeocoder:(id)sender {
    //反地理编码: 将经纬度转换成具体地址
    
    //1.创建地理编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //2.反地理编码
    //2.1创建位置信息
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.longitudeTextField.text floatValue] longitude:[self.latitudeTextField.text floatValue]];
    //2.2向苹果请求数据
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //2.3防错处理
        if(error){
            NSLog(@"%@",error);
            return ;
        }
        //2.4获取地标 在公司开发中给一个列表供用户选择
        CLPlacemark *placemark = placemarks[0];
        //2.5赋值
        self.addressLabel.text = placemark.name;
        NSLog(@"%@",placemark.locality);
    }];
}



@end
