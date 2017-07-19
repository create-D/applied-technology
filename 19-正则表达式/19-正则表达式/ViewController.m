//
//  ViewController.m
//  19-正则表达式
//
//  Created by 董立权 on 2017/7/19.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     匹配abc @"abc"
     匹配包含一个小写字母a~z,后面跟数字0-9 @"[a-z][0-9]"
     匹配只有两个,第一个必须是字母,第二个必须是数字 @"^[a-z][0-9]$"
     匹配第一个必须是字母,字母后面跟上4~9个数字 @"^[a-z][0-9]{4,9}"
     匹配不能是数字开头 @"^[^0-9]"
     匹配QQ匹配(5-12位数字,0不能开头) @"^[1-9][0-9]{4,11}$"
     匹配
     */
    NSString *str = @"sfsfaasfabc";
    //正则表达式内容
    NSString *pattern = @"abc";
    //创建匹配对象
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    //匹配正则表达式
    //匹配第一个结果
//    [exp firstMatchInString:<#(nonnull NSString *)#> options:<#(NSMatchingOptions)#> range:<#(NSRange)#>]
    //匹配所有结果
    NSArray *array = [exp matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    if(array.count){
        NSLog(@"匹配了%zd个结果",array.count);
    }else {
        NSLog(@"没有匹配结果");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
