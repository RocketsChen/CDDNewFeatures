
//
//  DCNewFeaturesViewController.m
//  CDDNewFeatures
//
//  Created by 陈甸甸 on 2018/4/21.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

#import "DCNewFeaturesViewController.h"

// Controllers

// Models

// Views
#import "DCNewFeaturesCell.h"
// Vendors

// Categories

// Others
#import "DCFeaturesTool.h"

@interface DCNewFeaturesViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 立即体验素材 */
@property (nonatomic, strong) NSString *imEnjoyImg;
/* 最终设备展示图片数组 */
@property (nonatomic, copy) NSArray *finShowImageArray;
/** 是否默认滑到最后一页继续滑动跳过特性页面 默认不展示 */
@property (nonatomic, assign) BOOL isDefaultPass;
/** 是否显示跳过按钮, 默认不显示 */
@property (nonatomic, assign) BOOL showSkip;
/** 是否显示page小圆点, 默认不显示 */
@property (nonatomic, assign) BOOL showPageCount;
/** 跳过按钮frame */
@property (nonatomic, assign) CGRect skipBtnRect;
/** 立即体验按钮frame */
@property (nonatomic, assign) CGRect experienceBtnRect;
/* 小圆点选中颜色 */
@property (nonatomic, strong) UIColor *selColor;
/* page */
@property (strong , nonatomic)UIPageControl *pageControl;

@end

static NSString *const DCNewFeaturesCellID = @"DCNewFeaturesCell";

@implementation DCNewFeaturesViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = [UIScreen mainScreen].bounds;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.view insertSubview:_collectionView atIndex:0];
        
        [_collectionView registerClass:[DCNewFeaturesCell class] forCellWithReuseIdentifier:DCNewFeaturesCellID];
    }
    return _collectionView;
}

- (UIButton *)skipButton
{
    if (!_skipButton) {
        
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat dcY = (isFiPhoneX) ? 45 : 30;
        _skipButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 85, dcY, 65, 30);
        [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.hidden = YES;
        _skipButton.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.8];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _skipButton.layer.cornerRadius = 15;
        _skipButton.layer.masksToBounds = YES;
        
        [self.view addSubview:_skipButton];
    }
    return _skipButton;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl && _finShowImageArray.count != 0) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _finShowImageArray.count;
        _pageControl.userInteractionEnabled = false;
        [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        UIColor *currColor = (_selColor == nil) ? [UIColor darkGrayColor] : _selColor;
        _pageControl.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.95, [UIScreen mainScreen].bounds.size.width, 35);
        [self.pageControl setCurrentPageIndicatorTintColor:currColor];
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
}


#pragma mark - 基础设置
- (void)setUpFeatureAttribute:(void(^)(NSArray **usImageArray,NSArray **ixImageArray,NSString **imEnjoyImg,UIColor **selColor,BOOL *isDefaultPass,BOOL *showSkip,BOOL *showPageCount))baseSettingBlock WithDismissBlock:(dispatch_block_t)dismissBlock
{
    NSArray *usImageArray;
    NSArray *ixImageArray;
    NSString *imEnjoyImg;
    UIColor *selColor;
    BOOL isDefaultPass;
    BOOL showSkip;
    BOOL showPageCount;
    
    if (baseSettingBlock) {
        
        baseSettingBlock(&usImageArray,&ixImageArray,&imEnjoyImg,&selColor,&isDefaultPass,&showSkip,&showPageCount);
        
        self.finShowImageArray = (isFiPhoneX && ixImageArray.count == usImageArray.count) ?  ixImageArray : usImageArray; //最终展示图片数组
        
        self.imEnjoyImg = imEnjoyImg;
        self.selColor = selColor;
        self.isDefaultPass = isDefaultPass;
        self.showSkip = showSkip;
        self.showPageCount = showPageCount;
        self.dismissBlock = dismissBlock;
        
        !dismissBlock ? : dismissBlock();
    }
    
}

- (void)setUpFeatureControl:(void(^)(CGRect *skipBtnRect,CGRect *experienceBtnRect))controlSettingBlock
{
    CGRect skipBtnRect;
    CGRect experienceBtnRect;
    if (controlSettingBlock) {
        controlSettingBlock(&skipBtnRect,&experienceBtnRect);
        
            self.skipBtnRect = skipBtnRect;
            self.experienceBtnRect = experienceBtnRect;
    }
}


#pragma mark - initialize
- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    [self.skipButton setTitle:@"跳过" forState:0];
    self.automaticallyAdjustsScrollViewInsets = false;
}

#pragma mark - 是否展示跳过按钮
- (void)setShowSkip:(BOOL)showSkip
{
    _showSkip = showSkip;
    self.skipButton.hidden = !self.showSkip;
}

#pragma mark - 是否展示page小圆点
- (void)setShowPageCount:(BOOL)showPageCount
{
    _showPageCount = showPageCount;
    self.pageControl.hidden = !self.showPageCount;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.skipBtnRect.size.width != 0  && self.showSkip) {
        _skipButton.frame = self.skipBtnRect;
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _finShowImageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak typeof(self)weakSelf = self;
    DCNewFeaturesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewFeaturesCellID forIndexPath:indexPath];
    cell.imEnjoyImg = _imEnjoyImg;
    
    cell.nfImageView.image = [UIImage imageNamed:_finShowImageArray[indexPath.row]];
    cell.experienceBtnRect = _experienceBtnRect;
    [cell dc_getCurrentPageIndex:indexPath.row lastPageIndex:_finShowImageArray.count - 1];
    cell.experienceBlock = ^{ //立即体验
        [weakSelf skipButtonClick];
    };
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark - 通过代理来让她滑到最后一页再左滑动就切换控制器
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (!_isDefaultPass) return; //如果没有打开直接返回
    if (_finShowImageArray.count < 2) return; //一张图或者没有直接返回
    _collectionView.bounces = (scrollView.contentOffset.x > (_finShowImageArray.count - 2) * [UIScreen mainScreen].bounds.size.width) ? YES : NO;
    if (scrollView.contentOffset.x >  (_finShowImageArray.count - 1) * [UIScreen mainScreen].bounds.size.width) {
        [self skipButtonClick];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (!_showPageCount) return;
    CGPoint currentPoint = scrollView.contentOffset;
    NSInteger page = currentPoint.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}



#pragma mark - 跳过点击
- (void)skipButtonClick
{
    !self.dismissBlock ? : self.dismissBlock();
}

#pragma mark - 设置颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return (_statusBarStyle) ? _statusBarStyle : UIStatusBarStyleDefault;
}


@end
