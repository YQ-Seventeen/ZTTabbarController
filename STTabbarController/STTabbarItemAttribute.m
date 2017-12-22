//
//  STTabbarAttribute.m
//  STTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import "STTabbarItemAttribute.h"

@implementation STTabbarItemAttribute
+ (instancetype)defaultAttribute {
    STTabbarItemAttribute * attribute = [STTabbarItemAttribute new];
    attribute.titleColor =  [UIColor darkTextColor];
    attribute.titleSelectColor = [UIColor blueColor];
    attribute.titleFont = [UIFont systemFontOfSize:10];
    return attribute;
}

@end
