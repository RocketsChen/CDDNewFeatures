//
//  DCNewFeaturesCell.h
//  CDDNewFeatures
//
//  Created by 陈甸甸 on 2018/4/21.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCNewFeaturesCell : UICollectionViewCell


/** 立即体验按钮点击回调 */
@property (nonatomic, copy) dispatch_block_t experienceBlock;

/* 新特性 */
@property (strong , nonatomic)UIImageView *nfImageView;
/* 立即体验素材 */
@property (strong , nonatomic)NSString *imEnjoyImg;

/** 立即体验按钮frame */
@property (nonatomic, assign) CGRect experienceBtnRect;

/**
 用来获取页码
 
 @param currentIndex 当前index
 @param lastIndex 最后index
 */
- (void)dc_getCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex;

@end
