//
//  ViewController.m
//  28-二维码扫描
//
//  Created by 董立权 on 2017/7/20.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SafariServices/SafariServices.h>
#import "Preview.h"
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>

//输出设备
@property(strong,nonatomic)AVCaptureDeviceInput *deviceInput;
//输出设备 Metadata元数据
@property(strong,nonatomic)AVCaptureMetadataOutput *output;
//会话
@property(nonatomic,strong)AVCaptureSession *session;
//图层
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;
//自定义界面
@property(nonatomic,weak)Preview *preView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.输入设备 摄像头 键盘 鼠标 麦克风
    //1.1摄像头的设备 默认后置摄像头
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //1.2创建摄像头的输入设备
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //2.输出设备 ->解析数据
    self.output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 用来获取数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //3.会话 ->连接输入和输出设备
    self.session = [[AVCaptureSession alloc] init];
    //连接设备
    if([self.session canAddInput:self.deviceInput]){
        [self.session addInput:self.deviceInput];
    }
    if([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }
    //设置输出设备的解析数据的类型
    //AVMetadataObjectTypeQRCode 二维码
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    //4.预览的图层
    Preview *preView = [[Preview alloc] initWithFrame:self.view.bounds];
    preView.session = self.session;
    self.preView = preView;
    [self.view addSubview:preView];
    
//    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
//    //添加图层
//    [self.view.layer addSublayer:self.previewLayer];
//    //设置图层的大小
//    self.previewLayer.frame = self.view.bounds;
    //5.开启会话
    [self.session startRunning];
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
//扫描到二维码数据时调用
//metadataObjects:扫描到的数据
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    //扫描到数据之后 移除图层
//    [self.previewLayer removeFromSuperlayer];
    [self.preView removeFromSuperview];
    //停止会话
    [self.session stopRunning];
    for (AVMetadataMachineReadableCodeObject *objc in metadataObjects) {
        //二维码扫描出来的结果是字符串
        NSLog(@"%@",objc.stringValue);
        //创建safari控制器
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:objc.stringValue]];
        [self presentViewController:safariVC animated:YES completion:nil];
    }
}


@end
