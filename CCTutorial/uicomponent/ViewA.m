//
//  ViewA.m
//  CCTutorial
//
//  Created by CC on 2020/3/24.
//  Copyright © 2020 kayak. All rights reserved.
//

#import "ViewA.h"

@implementation ViewA

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
        for(NSInteger i=subViews.count-1; i >= 0;i--) {
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
    return [super hitTest:point withEvent:event];

    
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return [super pointInside:point withEvent:event];
}

@end
