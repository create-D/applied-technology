//
//  DDTool.m
//  Lib
//


#import "DDTool.h"

@implementation DDTool

+ (void)sayHello{
    NSLog(@"hello");
}
+(UIImage *)loadImage{
    UIImage *image = [UIImage imageNamed:@"Resuse.bundle/006"];
    return image;
}
@end
