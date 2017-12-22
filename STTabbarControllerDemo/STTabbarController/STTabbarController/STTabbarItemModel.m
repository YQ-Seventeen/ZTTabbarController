//
//  STTabbarItemModel.m
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "STTabbarItemModel.h"
#import "UIView+STTabbar.h"
@implementation STTabbarItemModel
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
    return self.normalImageName.length > 0;
}
@end
