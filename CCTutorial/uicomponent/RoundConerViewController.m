//
//  RoundConerViewController.m
//  CCTutorial
//
//  Created by 陈超 on 2020/5/10.
//  Copyright © 2020年 kayak. All rights reserved.
//

#import "RoundConerViewController.h"

@interface RoundConerViewController ()

@end

@implementation RoundConerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRoundedImage3];
}
-(void)addRoundedImage1{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"flag"];
    [imageView setImage:[self drawImageWithCircle:image]];
    imageView.frame = CGRectMake(10, 100, 100, 100);
    [self.view addSubview:imageView];
    
}
-(UIImage*)drawImageWithCircle:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.preferredPresentationSizeForItemProvider, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:50];
    [path addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return _image;
}
-(void)addRoundedImage2{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    imageView.image = [UIImage imageNamed:@"flag"];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:10];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    [self.view addSubview:imageView];
    
}
-(void)addRoundedImage3{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"flag"];
    [imageView setImage:image];
    imageView.layer.shouldRasterize = YES;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    imageView.frame = CGRectMake(10, 100, 100, 100);
    [self.view addSubview:imageView];
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
