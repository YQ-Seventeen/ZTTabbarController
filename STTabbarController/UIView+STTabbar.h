//
//  UIView+Util.h
//  YQRefresh
//
//  Created by yq on 2017/12/14.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
@class STTabbarController;
@interface UIView (STTabbar)
@property (assign, nonatomic) CGFloat st_x;
@property (assign, nonatomic) CGFloat st_y;
@property (assign, nonatomic) CGFloat st_w;
@property (assign, nonatomic) CGFloat st_h;
@property (assign, nonatomic) CGFloat st_centerX;
@property (assign, nonatomic) CGFloat st_centerY;
@property (assign, nonatomic, readonly) CGFloat st_maxX;
@property (assign, nonatomic, readonly) CGFloat st_maxY;

@property (strong, nonatomic,setter=setSTTabbar:) STTabbarController *st_tabbar;
@end
