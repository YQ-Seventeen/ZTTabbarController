//
//  ZTTabbarController.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "ZTTabbarController.h"
#import "ZTTabbar.h"
#import "UIView+ZTTabbar.h"
#import "ZTTabbarConstant.h"
#import <objc/runtime.h>
#define MAX_ITEM_COUNT 5
@interface ZTTabbarController ()
@end
@implementation ZTTabbarController {
    NSArray<ZTTabbarItemModel *> *_items;
    UIViewController *_topViewController;
    UIEdgeInsets *_contentInset;
    ZTTabbar *_tabbar;
    float _tabbarHiddenY;
    float _tabbarDisplayY;
}
#pragma mark-- lifeCycle
- (instancetype)init {
    return [self initWithTabbarItemModels:nil];
}
- (instancetype)initWithTabbarItemModels:(__kindof NSArray<ZTTabbarItemModel *> *)items {
    self = [super init];
    if (self) {
        [self initialization];
        if (items) {
            _items = items;
        }
    }
    return self;
}
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<ZTTabbarItemModel *> *)items ItemAppearce:(ZTTabbarItemAttribute *)appearceAttribute ItemModelsAttribute:(NSArray<ZTTabbarItemAttribute *> *)attributes {
    ZTTabbarController *tabbarController   = [[self alloc] initWithTabbarItemModels:items];
    tabbarController.itemAttributeAppearce = appearceAttribute;
    tabbarController.itemsAttributes       = attributes;
    return tabbarController;
}
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<ZTTabbarItemModel *> *)items ItemAppearce:(ZTTabbarItemAttribute *)appearceAttribute {
    ZTTabbarController *tabbarController   = [[self alloc] initWithTabbarItemModels:items];
    tabbarController.itemAttributeAppearce = appearceAttribute;
    return tabbarController;
}
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<ZTTabbarItemModel *> *)items ItemModelsAttribute:(NSArray<ZTTabbarItemAttribute *> *)attributes {
    ZTTabbarController *tabbarController = [[self alloc] initWithTabbarItemModels:items];
    tabbarController.itemsAttributes     = attributes;
    return tabbarController;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickTabbarItemAction:) name:@"ZTTabbarItemDidClickNotification" object:nil];
    // Do any additional setup after loading the view.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillLayoutSubviews {
    _tabbarHiddenY  = self.view.zt_h;
    _tabbarDisplayY = self.view.zt_h - _tabbar.zt_h;
    [self updateContentFrame];
    [self updateTabbar];
}
#pragma mark-- Horizontal vertical screen
- (BOOL)shouldAutorotate {
    return [[self displayViewController] shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self displayViewController] supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self displayViewController] preferredInterfaceOrientationForPresentation];
}
- (UIViewController *)displayViewController {
    UIViewController *displayVC = [self.childViewControllers objectAtIndex:self.selectIndex];
    if ([displayVC isKindOfClass:[UINavigationController class]]) {
        displayVC = [((UINavigationController *) displayVC) topViewController];
    }
    return displayVC;
}
#pragma mark-- setup
- (void)initialization {
    self.view.backgroundColor  = [UIColor whiteColor];
    self.itemAttributeAppearce = [ZTTabbarItemAttribute defaultAttribute];
    self.rectEdge              = UIRectEdgeNone;
}
- (void)setup_afterSetChildVC {
    //set childViewControllers edgesForExtendedLayout
    if (self.rectEdge != UIRectEdgeAll) {
        for (UIViewController *childVC in self.childViewControllers) {
            if ([childVC isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navc                  = (UINavigationController *) childVC;
                navc.topViewController.edgesForExtendedLayout = self.rectEdge;
            } else {
                childVC.edgesForExtendedLayout = self.rectEdge;
            }
        }
    }
    [self makeChildRelateRootTabbarController];
    //check items title if not exist then use childViewController's title if it exists
    [self checkItemsTitle];
}
- (void)makeChildRelateRootTabbarController {
    [self.childViewControllers makeObjectsPerformSelector:@selector(setZt_tabbar:) withObject:self];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isKindOfClass:[UINavigationController class]]) {
            UIViewController *containerVC = ((UINavigationController *) obj).topViewController;
            containerVC.zt_tabbar         = self;
        }
    }];
}
- (void)checkItemsTitle {
    for (ZTTabbarItemModel *itemModel in _tabbar.items) {
        NSInteger index      = [_tabbar.items indexOfObject:itemModel];
        UIViewController *vc = self.childViewControllers[index];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *) vc topViewController];
        }
        if (ZTJudge_STR_EMPTY(itemModel.title) && !ZTJudge_STR_EMPTY(vc.title)) {
            itemModel.title = vc.title;
        }
    }
}
- (void)setupTabbar {
    if (!_items || !_items.count || _items.count > MAX_ITEM_COUNT) {
        NSAssert(NO, @"error");
    }
    if (!_childViewControllers || !_childViewControllers.count || _childViewControllers.count > MAX_ITEM_COUNT) {
        NSAssert(NO, @"error");
    }
    NSAssert([self checkAttribute], @"attribute error");
    [self generateAttributes];
    [self createTabbar];
    self.selectIndex = 0;
}
- (void)createTabbar {
    if (_tabbar) {
        [self updateTabbar];
    } else {
        float tabbarW    = self.view.zt_w;
        float tabbarH    = ZTTabbarDefaultHeight;
        float tabbarX    = 0;
        float tabbarY    = self.view.zt_maxY - tabbarH;
        ZTTabbar *tabbar = [[ZTTabbar alloc] initWithFrame:CGRectMake(tabbarX, tabbarY, tabbarW, tabbarH)];
        [self.view addSubview:tabbar];
        _tabbar               = tabbar;
        tabbar.itemAttributes = self.itemsAttributes;
        tabbar.items          = _items;
    }
}
- (void)updateTabbar {
    if (!_tabbar) {
        [self createTabbar];
        return;
    }
    float tabbarW = self.view.zt_w;
    float tabbarH = ZTTabbarDefaultHeight;
    float tabbarX = 0;
    float tabbarY = self.view.zt_maxY - tabbarH;
    _tabbar.frame = (CGRect){tabbarX, tabbarY, tabbarW, tabbarH};
}
- (BOOL)checkAttribute {
    if (self.itemsAttributes && self.itemsAttributes.count < _items.count) {
        return NO;
    }
    return YES;
}
- (void)generateAttributes {
    if (self.itemsAttributes) {
        self.itemsAttributes = [self.itemsAttributes subarrayWithRange:NSMakeRange(0, _items.count)];
    } else {
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:_items.count];
        for (NSInteger i = 0, max = _items.count; i < max; ++i) {
            //just hold point not content copy it's doesn't matter
            [temp addObject:self.itemAttributeAppearce];
        }
        self.itemsAttributes = temp;
    }
}
- (void)updateContentFrame {
    UIViewController *displayVC = [self displayViewController];
    if (displayVC.navigationController) {
        displayVC.navigationController.view.frame = CGRectMake(0, 0, self.view.zt_w, self.view.zt_h);
    }
    displayVC.view.frame = CGRectMake(0, 0, self.view.zt_w, self.view.zt_h);
}
#pragma mark-- Notification CallBack
- (void)clickTabbarItemAction:(NSNotification *)notif {
    NSNumber *argument    = notif.object;
    NSInteger selectIndex = argument.integerValue;
    BOOL isSkip           = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZTTabbarController:shouldChangeSelectIndex:)]) {
        isSkip = ![self.delegate ZTTabbarController:self shouldChangeSelectIndex:selectIndex];
    }
    if (isSkip) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZTTabbarController:willChangeSelectIndex:)]) {
        [self.delegate ZTTabbarController:self willChangeSelectIndex:selectIndex];
    }
    self.selectIndex = argument.integerValue;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZTTabbarController:didChangeSelectIndex:)]) {
        [self.delegate ZTTabbarController:self didChangeSelectIndex:selectIndex];
    }
}
#pragma mark-- public Methods
- (void)setBackgroundViewColor:(UIColor *)backgroundViewColor {
    if (backgroundViewColor && _backgroundViewColor != backgroundViewColor) {
        _backgroundViewColor    = backgroundViewColor;
        _tabbar.backgroundColor = backgroundViewColor;
    }
}
- (void)setItems:(NSArray<__kindof ZTTabbarItemModel *> *)items {
    if (_items != items) {
        _items = items;
        if (self.childViewControllers.count > 0 && !_tabbar) {
            [self setupTabbar];
        }
    }
}
- (void)setChildViewControllers:(NSArray<__kindof UIViewController *> *)childViewControllers {
    NSAssert(childViewControllers && childViewControllers.count == _items.count, @"error");
    _childViewControllers = childViewControllers;
    if (self.items.count > 0 && !_tabbar) {
        [self setupTabbar];
    }
    [self setup_afterSetChildVC];
}
- (void)setSelectIndex:(NSInteger)selectIndex {
    if (_selectIndex == selectIndex && _topViewController) {
        return;
    }
    _selectIndex = selectIndex;
    if (_topViewController) {
        [_topViewController willMoveToParentViewController:nil];
        [_topViewController.view removeFromSuperview];
        [_topViewController removeFromParentViewController];
    }
    UIViewController *totalTopViewController = self.childViewControllers[selectIndex];
    if (totalTopViewController) {
        _topViewController = totalTopViewController;
        [self addChildViewController:totalTopViewController];
        [self updateContentFrame];
        [self.view insertSubview:_topViewController.view belowSubview:_tabbar];
        [totalTopViewController didMoveToParentViewController:self];
    }
    _tabbar.selectIndex = selectIndex;
}
- (void)setTabbarHidden:(BOOL)hidden animated:(BOOL)animated {
    float afterHeight = _tabbarDisplayY;
    if (hidden) {
        afterHeight = _tabbarHiddenY;
    }
    void (^animatedBlock)(void) = ^{
        [UIView animateWithDuration:0.2
                         animations:^{
                             _tabbar.zt_y = afterHeight;
                         }];
    };
    if (animated) {
        animatedBlock();
    } else {
        _tabbar.zt_y = afterHeight;
    }
}
- (BOOL)isTabbarHidden {
    return !CGRectContainsRect(self.view.frame, _tabbar.frame);
}
- (void)setTabbarHidden:(BOOL)hidden {
    [self setTabbarHidden:hidden animated:NO];
}
- (void)setItemAttributeAppearce:(ZTTabbarItemAttribute *)itemAttributeAppearce {
    if (itemAttributeAppearce) {
        _itemAttributeAppearce = itemAttributeAppearce;
    }
}
- (void)setItemsAttributes:(NSArray<ZTTabbarItemAttribute *> *)itemsAttributes {
    if (itemsAttributes) {
        _itemsAttributes = itemsAttributes;
    }
}
@end
@implementation UIViewController (ZTTabbarController)
- (void)setZt_tabbar:(ZTTabbarController *)zt_tabbar {
    if (zt_tabbar) {
        SEL storeKey = @selector(zt_tabbar);
        objc_setAssociatedObject(self, storeKey, zt_tabbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (ZTTabbarController *)zt_tabbar {
    ZTTabbarController *tabbarController = objc_getAssociatedObject(self, _cmd);
    if (tabbarController) {
        return tabbarController;
    } else {
        if (self.navigationController) {
            return self.navigationController.zt_tabbar;
        } else if (self.presentingViewController) {
            return self.presentingViewController.zt_tabbar;
        } else {
            return nil;
        }
    }
}
- (void)setHidesTabbarWhenPushed:(BOOL)hidesTabbarWhenPushed {
    SEL storeKey = @selector(hidesTabbarWhenPushed);
    objc_setAssociatedObject(self, storeKey, @(hidesTabbarWhenPushed), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)hidesTabbarWhenPushed {
    NSNumber *hidesTabbarWhenPushed = objc_getAssociatedObject(self, _cmd);
    return hidesTabbarWhenPushed.boolValue;
}
@end
