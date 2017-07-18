//
//  ViewController.m
//  11-应用间跳转(跳)
//
//  Created by 董立权 on 2017/7/18.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)page1:(id)sender {
    
    NSString *header = @"change://page1";
    //1.获取协议头
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSLog(@"%@",info);
    NSArray *urlTypes = info[@"CFBundleURLTypes"];
    NSDictionary *typesInfo = urlTypes[0];
    NSArray *schemes = typesInfo[@"CFBundleURLSchemes"];
    NSString *scheme = schemes[0];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@?%@",header,scheme];

    if(![[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstr]]){
                NSLog(@"不能打开对应的app");
    }
}
- (IBAction)page2:(id)sender {
    if(![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"change://page2"]]){
        NSLog(@"不能打开对应的app");
    }
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    //应用间跳转是根据协议头跳转
////    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"change://"]]){
////        //打开对应的App
////        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"change://"]];
////    }
//    if(![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"change://"]]){
//        NSLog(@"不能打开对应的app");
//    }
//}


@end
