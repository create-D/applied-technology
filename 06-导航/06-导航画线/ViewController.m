//
//  ViewController.m
//  06-导航画线
//
//  Created by 董立权 on 2017/7/17.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark -  [MKMapItem openMapsWithItems:<#(nonnull NSArray<MKMapItem *> *)#> launchOptions:<#(nullable NSDictionary<NSString *,id> *)#>]
//开始导航
- (IBAction)beginNav:(id)sender {
    
    //导航:必须告诉苹果导航的起点和终点
    //导航是向苹果请求数据
    
    //地理编码获取地标北京
    if(self.addressTextField.text.length == 0)return;
    //根据地理编码获取地标
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@",error);
            return ;
        }
        //1.获取地标
        CLPlacemark *placemark = [placemarks firstObject];
        //2.转换类型
        MKPlacemark *mkPlaceMark = [[MKPlacemark alloc] initWithPlacemark:placemark];
        //3.用户目的地
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:mkPlaceMark];
        //4.用户的起点
        MKMapItem *currentItem = [MKMapItem mapItemForCurrentLocation];
        
        /*
         MKLaunchOptionsDirectionsModeKey 导航模式
         MKLaunchOptionsMapTypeKey 地图类型
         MKLaunchOptionsShowsTrafficKey 是否显示实时交通
         */
        //配置导航信息
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        /*
         MKLaunchOptionsDirectionsModeDefault
         MKLaunchOptionsDirectionsModeDriving 驾车模式
         MKLaunchOptionsDirectionsModeWalking 步行模式
         MKLaunchOptionsDirectionsModeTransit 公交模式
         */
        options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeTransit;
        //标准模式
        options[MKLaunchOptionsMapTypeKey] = MKMapTypeStandard;
        options[MKLaunchOptionsShowsTrafficKey] = @(YES);
        //5.开始导航
        [MKMapItem openMapsWithItems:@[currentItem,mapItem] launchOptions:options];
        
    }];
}





@end
