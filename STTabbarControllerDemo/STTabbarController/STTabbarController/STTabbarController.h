//
//  STTabbarController.h
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "STTabbarItemModel.h"
#import "STTabbarItemAttribute.h"
@class STTabbarController;
@protocol STTabbarControllerDelegate <NSObject>
@optional
- (void)STTabbarController:(STTabbarController *)tabbarController WillChangeSelectIndex:(NSInteger)selectIndex;
- (void)STTabbarController:(STTabbarController *)tabbarController DidChangeSelectIndex:(NSInteger)selectIndex;
- (BOOL)STTabbarController:(STTabbarController *)tabbarController ShouldChangeSelectIndex:(NSInteger)selectIndex;
@end
@interface STTabbarController : UIViewController
@property (assign, nonatomic) UIRectEdge rectEdge;
@property (strong, nonatomic) NSArray<__kindof UIViewController *> *childViewControllers;
@property (strong, nonatomic) NSArray<__kindof STTabbarItemModel *> *items;
@property (assign, nonatomic) BOOL isInitalAllChildVCDirectly;
@property (strong, nonatomic) UIColor *backgroundViewColor;
@property (assign, nonatomic) NSInteger selectIndex;
@property (weak, nonatomic) id<STTabbarControllerDelegate> delegate;
@property (strong, nonatomic, readonly) STTabbarItemAttribute *itemAttributeAppearce;
@property (strong, nonatomic, readonly) NSArray<STTabbarItemAttribute *> *itemsAttributes;
@property (assign, nonatomic, readonly) BOOL isTabbarHidden;
- (instancetype)initWithTabbarItemModels:(__kindof NSArray<STTabbarItemModel *> *)items;
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<STTabbarItemModel *> *)items ItemAppearce:(STTabbarItemAttribute *)appearceAttribute;
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<STTabbarItemModel *> *)items ItemModelsAttribute:(NSArray<STTabbarItemAttribute *> *)attributes;
- (void)setTabbarHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setTabbarHidden:(BOOL)hidden;
@end
