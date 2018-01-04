//
//  ZTTabbarAttribute.h
//  ZTTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZTTabbarItemAttribute : NSObject
@property (strong, nonatomic) UIColor *itemTitleColor;
@property (strong, nonatomic) UIColor *itemTitleSelectColor;
@property (strong, nonatomic) UIFont  *itemTitleFont;
@property (strong, nonatomic) UIColor *itemBgColor;
@property (strong, nonatomic) UIColor *itemBgSelectColor;
@property (strong, nonatomic) UIColor *itemBadgeColor;
@property (assign, nonatomic) CGSize   itemImgSize;
+ (instancetype)defaultAttribute;
@end
