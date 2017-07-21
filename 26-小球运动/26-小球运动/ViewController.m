//
//  ViewController.m
//  26-小球运动
//
//  Created by 董立权 on 2017/7/20.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
//运动管理者
@property(nonatomic,strong)CMMotionManager *motionManager;
//速度
@property(nonatomic,assign)CGPoint spend;
//小球
@property (weak, nonatomic) IBOutlet UIImageView *ballView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建运动管理者对象
    self.motionManager = [[CMMotionManager alloc] init];
    //2.判断加速计是否可用
    if(self.motionManager.isAccelerometerAvailable == NO){
        NSLog(@"加速计不可用");
    }
    //设置跟新时间
    self.motionManager.accelerometerUpdateInterval = 1/30.0;
    //3.获取加速计数据
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if(error){
            NSLog(@"加速度获取失败");
        }
        //在这个block中,时间是固定的,并且一段时间就会调用这个block
        NSLog(@"x:%f y:%f z:%f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
        //x y 是x轴和y轴的加速度
        //将加速度转换成速度
        _spend.x += accelerometerData.acceleration.x;
        _spend.y -= accelerometerData.acceleration.y;
        //改变小球的位置
        CGRect ballFrame = self.ballView.frame;
        ballFrame.origin.x += _spend.x;
        ballFrame.origin.y += _spend.y;
        //防止小球超出四个边界
        //左边
        if(ballFrame.origin.x <= 0){
            ballFrame.origin.x = 0;
            //添加空气阻力效果
            _spend.x *= -0.9;
            
        }
        //右边
        if(ballFrame.origin.x >= self.view.bounds.size.width - ballFrame.size.width){
            ballFrame.origin.x = self.view.bounds.size.width - ballFrame.size.width;
            _spend.x *= -0.9;
            
        }
        //上边
        if(ballFrame.origin.y <= 0){
            ballFrame.origin.y = 0;
            _spend.y *= -0.9;
            
        }
        //下边
        if(ballFrame.origin.y >= self.view.bounds.size.height - ballFrame.size.height){
            ballFrame.origin.y = self.view.bounds.size.height - ballFrame.size.height;
            _spend.y *= -0.9;
            
        }
        //改变frame
        self.ballView.frame = ballFrame;
        
    }];
    
}





@end
