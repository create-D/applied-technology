//
//  BackViewController.m
//  12-应用间跳转(转)
//
//  Created by 董立权 on 2017/7/18.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "BackViewController.h"
#import "AppDelegate.h"
@interface BackViewController ()

@end

@implementation BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)back:(id)sender {
    AppDelegate *d = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *strurl = d.str;
    NSRange range = [strurl rangeOfString:@"?"];
    NSString *str = [strurl substringFromIndex:range.location + range.length];
    if(![[UIApplication sharedApplication] openURL:[NSURL URLWithString:[str stringByAppendingString:@"://"]]]){
        NSLog(@"不能打开对应的app");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
