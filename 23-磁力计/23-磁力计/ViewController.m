//
//  ViewController.m
//  23-磁力计
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
    
    //2.判断磁力计是否可用
    if(self.manager.isMagnetometerAvailable == NO){
        NSLog(@"磁力计不可用");
    }
    
    //3.获取磁力计数据
    //push方式
//    //设置数据更新频率
//    self.manager.magnetometerUpdateInterval = 1.0;
//    [self.manager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
//        if(error){
//            NSLog(@"%@",error);
//        }
//        //磁力计的单位:T 特斯拉
//        NSLog(@"x:%f y:%f z:%f",magnetometerData.magneticField.x,magnetometerData.magneticField.y,magnetometerData.magneticField.z);
//    }];
    [self.manager startMagnetometerUpdates];
    
}

//pull方式
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"x:%f y:%f z:%f",self.manager.magnetometerData.magneticField.x,self.manager.magnetometerData.magneticField.y,self.manager.magnetometerData.magneticField.z);
}


@end
