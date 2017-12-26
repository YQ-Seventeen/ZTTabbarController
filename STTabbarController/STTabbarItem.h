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

