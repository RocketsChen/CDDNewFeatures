//
//  DCNewFeaturesViewController.h
//  CDDNewFeatures
//
//  Created by 陈甸甸 on 2018/4/21.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCNewFeaturesViewController : UIViewController


/**
 初始化
 *usImageArray   图片数组
 *ixImageArray   设备X图片数组
 *showSkip       是否展示跳过
 *selColor       选择小圆点的颜色
 *imEnjoyImg     立即体验素材
 *showPageCount  是否展示小圆点
 *isDefaultPass  是否默认滑到最后一页继续滑动跳过特性页面
 
 @param baseSettingBlock 基本设置Block
 @param dismissBlock 界面消失回调（点击跳过）
 */
- (void)setUpFeatureAttribute:(void(^)(NSArray **usImageArray,NSArray **ixImageArray,NSString **imEnjoyImg,UIColor **selColor,BOOL *isDefaultPass,BOOL *showSkip,BOOL *showPageCount))baseSettingBlock WithDismissBlock:(dispatch_block_t)dismissBlock;

/* 跳过按钮 */
@property (nonatomic, strong) UIButton *skipButton;

/* 状态栏的颜色 （如果有要设置状态栏的颜色）*/
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/**
 自定义跳过/立即体验按钮Frame

 @param controlSettingBlock 设置
 */
- (void)setUpFeatureControl:(void(^)(CGRect *skipBtnRect,CGRect *experienceBtnRect))controlSettingBlock;

/* 界面消失回调 */
@property (copy , nonatomic)dispatch_block_t dismissBlock;


@end
