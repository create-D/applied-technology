//
//  Preview.h
//  28-二维码扫描
//
//  Created by 董立权 on 2017/7/20.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface Preview : UIView

@property(nonatomic,strong)AVCaptureSession *session;
@end
