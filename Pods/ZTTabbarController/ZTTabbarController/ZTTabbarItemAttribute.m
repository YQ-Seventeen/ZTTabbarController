//
//  ZTTabbarAttribute.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "ZTTabbarItemAttribute.h"
@implementation ZTTabbarItemAttribute
+ (instancetype)defaultAttribute {
    ZTTabbarItemAttribute *attribute = [ZTTabbarItemAttribute new];
    attribute.itemTitleColor             = [UIColor darkTextColor];
    attribute.itemTitleSelectColor       = [UIColor blueColor];
    attribute.itemTitleFont              = [UIFont systemFontOfSize:10];
    attribute.itemImgSize                = CGSizeMake(30, 30);
    return attribute;
}
@end

