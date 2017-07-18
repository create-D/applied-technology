//
//  ViewController.m
//  09-苹果自带的分享功能
//
//  Created by 董立权 on 2017/7/18.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
//导入头文件
#import <Social/Social.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.判断分享平台是否可用
    if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]){
        NSLog(@"请到系统设置中添加账号和密码");
    }
    //2.创建分享控制器
    //ServiceType:分享的平台
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    //设置预设的文字
    [composeVC setInitialText:@"预设文字:"];
    //预设的图片
    [composeVC addImage:[UIImage imageNamed:@"图片"]];
    //预设网址
    [composeVC addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    //3.弹出控制器
    [self presentViewController:composeVC animated:YES completion:nil];
}

@end
