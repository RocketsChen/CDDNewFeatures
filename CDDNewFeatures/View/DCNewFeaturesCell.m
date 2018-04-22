//
//  DCNewFeaturesCell.m
//  CDDNewFeatures
//
//  Created by 陈甸甸 on 2018/4/21.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//

#import "DCNewFeaturesCell.h"

@interface DCNewFeaturesCell ()

/* 立即体验 */
@property (weak , nonatomic)UIButton *experienceButton;

@end

@implementation DCNewFeaturesCell

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}


#pragma mark - UI
- (void)setUpUI
{
    _nfImageView = [[UIImageView alloc] init];
    [self insertSubview:_nfImageView atIndex:0];
    
    UIButton *experienceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _experienceButton = experienceButton;
    experienceButton.adjustsImageWhenHighlighted = false;
    experienceButton.hidden = YES;
    [experienceButton addTarget:self action:@selector(experienceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:experienceButton];
}


- (void)setImEnjoyImg:(NSString *)imEnjoyImg
{
    _imEnjoyImg = imEnjoyImg;
    if (imEnjoyImg.length == 0) return;
    [self.experienceButton setImage:[UIImage imageNamed:imEnjoyImg] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nfImageView.frame = self.bounds;
    
    if (_imEnjoyImg.length == 0) return;
    if (_experienceBtnRect.size.width) {
        self.experienceButton.frame = _experienceBtnRect;
    }else{
        [self.experienceButton sizeToFit];
        self.experienceButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.9);
    }
}


#pragma mark - 跳过按钮点击
- (void)experienceButtonClick
{
    !_experienceBlock ? : _experienceBlock();
}

#pragma mark - 用来获取页码
- (void)dc_getCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex
{
    _experienceButton.hidden = (currentIndex == lastIndex) ?  NO : YES; //只有当前index和最后index相等时隐藏按钮才显示
}

@end
