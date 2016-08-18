//
//  AppDelegate.m
//  XiaoMiZuChe
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 QZ. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import <Bugly/Bugly.h>
/**
 高德地图
 */
#import "APIKey.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>

/**
 *  短信
 */
#import "AFNetworkActivityIndicatorManager.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //地图
    [self configureAPIKey];
    [self configurationWindowRootVC];

    return YES;
}
#pragma mark - rootVc
- (void)configurationWindowRootVC
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    //设置缓存
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
     [Bugly startWithAppId:@"此处替换为你的AppId"];
    kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
        
        //键盘配置
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = YES;
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    });
    [APIRequest automaticLoginEventResponse];

//    [NSThread sleepForTimeInterval:2.f];
    //tabbar
   
    self.tabBarControllerConfig = [[ZCTabBarControllerConfig alloc] init];
    self.tabBarControllerConfig.tabBarController.delegate = self;
    [self.window setRootViewController:self.tabBarControllerConfig.tabBarController];
    [self.window makeKeyAndVisible];
}
#pragma mark - 配置地图
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"apiKey为空，请检查key是否正确设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}

#pragma mark -UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
        if ([PublicFunction shareInstance].m_bLogin == NO) {
            LoginViewController *loginVC = [LoginViewController new];
            [tabBarController presentViewController:[[UINavigationController alloc]initWithRootViewController:loginVC] animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
