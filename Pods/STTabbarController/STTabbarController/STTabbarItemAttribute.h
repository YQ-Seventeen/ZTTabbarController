//
//  STTabbarAttribute.h
//  STTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface STTabbarItemAttribute : NSObject
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *titleSelectColor;
@property (strong, nonatomic) UIFont *titleFont;
+ (instancetype)defaultAttribute;
@end
