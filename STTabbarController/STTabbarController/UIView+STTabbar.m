//
//  UIView+Util.m
//  YQRefresh
//
//  Created by yq on 2017/12/14.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "UIView+STTabbar.h"
@implementation UIView (STTabbar)
- (void)setSt_x:(CGFloat)st_x {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(st_x, selfRect.origin.y, selfRect.size.width, selfRect.size.height);
}
- (CGFloat)st_x {
    return self.frame.origin.x;
}
- (void)setSt_y:(CGFloat)st_y {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(selfRect.origin.x, st_y, selfRect.size.width, selfRect.size.height);
}
- (CGFloat)st_y {
    return self.frame.origin.y;
}
- (void)setSt_w:(CGFloat)st_w {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(selfRect.origin.x, selfRect.origin.y, st_w, selfRect.size.height);
}
- (CGFloat)st_w {
    return self.frame.size.width;
}
- (void)setSt_h:(CGFloat)st_h {
    CGRect selfRect = self.frame;
    self.frame      = CGRectMake(selfRect.origin.x, selfRect.origin.y, selfRect.size.width, st_h);
}
- (CGFloat)st_h {
    return self.frame.size.height;
}
- (void)setSt_centerX:(CGFloat)st_centerX {
    CGPoint selfPoint = self.center;
    self.center       = CGPointMake(st_centerX, selfPoint.y);
}
- (CGFloat)st_centerX {
    return self.center.x;
}
- (void)setSt_centerY:(CGFloat)st_centerY {
    CGPoint selfPoint = self.center;
    self.center       = CGPointMake(selfPoint.x, st_centerY);
}
- (CGFloat)st_centerY {
    return self.center.y;
}
- (CGFloat)st_maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)st_maxY {
    return CGRectGetMaxY(self.frame);
}
@end
