//
//  STTabbarController.m
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "STTabbarController.h"
#import "STTabbar.h"
#import "UIView+Util.h"
#import "UIViewController+STTabbarController.h"
#define MAX_ITEM_COUNT 5
#define TABBAR_SYSTEM_HEIGHT 49.0f
@interface STTabbarController ()
@end
@implementation STTabbarController {
    NSArray<STTabbarItemModel *> *_items;
    UIViewController *_topViewController;
    UIEdgeInsets *_contentInset;
    STTabbar *_tabbar;
    float _tabbarHiddenY;
    float _tabbarDisplayY;
}
#pragma mark-- lifeCycle
- (instancetype)init {
    return [self initWithTabbarItemModels:nil];
}
- (instancetype)initWithTabbarItemModels:(__kindof NSArray<STTabbarItemModel *> *)items {
    self = [super init];
    if (self) {
        [self initialization];
        if (items) {
            _items = items;
        }
    }
    return self;
}
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<STTabbarItemModel *> *)items ItemAppearce:(STTabbarItemAttribute *)appearceAttribute ItemModelsAttribute:(NSArray<STTabbarItemAttribute *> *)attributes {
    STTabbarController *tabbarController   = [[self alloc] initWithTabbarItemModels:items];
    tabbarController.itemAttributeAppearce = appearceAttribute;
    tabbarController.itemsAttributes       = attributes;
    return tabbarController;
}
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<STTabbarItemModel *> *)items ItemAppearce:(STTabbarItemAttribute *)appearceAttribute {
    STTabbarController *tabbarController   = [[self alloc] initWithTabbarItemModels:items];
    tabbarController.itemAttributeAppearce = appearceAttribute;
    return tabbarController;
}
+ (instancetype)tabbarWithItemModels:(__kindof NSArray<STTabbarItemModel *> *)items ItemModelsAttribute:(NSArray<STTabbarItemAttribute *> *)attributes {
    STTabbarController *tabbarController = [[self alloc] initWithTabbarItemModels:items];
    tabbarController.itemsAttributes     = attributes;
    return tabbarController;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickTabbarItemAction:) name:@"STTabbarItemDidClickNotification" object:nil];
    // Do any additional setup after loading the view.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillLayoutSubviews {
}
#pragma mark-- setup
- (void)initialization {
    self.view.backgroundColor  = [UIColor whiteColor];
    self.itemAttributeAppearce = [STTabbarItemAttribute defaultAttribute];
    self.rectEdge              = UIRectEdgeNone;
}
- (void)dalayInitialization {
    _tabbarHiddenY  = self.view.st_h;
    _tabbarDisplayY = self.view.st_h - _tabbar.st_h;
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
}
- (void)makeChildRelateRootTabbarController {
    [self.childViewControllers makeObjectsPerformSelector:@selector(setSt_tabbar:) withObject:self];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isKindOfClass:[UINavigationController class]]) {
            UIViewController *containerVC = ((UINavigationController *) obj).topViewController;
            containerVC.st_tabbar         = self;
        }
    }];
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
    float tabbarW    = self.view.st_w;
    float tabbarH    = TABBAR_SYSTEM_HEIGHT;
    float tabbarX    = 0;
    float tabbarY    = self.view.st_maxY - tabbarH;
    STTabbar *tabbar = [[STTabbar alloc] initWithFrame:CGRectMake(tabbarX, tabbarY, tabbarW, tabbarH)];
    [self.view addSubview:tabbar];
    _tabbar               = tabbar;
    tabbar.itemAttributes = self.itemsAttributes;
    tabbar.items          = _items;
    self.selectIndex      = 0;
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
#define ST_NAVAGATIO
- (void)updateContentFrame {
    _topViewController.view.frame = CGRectMake(0, 0, self.view.st_w, self.view.st_h);
}
#pragma mark-- Notification CallBack
- (void)clickTabbarItemAction:(NSNotification *)notif {
    NSNumber *argument    = notif.object;
    NSInteger selectIndex = argument.integerValue;
    BOOL isSkip           = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(STTabbarController:ShouldChangeSelectIndex:)]) {
        isSkip = ![self.delegate STTabbarController:self ShouldChangeSelectIndex:selectIndex];
    }
    if (isSkip) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(STTabbarController:WillChangeSelectIndex:)]) {
        [self.delegate STTabbarController:self WillChangeSelectIndex:selectIndex];
    }
    self.selectIndex = argument.integerValue;
    if (self.delegate && [self.delegate respondsToSelector:@selector(STTabbarController:DidChangeSelectIndex:)]) {
        [self.delegate STTabbarController:self DidChangeSelectIndex:selectIndex];
    }
}
#pragma mark-- public Methods
- (void)setItems:(NSArray<__kindof STTabbarItemModel *> *)items {
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
    [self dalayInitialization];
}
- (void)setSelectIndex:(NSInteger)selectIndex {
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
                             _tabbar.st_y = afterHeight;
                         }];
    };
    if (animated) {
        animatedBlock();
    } else {
        _tabbar.st_y = afterHeight;
    }
}
- (BOOL)isTabbarHidden {
    return !CGRectContainsRect(self.view.frame, _tabbar.frame);
}
- (void)setTabbarHidden:(BOOL)hidden {
    [self setTabbarHidden:hidden animated:NO];
}
- (void)setItemAttributeAppearce:(STTabbarItemAttribute *)itemAttributeAppearce {
    if (itemAttributeAppearce) {
        _itemAttributeAppearce = itemAttributeAppearce;
    }
}
- (void)setItemsAttributes:(NSArray<STTabbarItemAttribute *> *)itemsAttributes {
    if (itemsAttributes) {
        _itemsAttributes = itemsAttributes;
    }
}
@end
