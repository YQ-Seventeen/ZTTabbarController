//
//  ZTTabbar.h
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZTTabbarItemModel.h"
@interface ZTTabbar : UIView
@property (weak, nonatomic) NSArray<ZTTabbarItemModel *> *items;
@property (weak, nonatomic) NSArray *itemAttributes;
@property (assign, nonatomic) NSInteger selectIndex;
@property (strong, nonatomic) UIColor *bgColor;
@end


@interface ZTTabbar (BadgeView)
- (void)showBadgeNumber:(NSInteger)badgeNumber atTabbarIndex:(NSInteger)tabbarIndex;
- (void)hiddenBadgeViewAtTabbarIndex:(NSInteger)tabbarIndex;
@end
