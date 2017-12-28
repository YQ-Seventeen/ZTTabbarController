//
//  ZTTabbarController.h
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZTTabbarItemModel.h"
#import "ZTTabbarItemAttribute.h"
#import "ZTTabbarConstant.h"
@class ZTTabbarController;
@protocol ZTTabbarControllerDelegate <NSObject>
@optional
- (void)ZTTabbarController:(ZTTabbarController *)tabbarController willChangeSelectIndex:(NSInteger)selectIndex;
- (void)ZTTabbarController:(ZTTabbarController *)tabbarController didChangeSelectIndex:(NSInteger)selectIndex;
- (BOOL)ZTTabbarController:(ZTTabbarController *)tabbarController shouldChangeSelectIndex:(NSInteger)selectIndex;
@end
@interface ZTTabbarController : UIViewController
// the rectEdge is type of 'UIRectEdge' you can set this property to modify all ChildViewController's 'edgesForExtendedLayout' property. default is 'UIRectEdgeAll'
@property (assign, nonatomic) UIRectEdge rectEdge NS_AVAILABLE_IOS(7_0);
// a array that contain all child viewControllers
@property (strong, nonatomic) NSArray<__kindof UIViewController *> *childViewControllers;
// a array that contain tabbarItem DataSource
@property (strong, nonatomic) NSArray<__kindof ZTTabbarItemModel *> *items;
// set this property to change backgroundColor of the tabbar.default is [UIColor whiteColor]
@property (strong, nonatomic) UIColor *backgroundViewColor;
// tabbar select Index. default is 0 you can call getter method to get current selectIndex
@property (assign, nonatomic) NSInteger selectIndex;
// a delegate object that can receive many things after click tabbarItems
@property (weak, nonatomic) id<ZTTabbarControllerDelegate> delegate;
// a attribute object which descibe the appearce of all tabbarItems
@property (strong, nonatomic, readonly) ZTTabbarItemAttribute *itemAttributeAppearce;
// a array to describe tabbarItems appearce.set this property can make items behavior different
@property (strong, nonatomic, readonly) NSArray<ZTTabbarItemAttribute *> *itemsAttributes;
// return a flag about whether tabbar hidden or not
@property (assign, nonatomic, readonly) BOOL isTabbarHidden;

/**
 init tabbar with items and default appearce object

 @param items items
 @return a valid tabbarController instance
 */
- (instancetype)initWithTabbarItemModels:(__kindof NSArray<ZTTabbarItemModel *> *)items;
/**
 init tabbar with items and current appearce object
 
 @param items items
 @param appearceAttribute appearceAttribute
 @return a valid tabbarController instance
 */
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<ZTTabbarItemModel *> *)items ItemAppearce:(ZTTabbarItemAttribute *)appearceAttribute;
/**
 init tabbar with items and current appearces array
 
 @param items items
 @param attributes attributes
 @return a valid tabbarController instance
 */
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<ZTTabbarItemModel *> *)items ItemModelsAttribute:(NSArray<ZTTabbarItemAttribute *> *)attributes;

- (void)setTabbarHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)setTabbarHidden:(BOOL)hidden;
@end


@interface UIViewController (ZTTabbarController)
@property (strong, nonatomic) ZTTabbarController *zt_tabbar;
@property (assign, nonatomic) BOOL hidesTabbarWhenPushed;
@end

