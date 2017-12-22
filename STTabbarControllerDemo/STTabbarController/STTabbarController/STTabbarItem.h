//
//  STTabbarItem.h
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@class STTabbarItemModel;
@class STTabbarItemAttribute;
@class STTabbarController;
@interface STTabbarItem : UIView
@property (weak, nonatomic) STTabbarItemModel *dataModel;
@property (weak, nonatomic) STTabbarItemAttribute *attribute;
@property (assign, nonatomic) BOOL select;
@end
@interface UIView (STTabbar)
@property (strong, nonatomic) STTabbarController *st_tabbar;
@end
@implementation UIView (STTabbar)
- (void)setSt_tabbar:(STTabbarController *)st_tabbar {
    if (st_tabbar) {
        SEL storeKey = @selector(st_tabbar);
        objc_setAssociatedObject(self, storeKey, st_tabbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (STTabbarController *)st_tabbar {
    return objc_getAssociatedObject(self, _cmd);
}
@end
