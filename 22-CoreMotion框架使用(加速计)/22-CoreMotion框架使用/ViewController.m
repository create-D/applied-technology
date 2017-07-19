//
//  ViewController.m
//  22-CoreMotion框架使用
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
//导入头文件
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()

//运动管理者
@property (nonatomic,strong)CMMotionManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加速计 磁力计 陀螺仪
    //1.创建运动管理者
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    self.manager = manager;
    
    //2.判断加速计是否可用
    if(self.manager.isAccelerometerAvailable == NO){
        NSLog(@"加速计不可用");
    }
    
    //3.获取加速计数据
    
    //push方式
    //设置数据的更新频率
//    self.manager.accelerometerUpdateInterval = 1.0;
//    //获取数据
//    [self.manager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//        //1表示一个重力加速度 g
//        NSLog(@"x:%f y:%f z:%f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
//    }];
    
    [self.manager startAccelerometerUpdates];
}

//pull方式
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"x:%f y:%f z:%f",self.manager.accelerometerData.acceleration.x,self.manager.accelerometerData.acceleration.y,self.manager.accelerometerData.acceleration.z);
}

@end
