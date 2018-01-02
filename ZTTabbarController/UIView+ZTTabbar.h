//
//  UIView+Util.h
//  ZTTabbarController
//
//  Created by yq on 2017/12/14.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface UIView (ZTTabbar)
@property (assign, nonatomic) CGFloat zt_x;
@property (assign, nonatomic) CGFloat zt_y;
@property (assign, nonatomic) CGFloat zt_w;
@property (assign, nonatomic) CGFloat zt_h;
@property (assign, nonatomic) CGFloat zt_centerX;
@property (assign, nonatomic) CGFloat zt_centerY;
@property (assign, nonatomic, readonly) CGFloat zt_maxX;
@property (assign, nonatomic, readonly) CGFloat zt_maxY;

@end
