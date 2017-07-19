//
//  ViewController.m
//  24-陀螺仪
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"

#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
//运动管理者
@property (nonatomic,strong)CMMotionManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建运动管理者
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    self.manager = manager;
    
//    //2.判断陀螺仪是否可用
//    if(self.manager.isGyroAvailable == NO) {
//        NSLog(@"陀螺仪不可用");
//    }
//    //设置更新频率
//    self.manager.gyroUpdateInterval = 1.0;
//    //获取数据
//    [self.manager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//        NSLog(@"x:%f y:%f z:%f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
//    }];
    [self.manager startGyroUpdates];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"x:%f y:%f z:%f",self.manager.gyroData.rotationRate.x,self.manager.gyroData.rotationRate.y,self.manager.gyroData.rotationRate.z);
}

@end
