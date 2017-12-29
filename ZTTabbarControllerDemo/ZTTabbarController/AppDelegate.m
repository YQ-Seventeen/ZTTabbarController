//
//  AppDelegate.m
//  ZTTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import "AppDelegate.h"
#import "ZTTabbarController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
@interface AppDelegate ()<ZTTabbarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow * mainWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    self.window = mainWindow;
    
    ZTTabbarItemAttribute * attribute = [ZTTabbarItemAttribute defaultAttribute];
    attribute.itemImgSize = CGSizeMake(35, 35);
    ZTTabbarController * tabbarController  = [ZTTabbarController tabbarWithItemModels:[self models] ItemAppearce:attribute];
    [tabbarController setChildViewControllers:[self viewControllers]];
    tabbarController.delegate = self;
    tabbarController.rectEdge = UIRectEdgeNone;
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSArray <ZTTabbarItemModel *> *)models {
    ZTTabbarItemModel * model1 = [[ZTTabbarItemModel alloc]initWithNormalImageName:@"1_select" andSelectImageName:[self gifArray] andTitle:@"测试标题1"];
    ZTTabbarItemModel * model2 = [[ZTTabbarItemModel alloc]initWithNormalImageName:@"2_normal" andSelectImageName:@"2_select" andTitle:@"测试标题2"];
    ZTTabbarItemModel * model3 = [[ZTTabbarItemModel alloc]initWithNormalImageName:@"3_normal" andSelectImageName:@"3_select" andTitle:@"测试标题3"];
    ZTTabbarItemModel * model4 = [[ZTTabbarItemModel alloc]initWithNormalImageName:@"4_normal" andSelectImageName:@"4_select" andTitle:@"测试标题4"];
    return @[model1,model2,model3,model4];
}
- (NSMutableArray *)gifArray {
    NSMutableArray * gifArr = [NSMutableArray new];
    for (NSInteger i =1; i<=60; ++i) {
        [gifArr addObject:[NSString stringWithFormat:@"dropdown_anim__000%ld",i]];
    }
    return gifArr;
}

- (NSArray <UIViewController *>*)viewControllers {
    return @[[self navcWithVC:[ViewController1 new]],[self navcWithVC:[ViewController2 new]],[self navcWithVC:[ViewController3 new]],[self navcWithVC:[ViewController4 new]]];
}


- (UINavigationController *)navcWithVC:(UIViewController *)vc {
    return [[UINavigationController alloc]initWithRootViewController:vc];
}


#pragma mark -- STTabbarControllerDelegate

- (BOOL)ZTTabbarController:(ZTTabbarController *)tabbarController shouldChangeSelectIndex:(NSInteger)selectIndex {
    if (selectIndex == 2) {
        return NO;
    }
    return YES;
}

- (void)ZTTabbarController:(ZTTabbarController *)tabbarController didChangeSelectIndex:(NSInteger)selectIndex {
    NSLog(@"————%s——--",_cmd);
}

- (void)ZTTabbarController:(ZTTabbarController *)tabbarController willChangeSelectIndex:(NSInteger)selectIndex {
    NSLog(@"————%s——--",_cmd);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
