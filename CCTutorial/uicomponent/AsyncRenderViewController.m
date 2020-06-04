//
//  AsyncRenderViewController.m
//  CCTutorial
//
//  Created by CC on 2020/3/26.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "AsyncRenderViewController.h"

@interface AsyncRenderViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation AsyncRenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showImage2];
}
-(void)showImage1{
     NSDate *date = [NSDate date];
    for (int i=0; i<18; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(100, 100+10*i, 100, 100);
        [self.view addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"flag-1"];
    }
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:date];
    NSLog(@"senconds elasped %f",timeInterval);
   
}
- (void)showImage2
{
    NSDate *date = [NSDate date];
    for (int i=0; i<18; i++) {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 100+20*i, 100, 100);
    [self.view addSubview:imageView];
    self.imageView = imageView;
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{//进入子线程的全局并发队列里面去解压图片素材
        // 获取CGImage
        CGImageRef cgImage = [UIImage imageNamed:@"flag-1"].CGImage;//这里并不会开始界面

        // 获取素材里面的透明读信息
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        //根据透明度信息构建解压后需要用到的的位图信息结构体
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        // size
        size_t width = CGImageGetWidth(cgImage);
        size_t height = CGImageGetHeight(cgImage);
        // 创建一个图形上下文
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, CGColorSpaceCreateDeviceRGB(), bitmapInfo);
       
        // 把素材里面的信息绘制到上下文，同时也进行压缩格式文件(JPG/PNG)的解压工作
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);//这里才开始解码

        // 已经完成解码，获取解压后的位图图片信息
        cgImage = CGBitmapContextCreateImage(context);
    
        UIImage *newImage = [UIImage imageWithCGImage:cgImage];

        // release
        CGContextRelease(context);
        CGImageRelease(cgImage);

        // 将解压后的位图信息在主线程重交给图形控件来显示
        dispatch_async(dispatch_get_main_queue(), ^{
            NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:date];
            NSLog(@"senconds elasped %f",timeInterval);
            imageView.image = newImage;
        });
   
    });
         }
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
