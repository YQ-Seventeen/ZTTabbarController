//
//  STTabbar.m
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "STTabbar.h"
#import "STTabbarItem.h"
#import "UIView+STTabbar.h"
#import "STTabbarConstant.h"
@implementation STTabbar {
    NSArray<STTabbarItem *> *_tabbarItem;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
- (void)setItems:(NSArray<STTabbarItemModel *> *)items {
    if (_items != items) {
        _items = items;
        [self setupTabbar];
    }
}
- (void)setupTabbar {
    CGFloat w            = self.st_w / _items.count;
    CGFloat h            = STTabbarContentHeight;
    NSMutableArray *temp = [NSMutableArray new];
    
    
    
    
    
    for (NSInteger i = 0, max = self.items.count; i < max; ++i) {
        STTabbarItem *tabbarItem = [[STTabbarItem alloc] init];
        CGFloat x                = i * w;
        CGFloat y                = 0;
        tabbarItem.frame         = (CGRect){x, y, w, h};
        tabbarItem.attribute     = self.itemAttributes[i];
        tabbarItem.dataModel     = self.items[i];
        tabbarItem.tag           = i;
        [self insertSubview:tabbarItem atIndex:0];
        [temp addObject:tabbarItem];
    }
    _tabbarItem = temp;
}
- (void)setSelectIndex:(NSInteger)selectIndex {
    NSArray *items = self->_tabbarItem;
    for (STTabbarItem *item in items) {
        NSInteger index = [items indexOfObject:item];
        if (index == selectIndex) {
            item.select = YES;
        } else {
            item.select = NO;
        }
    }
}
@end
