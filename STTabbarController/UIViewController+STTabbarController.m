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

- (void)setSt_tabbar:(STTabbarController *)st_tabbar {
    if (st_tabbar) {
        SEL storeKey = @selector(st_tabbar);
        objc_setAssociatedObject(self, storeKey, st_tabbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (STTabbarController *)st_tabbar {
    STTabbarController * tabbarController = objc_getAssociatedObject(self, _cmd);
    if (tabbarController) {
        return tabbarController;
    }
    else{
        if (self.navigationController) {
            return self.navigationController.st_tabbar;
        }
        else if(self.presentingViewController){
            return self.presentingViewController.st_tabbar;
        }
        else{
            return nil;
        }
    }
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
