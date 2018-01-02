//
//  UIView+ZTTabbar.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/14.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "UIView+ZTTabbar.h"
#import <objc/runtime.h>

@implementation UIView (ZTTabbar)
- (void)setZt_x:(CGFloat)zt_x {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(zt_x, selfRect.origin.y, selfRect.size.width, selfRect.size.height);
}
- (CGFloat)zt_x {
    return self.frame.origin.x;
}
- (void)setZt_y:(CGFloat)zt_y {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(selfRect.origin.x, zt_y, selfRect.size.width, selfRect.size.height);
}
- (CGFloat)zt_y {
    return self.frame.origin.y;
}
- (void)setZt_w:(CGFloat)zt_w {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(selfRect.origin.x, selfRect.origin.y, zt_w, selfRect.size.height);
}
- (CGFloat)zt_w {
    return self.frame.size.width;
}
- (void)setZt_h:(CGFloat)zt_h {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(selfRect.origin.x, selfRect.origin.y, selfRect.size.width, zt_h);
}
- (CGFloat)zt_h {
    return self.frame.size.height;
}
- (void)setZt_centerX:(CGFloat)zt_centerX {
    CGPoint selfPoint = self.center;
    self.center       = CGPointMake(zt_centerX, selfPoint.y);
}
- (CGFloat)zt_centerX {
    return self.center.x;
}
- (void)setZt_centerY:(CGFloat)zt_centerY {
    CGPoint selfPoint = self.center;
    self.center       = CGPointMake(selfPoint.x, zt_centerY);
}
- (CGFloat)zt_centerY {
    return self.center.y;
}
- (CGFloat)zt_maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)zt_maxY {
    return CGRectGetMaxY(self.frame);
}

@end
