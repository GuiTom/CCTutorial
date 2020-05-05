//
//  ViewB.m
//  CCTutorial
//
//  Created by CC on 2020/3/24.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "ViewB.h"

@implementation ViewB

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if(!self.userInteractionEnabled||self.alpha<0.01||self.hidden){
        return nil;
    }
    UIView *view = nil;
    if([self pointInside:point withEvent:event]){
        
        NSArray *subViews = self.subviews;
        for(NSInteger i=subViews.count-1; i>0;i--) {
            UIView *subView = subViews[i];
            CGPoint p = [self convertPoint:point toView:subView];
            view = [subView hitTest:p withEvent:event];
            if(view){
                break;
            }
        }
        if(!view){
            view = self;
        }
    }
    return view;
    
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return [super pointInside:point withEvent:event];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__FUNCTION__);
    //如果View 添加了点击事件，点击事件在这个方法之后调用
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     NSLog(@"%s",__FUNCTION__);
    //如果View 添加了点击事件，且有拖动，点击事件在这个方法之后调用
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //如果View 添加了点击事件，这里将不被调用
     NSLog(@"%s",__FUNCTION__);
}
@end
