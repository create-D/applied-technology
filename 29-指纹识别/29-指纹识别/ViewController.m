//
//  ViewController.m
//  29-指纹识别
//
//  Created by 董立权 on 2017/7/20.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
//本地授权
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.创建上下文
    LAContext *context = [[LAContext alloc] init];
    //2.判断指纹识别是否可用
    /*
     LAPolicyDeviceOwnerAuthenticationWithBiometrics kLAPolicyDeviceOwnerAuthenticationWithBiometrics
     */
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]){
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"按住Home键验证" reply:^(BOOL success, NSError * _Nullable error) {
            if(error){
                //-1表示连续错误3次
                //-8再次错误
                //-3点击输入密码
                NSLog(@"%zd",error.code);
            }
            if(success){
                NSLog(@"验证成功");
            }
        }];
    }
}

@end
