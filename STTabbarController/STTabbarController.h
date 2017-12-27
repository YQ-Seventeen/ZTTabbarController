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
#import "STTabbarConstant.h"
@class STTabbarController;
@protocol STTabbarControllerDelegate <NSObject>
@optional
- (void)STTabbarController:(STTabbarController *)tabbarController willChangeSelectIndex:(NSInteger)selectIndex;
- (void)STTabbarController:(STTabbarController *)tabbarController didChangeSelectIndex:(NSInteger)selectIndex;
- (BOOL)STTabbarController:(STTabbarController *)tabbarController shouldChangeSelectIndex:(NSInteger)selectIndex;
@end
@interface STTabbarController : UIViewController
// the rectEdge is type of 'UIRectEdge' you can set this property to modify all ChildViewController's 'edgesForExtendedLayout' property. default is 'UIRectEdgeAll'
@property (assign, nonatomic) UIRectEdge rectEdge NS_AVAILABLE_IOS(7_0);
// a array that contain all child viewControllers
@property (strong, nonatomic) NSArray<__kindof UIViewController *> *childViewControllers;
// a array that contain tabbarItem DataSource
@property (strong, nonatomic) NSArray<__kindof STTabbarItemModel *> *items;
// set this property to change backgroundColor of the tabbar.default is [UIColor whiteColor]
@property (strong, nonatomic) UIColor *backgroundViewColor;
// tabbar select Index. default is 0 you can call getter method to get current selectIndex
@property (assign, nonatomic) NSInteger selectIndex;
// a delegate object that can receive many things after click tabbarItems
@property (weak, nonatomic) id<STTabbarControllerDelegate> delegate;
// a attribute object which descibe the appearce of all tabbarItems
@property (strong, nonatomic, readonly) STTabbarItemAttribute *itemAttributeAppearce;
// a array to describe tabbarItems appearce.set this property can make items behavior different
@property (strong, nonatomic, readonly) NSArray<STTabbarItemAttribute *> *itemsAttributes;
// return a flag about whether tabbar hidden or not
@property (assign, nonatomic, readonly) BOOL isTabbarHidden;

/**
 init tabbar with items and default appearce object

 @param items items
 @return a valid tabbarController instance
 */
- (instancetype)initWithTabbarItemModels:(__kindof NSArray<STTabbarItemModel *> *)items;
/**
 init tabbar with items and current appearce object
 
 @param items items
 @param appearceAttribute appearceAttribute
 @return a valid tabbarController instance
 */
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<STTabbarItemModel *> *)items ItemAppearce:(STTabbarItemAttribute *)appearceAttribute;
/**
 init tabbar with items and current appearces array
 
 @param items items
 @param attributes attributes
 @return a valid tabbarController instance
 */
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<STTabbarItemModel *> *)items ItemModelsAttribute:(NSArray<STTabbarItemAttribute *> *)attributes;

- (void)setTabbarHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)setTabbarHidden:(BOOL)hidden;
@end


@interface UIViewController (STTabbarController)
@property (strong, nonatomic) STTabbarController *st_tabbar;
@property (assign, nonatomic) BOOL hidesTabbarWhenPushed;
@end

