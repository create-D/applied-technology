//
//  ViewController.m
//  09-百度地图集成(手动)
//
//  Created by 董立权 on 2017/7/17.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface ViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate>
{
    BMKMapView *_mapView;
    BMKPoiSearch *_searcher;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建百度地图
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = _mapView;
    
    //设置地图类型
    _mapView.mapType = BMKMapTypeNone;//设置地图为空白类型
    
    //切换为卫星图
    [_mapView setMapType:BMKMapTypeSatellite];
    
    //切换为普通地图
    [_mapView setMapType:BMKMapTypeStandard];
    
    //打开实时路况图层
    [_mapView setTrafficEnabled:YES];
    
    //打开百度城市热力图图层（百度自有数据）
    [_mapView setBaiduHeatMapEnabled:YES];
    
    //关闭百度城市热力图图层（百度自有数据）
    [_mapView setBaiduHeatMapEnabled:NO];
    
    //logo位置
    _mapView.logoPosition = BMKLogoPositionCenterTop;
    
    
    
    //打开室内图
    _mapView.baseIndoorMapEnabled = YES;
    
    _mapView.zoomLevel = 15;
    
    [self performSelector:@selector(searchPOI) withObject:nil afterDelay:2.0];
}
-(void)searchPOI {
    //初始化检索对象
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    option.location = CLLocationCoordinate2DMake(39.915, 116.404);
    option.keyword = @"小吃";
    BOOL flag = [_searcher poiSearchNearBy:option];
    
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }

}
#pragma mark - BMKPoiSearchDelegate
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        for (BMKPoiInfo *poiInfo in poiResultList.poiInfoList) {
            // 添加一个PointAnnotation
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = poiInfo.pt;
            annotation.title = poiInfo.name;
            [_mapView addAnnotation:annotation];
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
        NSLog(@"%d",error);
    }
}
//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
    _searcher.delegate = nil;
}
#pragma mark - 动画效果
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}



@end
