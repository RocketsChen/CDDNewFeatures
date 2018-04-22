//
//  DCFeaturesTool.h
//  CDDNewFeatures
//
//  Created by 陈甸甸 on 2018/4/21.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isFiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

typedef NS_ENUM(NSUInteger, DCFeaturesChangeVcType) {

    DCFeaturesChangeVcNormal = 0, //默认方式
    DCFeaturesChangeVcGradient = 1, //渐变方式
    DCFeaturesChangeVcEffect = 2, //水花方式 
    DCFeaturesChangeVcCube = 3, //立方翻转
    
};

@interface DCFeaturesTool : NSObject
/**
 是否展示新特性页面
 
 @return 是：展示/否：不展示
 */
+ (BOOL)dc_isShowNewFeatures;


/**
 跟换根控制器

 @param rootViewController 根控制器
 @param featuresChangeVcType 切换控制器动画
 */
+ (void)dc_restoreRootViewController:(UIViewController *)rootViewController WithAnimations:(DCFeaturesChangeVcType)featuresChangeVcType;

@end
