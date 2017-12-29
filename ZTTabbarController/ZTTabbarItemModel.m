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
- (instancetype)initWithNormalImageName:(id)imageName andSelectImageName:(id)selectImageName andTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.imageName       = imageName;
        self.selectImageName = selectImageName;
        self.title           = title;
    }
    return self;
}
- (BOOL)isModelValidate {
    if ([self.imageName isKindOfClass:[NSString class]]) {
        return !ZTJudge_STR_EMPTY(((NSString *) self.imageName));
    } else if ([self.imageName isKindOfClass:[NSArray class]]) {
        return ((NSArray *) self.imageName).count;
    } else {
        return NO;
    }
}
@end
