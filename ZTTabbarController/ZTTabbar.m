//
//  ZTTabbar.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "ZTTabbar.h"
#import "ZTTabbarItem.h"
#import "UIView+ZTTabbar.h"
#import "ZTTabbarConstant.h"
@implementation ZTTabbar {
    NSArray<ZTTabbarItem *> *_tabbarItems;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (_tabbarItems.count) {
        [self updateTabbarItemFrame];
    }
}

- (void)setItems:(NSArray<ZTTabbarItemModel *> *)items {
    if (_items != items) {
        _items = items;
        [self setupTabbar];
    }
}
- (void)setupTabbar {
    CGFloat w            = self.zt_w / _items.count;
    CGFloat h            = ZTTabbarContentHeight;
    NSMutableArray *temp = [NSMutableArray new];
    for (NSInteger i = 0, max = self.items.count; i < max; ++i) {
        ZTTabbarItem *tabbarItem = [[ZTTabbarItem alloc] init];
        CGFloat x                = i * w;
        CGFloat y                = 0;
        tabbarItem.frame         = (CGRect){x, y, w, h};
        tabbarItem.attribute     = self.itemAttributes[i];
        tabbarItem.dataModel     = self.items[i];
        tabbarItem.tag           = i;
        tabbarItem.index         = i;
        [self insertSubview:tabbarItem atIndex:0];
        [temp addObject:tabbarItem];
    }
    _tabbarItems = temp;
}



- (void)updateTabbarItemFrame {
    CGFloat w            = self.zt_w / _items.count;
    CGFloat h            = ZTTabbarContentHeight;
    for (ZTTabbarItem * tabbarItem in _tabbarItems) {
        NSInteger i   = [_tabbarItems indexOfObject:tabbarItem];
        CGFloat x                = i * w;
        CGFloat y                = 0;
        tabbarItem.frame         = (CGRect){x, y, w, h};
    }
}


- (void)setSelectIndex:(NSInteger)selectIndex {
    NSArray *items = self->_tabbarItems;
    for (ZTTabbarItem *item in items) {
        NSInteger index = [items indexOfObject:item];
        if (index == selectIndex) {
            item.select = @YES;
        } else {
            item.select = @NO;
        }
    }
}
@end


@implementation ZTTabbar (BadgeView)
- (void)showBadgeNumber:(NSInteger)badgeNumber atTabbarIndex:(NSInteger)tabbarIndex {
    [self->_tabbarItems[tabbarIndex] showBadgeNumber:badgeNumber];
}
- (void)hiddenBadgeViewAtTabbarIndex:(NSInteger)tabbarIndex {
    [self->_tabbarItems[tabbarIndex] hiddenBadgeNumber];
}
@end
