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
    STTabbarItemAttribute *attribute = [STTabbarItemAttribute new];
    attribute.itemTitleColor             = [UIColor darkTextColor];
    attribute.itemTitleSelectColor       = [UIColor blueColor];
    attribute.itemTitleFont              = [UIFont systemFontOfSize:10];
    attribute.itemImgSize                = CGSizeMake(30, 30);
    return attribute;
}
@end

