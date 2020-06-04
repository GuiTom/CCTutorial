//
//  ViewC.m
//  CCTutorial
//
//  Created by CC on 2020/3/24.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "ViewC.h"

@implementation ViewC

static float radius  = 100;
/**
 绘制一个圆，表示可点击区域
 */
- (void)drawRect:(CGRect)rect {
     /*通过CGPathRef 来绘制圆*/
     //获取上下文
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     //创建可变路径
     CGMutablePathRef path = CGPathCreateMutable();
//添加圆形到路径中(所在路径、不进行变换操作、中心坐标200、200、起点弧度0、终点弧度2PI、画的方向0逆1正)
     CGPathAddArc(path, NULL, self.bounds.size.width/2, self.bounds.size.height/2, radius, 0, M_PI * 2, 1);
     //将路径添加到上下文
     CGContextAddPath(ctx, path);
     //修改图形状态参数
     CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.9, 1.0);//笔颜色
     CGContextSetLineWidth(ctx, 2);//线条宽度
     //渲染上下文
     CGContextStrokePath(ctx);
    CFRelease(path);
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGFloat sqrtDistant = powf((point.x-self.bounds.size.width/2),2)+powf((point.y-self.bounds.size.height/2),2);
    if(sqrtDistant>powf(radius,2)){
        return NO;
    }
    return YES;
}
@end
