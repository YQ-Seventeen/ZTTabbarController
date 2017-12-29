//
//  ZTTabbarItem.h
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@class ZTTabbarItemModel;
@class ZTTabbarItemAttribute;
@class ZTTabbarController;
@interface ZTTabbarItem : UIView
@property (weak, nonatomic) ZTTabbarItemModel *dataModel;
@property (weak, nonatomic) ZTTabbarItemAttribute *attribute;
@property (strong, nonatomic) NSNumber * select;
@property (assign,nonatomic) NSInteger  index;
@end

