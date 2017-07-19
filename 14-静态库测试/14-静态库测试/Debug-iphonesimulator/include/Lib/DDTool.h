//
//  DDTool.h
//  Lib
//
//  Created by 董立权 on 2017/7/18.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DDTool : NSObject
//自己创建的文件 默认不能被打包到静态库
//打印你好
+ (void)sayHello;
+(UIImage *)loadImage;
@end
