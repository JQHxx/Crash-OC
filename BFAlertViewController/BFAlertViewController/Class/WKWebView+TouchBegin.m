//
//  UIWebView+TouchBegin.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/26.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "WKWebView+TouchBegin.h"

@implementation WKWebView (TouchBegin)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    static UIEvent *e = nil;
    
    if (e != nil && e == event) {
        e = nil;
        return [super hitTest:point withEvent:event];
    }
    
    e = event;
    
    if (event.type == UIEventTypeTouches) {
        NSSet *touches = [event touchesForView:self];
        UITouch *touch = [touches anyObject];
        if (touch.phase == UITouchPhaseBegan) {
            NSLog(@"Touches began");
            // 点击空白处缩进键盘
            UIViewController *vc =  (UIViewController *)self.superview.nextResponder;
            [vc.view endEditing:YES];
            /*
            if ([vc isKindOfClass:[NewsDetailVC class]]) {
                NewsDetailVC *dVC = vc;
                [dVC resetInputView];
            }
             */
        }else if(touch.phase == UITouchPhaseEnded){
            NSLog(@"Touches Ended");
            
        }else if(touch.phase == UITouchPhaseCancelled){
            NSLog(@"Touches Cancelled");
            
        }else if (touch.phase == UITouchPhaseMoved){
            NSLog(@"Touches Moved");
            
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
