//
//  ViewController.m
//  25-计步器的使用
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()

//计算步数
@property(nonatomic,strong)CMStepCounter *stepCounter;
//iOS8之后计算步数
@property(nonatomic,strong)CMPedometer *pedometer;

@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.判断计步器是否可用
    if(![CMPedometer isStepCountingAvailable]){
        NSLog(@"计步器不可用");
    }
    
    //2.创建计算步数对象
    self.pedometer = [[CMPedometer alloc] init];
    
    //3.开始计算步数
    //FromDate :从何时开始计步
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@",error);
        }
        NSLog(@"%@",pedometerData.numberOfSteps);
    }];
    
}

-(void)test {
    //1.判断计步器是否可用
    if(!CMStepCounter.isStepCountingAvailable){
        NSLog(@"计步器不可用");
    }
    //2.创建计算步数对象
    self.stepCounter = [[CMStepCounter alloc] init];
    //授权 NSMotionUsageDescription
    //3.开始计算步数
    //Queue:队列
    //updateOn:从几步开始计算步数
    [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@",error);
        }
        self.stepLabel.text = [NSString stringWithFormat:@"%zd",numberOfSteps];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
