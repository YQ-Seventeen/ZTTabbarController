//
//  ZTTabbarItemModel.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "ZTTabbarItemModel.h"
#import "UIView+ZTTabbar.h"
#import "ZTTabbarConstant.h"
@implementation ZTTabbarItemModel
- (instancetype)initWithNormalImageName:(NSString *)normalImageName andSelectImageName:(NSString *)selectImageName andTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.normalImageName = normalImageName;
        self.selectImageName = selectImageName;
        self.title           = title;
    }
    return self;
}
- (BOOL)isModelValidate {
    return !STR_IS_EMPTY(self.normalImageName);
}
@end
