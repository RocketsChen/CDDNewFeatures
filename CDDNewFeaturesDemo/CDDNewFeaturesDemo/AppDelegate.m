//
//  AppDelegate.m
//  CDDNewFeaturesDemo
//
//  Created by 陈甸甸 on 2018/4/22.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//

#import "AppDelegate.h"

#import "DCFeaturesTool.h"
#import "DCNewFeaturesViewController.h"
#import "DCFeatureDemoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setUpRootViewController]; //设置根控制器
    
    [self.window makeKeyAndVisible];
    
    NSLog(@"是否展示新特性页面：%@",[DCFeaturesTool dc_isShowNewFeatures] ? @"true" : @"false");
    
    return YES;
}


#pragma mark - 设置根控制器
- (void)setUpRootViewController
{
    UIViewController *dcHomeVc = [[UINavigationController alloc] initWithRootViewController:[DCFeatureDemoViewController new]];
    
    if ([DCFeaturesTool dc_isShowNewFeatures]) {
        
        DCNewFeaturesViewController *dcNewVc = [DCNewFeaturesViewController new];
        [dcNewVc setUpFeatureAttribute:^(NSArray *__autoreleasing *usImageArray, NSArray *__autoreleasing *ixImageArray, NSString *__autoreleasing *imEnjoyImg, UIColor *__autoreleasing *selColor, BOOL *isDefaultPass, BOOL *showSkip, BOOL *showPageCount) {
            
            *usImageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
            *ixImageArray = @[@"guide1_x",@"guide2_x",@"guide3_x",@"guide4_x"];
            
            *showPageCount = YES;
            *showSkip = YES;
            *isDefaultPass = YES;
            *imEnjoyImg = @"hidden";
            
        } WithDismissBlock:^{ //点击跳过-方法一
            [DCFeaturesTool dc_restoreRootViewController:dcHomeVc WithAnimations:DCFeaturesChangeVcGradient];
        }];
        
        //        dcNewVc.dismissBlock = ^{//点击跳过-方法二
        //            [DCFeaturesTool dc_restoreRootViewController:dcHomeVc WithAnimations:DCFeaturesChangeVcGradient];
        //        };
        
        self.window.rootViewController = dcNewVc;
        
    }else{
        
        self.window.rootViewController = dcHomeVc;
    }
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
