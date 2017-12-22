//
//  AppDelegate.m
//  STTabbarController
//
//  Created by yq on 2017/12/20.
//  Copyright © 2017年 Suning. All rights reserved.
//

#import "AppDelegate.h"
#import "STTabbarController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
@interface AppDelegate ()<STTabbarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow * mainWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    self.window = mainWindow;
    
    STTabbarItemAttribute * attribute = [STTabbarItemAttribute defaultAttribute];
    STTabbarController * tabbarController  = [STTabbarController tabbarWithItemModels:[self models] ItemAppearce:attribute];
    [tabbarController setChildViewControllers:[self viewControllers]];
    tabbarController.delegate = self;
    tabbarController.rectEdge = UIRectEdgeNone;
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSArray <STTabbarItemModel *> *)models {
    STTabbarItemModel * model1 = [[STTabbarItemModel alloc]initWithNormalImageName:@"1_normal" andSelectImageName:@"1_select" andTitle:@"测试标题1"];
    STTabbarItemModel * model2 = [[STTabbarItemModel alloc]initWithNormalImageName:@"2_normal" andSelectImageName:@"2_select" andTitle:@"测试标题2"];
    STTabbarItemModel * model3 = [[STTabbarItemModel alloc]initWithNormalImageName:@"3_normal" andSelectImageName:@"3_select" andTitle:@"测试标题3"];
    STTabbarItemModel * model4 = [[STTabbarItemModel alloc]initWithNormalImageName:@"4_normal" andSelectImageName:@"4_select" andTitle:@"测试标题4"];
    return @[model1,model2,model3,model4];
}

- (NSArray <UIViewController *>*)viewControllers {
    return @[[self navcWithVC:[ViewController1 new]],[self navcWithVC:[ViewController2 new]],[self navcWithVC:[ViewController3 new]],[self navcWithVC:[ViewController4 new]]];
}


- (UINavigationController *)navcWithVC:(UIViewController *)vc {
    return [[UINavigationController alloc]initWithRootViewController:vc];
}


#pragma mark -- STTabbarControllerDelegate

- (BOOL)STTabbarController:(STTabbarController *)tabbarController ShouldChangeSelectIndex:(NSInteger)selectIndex {
    if (selectIndex == 2) {
        return NO;
    }
    return YES;
}

- (void)STTabbarController:(STTabbarController *)tabbarController DidChangeSelectIndex:(NSInteger)selectIndex {
    NSLog(@"————%s——--",_cmd);
}

- (void)STTabbarController:(STTabbarController *)tabbarController WillChangeSelectIndex:(NSInteger)selectIndex {
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
