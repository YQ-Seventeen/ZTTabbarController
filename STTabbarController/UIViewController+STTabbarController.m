//
//  UIViewController+STTabbarController.m
//  STTabbarController
//
//  Created by yq on 2017/12/21.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "UIViewController+STTabbarController.h"
#import <objc/runtime.h>
@implementation UIViewController (STTabbarController)

+ (void)load {
    Method viewWillAppear = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method st_viewWillAppear = class_getInstanceMethod([self class], @selector(st_viewWillAppear:));
    method_exchangeImplementations(viewWillAppear, st_viewWillAppear);
}

- (void)st_viewWillAppear:(BOOL)animated {
    [self st_viewWillAppear:animated];
    if (!self.navigationController) {
        return;
    }
    if (self.navigationController.childViewControllers.count == 1) {
        return;
    }
    if (self.st_tabbar.isTabbarHidden == NO && self.hidesTabbarWhenPushed) {
        [self.st_tabbar setTabbarHidden:YES];
    }
}

- (void)setSt_tabbar:(STTabbarController *)st_tabbar {
    if (st_tabbar) {
        SEL storeKey = @selector(st_tabbar);
        objc_setAssociatedObject(self, storeKey, st_tabbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (STTabbarController *)st_tabbar {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setHidesTabbarWhenPushed:(BOOL)hidesTabbarWhenPushed {
    SEL storeKey = @selector(hidesTabbarWhenPushed);
    objc_setAssociatedObject(self, storeKey, @(hidesTabbarWhenPushed), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)hidesTabbarWhenPushed {
    NSNumber *hidesTabbarWhenPushed = objc_getAssociatedObject(self, _cmd);
    return hidesTabbarWhenPushed.boolValue;
}
@end
