//
//  UIViewController+STTabbarController.h
//  STTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "STTabbarController.h"
@interface UIViewController (STTabbarController)
@property (strong, nonatomic) STTabbarController *st_tabbar;
@property (assign, nonatomic) BOOL hidesTabbarWhenPushed;
@end
