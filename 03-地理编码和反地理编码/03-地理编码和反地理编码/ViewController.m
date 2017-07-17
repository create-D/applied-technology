//
//  ViewController.m
//  03-地理编码和反地理编码
//
//  Created by 董立权 on 2017/7/16.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()
//地理位置
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
//经度
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
//纬度
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;


@end

@implementation ViewController
//地理编码
- (IBAction)geocoder:(id)sender {
    //地理编码:将具体地址转换成经纬度
    
    //1.创建地理编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //2.地理编码
    if(self.addressTextField.text.length == 0) return;
    //异步 向苹果请求数据
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //防错处理
        if(error){
            NSLog(@"%@",error);
            return ;
        }
        //placemarks:所有的地标 一个CLPlacemark代表一个地标
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"%@",placemark);
            //精度
            self.longitudeLabel.text = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
            //纬度
            self.latitudeLabel.text = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
            
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
