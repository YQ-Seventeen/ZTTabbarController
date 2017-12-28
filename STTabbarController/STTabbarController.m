//
//  STTabbarController.m
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//
#import "STTabbarController.h"
#import "STTabbar.h"
#import "UIView+STTabbar.h"
#import "STTabbarConstant.h"
#import <objc/runtime.h>
#define MAX_ITEM_COUNT 5
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
    _tabbarHiddenY  = self.view.st_h;
    _tabbarDisplayY = self.view.st_h - _tabbar.st_h;
    [self updateContentFrame];
    [self updateTabbar];
}

#pragma mark  -- Horizontal vertical screen
- (BOOL)shouldAutorotate {
    return [[self displayViewController]shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {

    return [[self displayViewController]supportedInterfaceOrientations];
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self displayViewController]preferredInterfaceOrientationForPresentation];
}

- (UIViewController *)displayViewController {
    UIViewController * displayVC = [self.childViewControllers objectAtIndex:self.selectIndex];
    if ([displayVC isKindOfClass:[UINavigationController class]]) {
        displayVC = [((UINavigationController *)displayVC) topViewController];
    }
    return displayVC;
}

#pragma mark-- setup
- (void)initialization {
    self.view.backgroundColor  = [UIColor whiteColor];
    self.itemAttributeAppearce = [STTabbarItemAttribute defaultAttribute];
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
    [self.childViewControllers makeObjectsPerformSelector:@selector(setSt_tabbar:) withObject:self];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isKindOfClass:[UINavigationController class]]) {
            UIViewController *containerVC = ((UINavigationController *) obj).topViewController;
            containerVC.st_tabbar         = self;
        }
    }];
}

- (void)checkItemsTitle {
    for (STTabbarItemModel * itemModel in _tabbar.items) {
        NSInteger index = [_tabbar.items indexOfObject:itemModel];
        UIViewController * vc = self.childViewControllers[index];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc topViewController];
        }
        if (STR_IS_EMPTY(itemModel.title) && !STR_IS_EMPTY(vc.title)) {
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
    self.selectIndex      = 0;
}

- (void)createTabbar {
    if (_tabbar) {
        [self updateTabbar];
    }
    else{
        float tabbarW    = self.view.st_w;
        float tabbarH    = STTabbarDefaultHeight;
        float tabbarX    = 0;
        float tabbarY    = self.view.st_maxY - tabbarH;
        STTabbar *tabbar = [[STTabbar alloc] initWithFrame:CGRectMake(tabbarX, tabbarY, tabbarW, tabbarH)];
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
    float tabbarW    = self.view.st_w;
    float tabbarH    = STTabbarDefaultHeight;
    float tabbarX    = 0;
    float tabbarY    = self.view.st_maxY - tabbarH;
    _tabbar.frame = (CGRect){tabbarX,tabbarY,tabbarW,tabbarH};
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
    UIViewController * displayVC = [self displayViewController];
    if(displayVC.navigationController){
        displayVC.navigationController.view.frame = CGRectMake(0, 0, self.view.st_w, self.view.st_h);
    }
    displayVC.view.frame = CGRectMake(0, 0, self.view.st_w, self.view.st_h);
}
#pragma mark-- Notification CallBack
- (void)clickTabbarItemAction:(NSNotification *)notif {
    NSNumber *argument    = notif.object;
    NSInteger selectIndex = argument.integerValue;
    BOOL isSkip           = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(STTabbarController:shouldChangeSelectIndex:)]) {
        isSkip = ![self.delegate STTabbarController:self shouldChangeSelectIndex:selectIndex];
    }
    if (isSkip) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(STTabbarController:willChangeSelectIndex:)]) {
        [self.delegate STTabbarController:self willChangeSelectIndex:selectIndex];
    }
    self.selectIndex = argument.integerValue;
    if (self.delegate && [self.delegate respondsToSelector:@selector(STTabbarController:didChangeSelectIndex:)]) {
        [self.delegate STTabbarController:self didChangeSelectIndex:selectIndex];
    }
}
#pragma mark-- public Methods

- (void)setBackgroundViewColor:(UIColor *)backgroundViewColor {
    if (backgroundViewColor && _backgroundViewColor != backgroundViewColor) {
        _backgroundViewColor = backgroundViewColor;
        _tabbar.backgroundColor = backgroundViewColor;
    }
}

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
    [self setup_afterSetChildVC];
}
- (void)setSelectIndex:(NSInteger)selectIndex {
    if(_selectIndex  == selectIndex) {
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


@implementation UIViewController (STTabbarController)

- (void)setSt_tabbar:(STTabbarController *)st_tabbar {
    if (st_tabbar) {
        SEL storeKey = @selector(st_tabbar);
        objc_setAssociatedObject(self, storeKey, st_tabbar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (STTabbarController *)st_tabbar {
    STTabbarController * tabbarController = objc_getAssociatedObject(self, _cmd);
    if (tabbarController) {
        return tabbarController;
    }
    else{
        if (self.navigationController) {
            return self.navigationController.st_tabbar;
        }
        else if(self.presentingViewController){
            return self.presentingViewController.st_tabbar;
        }
        else{
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
