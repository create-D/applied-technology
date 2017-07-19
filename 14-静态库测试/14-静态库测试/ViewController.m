//
//  ViewController.m
//  14-静态库测试
//
//  Created by 董立权 on 2017/7/18.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import "DDTool.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [DDTool sayHello];
    self.imageView1.image = [DDTool loadImage];
    self.imageView2.image = [DDTool loadImage];
}


@end
