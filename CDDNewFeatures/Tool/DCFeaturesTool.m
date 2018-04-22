
//
//  DCFeaturesTool.m
//  CDDNewFeatures
//
//  Created by 陈甸甸 on 2018/4/21.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DCFeaturesTool.h"

@implementation DCFeaturesTool


#pragma mark - 是否展示新特性页面
+ (BOOL)dc_isShowNewFeatures
{
    NSString *bundleVersionkey = @"CFBundleShortVersionString";
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:bundleVersionkey]; //上一次版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[bundleVersionkey];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        return false;
        
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:bundleVersionkey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return true;
    }
}


#pragma mark - 切换根控制器
+ (void)dc_restoreRootViewController:(UIViewController *)rootViewController WithAnimations:(DCFeaturesChangeVcType)featuresChangeVcType{
    
    if (featuresChangeVcType == DCFeaturesChangeVcNormal) { //默认
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        
    }else {
        CATransition *transAnimation = [[CATransition alloc] init];
        NSString *anType = (featuresChangeVcType == DCFeaturesChangeVcEffect) ? @"rippleEffect" : (featuresChangeVcType == DCFeaturesChangeVcGradient) ? @"p7ageCurl" : (featuresChangeVcType == DCFeaturesChangeVcCube) ? @"cube" : nil;
        transAnimation.type = anType; //切换类型
        transAnimation.duration = 0.5; // 动画时间
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transAnimation forKey:nil];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
    }
}

@end
