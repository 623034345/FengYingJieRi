//
//  AppDelegate.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/23.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FYJTheConstellationViewController.h"
#import "TheIunarCalendarViewController.h"
#import "YJWiFiViewController.h"
#import "PlayViewController.h"
#import "VPNViewController.h"
#import "HealthViewController.h"
#import "BaseNavigationController.h"
#import "HealthViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)setting3DTouchModule{
    // 判断系统版本大于9.0再设置 (若不判断 在低版本系统中会崩溃)
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        
        // 自定义图标
        UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"AppIcon"];
        
        UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"iOS" localizedTitle:@"星座" localizedSubtitle:@"查看年龄和星座" icon:icon1 userInfo:nil];
        
        UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"iOS" localizedTitle:@"步数" localizedSubtitle:@"添加步数" icon:[UIApplicationShortcutIcon iconWithType: UIApplicationShortcutIconTypeCompose] userInfo:nil];
        
        // item 数组
        NSArray *shortItems = [[NSArray alloc] initWithObjects: shortItem1,shortItem2, nil];
        
        // 设置按钮
        [[UIApplication sharedApplication] setShortcutItems:shortItems];
    }
    
}
// 通过3dtouch菜单启动 后回调
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    HealthViewController *vc = [[HealthViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;

    // 可以通过标题 字符串判断 来确认 是哪个item
    if ([shortcutItem.localizedTitle  isEqualToString: @"星座"])
    {
        FYJTheConstellationViewController *fvc = [[FYJTheConstellationViewController alloc] init];
        [nav pushViewController:fvc animated:YES];
    }
    if ([shortcutItem.localizedTitle  isEqualToString: @"步数"])
    {
        HealthViewController *yvc = [[HealthViewController alloc] init];
        [nav pushViewController:yvc animated:YES];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    HealthViewController *viewController = [[HealthViewController alloc] init];
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];

    [self setting3DTouchModule];
    
    [self loginHome];
    
    return YES;
}

-(void)loginHome
{
    FYJTheConstellationViewController *fvc = [[FYJTheConstellationViewController alloc] init];
    TheIunarCalendarViewController *tvc = [[TheIunarCalendarViewController alloc] init];
    HealthViewController *yvc = [[HealthViewController alloc] init];
    NSArray *tabbarImgs =[NSArray arrayWithObjects:@"健康",@"星座",@"日历", nil];
    NSArray *tabbarSelectImgs =[NSArray arrayWithObjects:@"健康2",@"星座2",@"日历2", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"健康",@"星座",@"日历", nil];
    NSArray *views =[NSArray arrayWithObjects:yvc,tvc,fvc, nil];
    NSMutableArray *navArr =[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i < views.count; i++)
    {
        UIViewController *view =views[i];
        
        view.tabBarItem.selectedImage = [[UIImage imageNamed:[tabbarSelectImgs objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        view.tabBarItem.image = [[UIImage imageNamed:[tabbarImgs objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        view.tabBarItem.title = [titleArr objectAtIndex:i];
        
        view.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
        [view.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-2, -2)];
        
        
        
        BaseNavigationController *nav=[[BaseNavigationController alloc]initWithRootViewController:view];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        [navArr addObject:nav];
        
    }
    
    
    UITabBarController *tabBarVContro =[[UITabBarController alloc]init];
    tabBarVContro.tabBar.tintColor = [UIColor blueColor];
    tabBarVContro.tabBar.opaque = YES;
    tabBarVContro.viewControllers =navArr;
    self.window.rootViewController =tabBarVContro;
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
