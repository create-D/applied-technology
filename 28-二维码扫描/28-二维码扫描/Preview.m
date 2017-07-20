//
//  Preview.m
//  28-二维码扫描
//
//  Created by 董立权 on 2017/7/20.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "Preview.h"
@interface Preview(){
    UIImageView *_imageView;
    UIImageView *_lineImageView;
    NSTimer *_timer;
}
@end
@implementation Preview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUiConfig];
    }
    return self;
}
-(void)setSession:(AVCaptureSession *)session{
    _session = session;
    //强转类型
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
    //给图层赋值
    layer.session = session;
}
//修改图层类型
+(Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

//在一个视图中设置二维码UI的代码

- (void)initUiConfig
{
    //设置背景图片
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    //设置位置到界面的中间
    _imageView.frame = CGRectMake(self.bounds.size.width * 0.5 - 140, self.bounds.size.height * 0.5 - 140, 280, 280);
    //添加到视图上
    [self addSubview:_imageView];
    
    //初始化二维码的扫描线的位置
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _lineImageView.image = [UIImage imageNamed:@"line.png"];
    [_imageView addSubview:_lineImageView];
    
    //开启定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}



- (void)animation
{
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _lineImageView.frame = CGRectMake(30, 260, 220, 2);
        
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(30, 10, 220, 2);
    }];
}


@end
