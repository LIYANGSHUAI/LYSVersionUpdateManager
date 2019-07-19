//
//  AppDelegate.m
//  LYSVersionUpdateManagerDemo
//
//  Created by HENAN on 2019/7/18.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "AppDelegate.h"
#import "LYSVersionUpdateManager.h"
#import <LYSReachabilityManager/LYSReachabilityManager.h>
@interface AppDelegate ()<LYSVersionUpdateManagerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [LYSVersionUpdateManager regiserWithTarget:self];
    
    return YES;
}

- (void)lys_willUpdateVersionWithManager:(LYSVersionUpdateManager *)manager
{
    LYSIF_NETWORK_WIFI_BEGIN
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [manager updateVersionNum:@"2.0.0" dataParms:@{@"newVersion":@"2.0.0"}];
    });
    LYSIF_NETWORK_END
}

- (void)lys_startUpdateVersionWithManager:(LYSVersionUpdateManager *)manager
{
    NSString *message = [NSString stringWithFormat:@"检测到新版本%@,是否更新?",manager.dataParms[@"newVersion"]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [manager complateHandle];
    }];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"更新" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [manager complateHandle];
    }];
    [alert addAction:cancelAction];
    [alert addAction:commitAction];
    UIViewController *vc = self.window.rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
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
