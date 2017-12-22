//
//  STTabbar.h
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "STTabbarItemModel.h"
@interface STTabbar : UIView
@property (weak, nonatomic) NSArray<STTabbarItemModel *> *items;
@property (weak, nonatomic) NSArray *itemAttributes;
@property (assign, nonatomic) NSInteger selectIndex;
@end
