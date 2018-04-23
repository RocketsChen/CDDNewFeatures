//
//  DCFeatureDemoViewController.m
//  CDDNewFeatures
//
//  Created by 陈甸甸 on 2018/4/21.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

#import "DCFeatureDemoViewController.h"

// Controllers
#import "DCNewFeaturesViewController.h"
// Models

// Views

// Vendors

// Categories

// Others
#import "DCFeaturesTool.h"

@interface DCFeatureDemoViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;

@end

@implementation DCFeatureDemoViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NewFeaturesCell"];
    }
    return _tableView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.title = @"CDDNewFeaturesTypes";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 50;
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewFeaturesCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"新特性样式%zd",indexPath.row];
    
    return cell;
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self setUpWithNewFeaturesWhithIndex:indexPath.row];
}


#pragma mark - 设置新特性
- (void)setUpWithNewFeaturesWhithIndex:(NSInteger)index
{
    UIViewController *dcHomeVc = [[UINavigationController alloc] initWithRootViewController:[DCFeatureDemoViewController new]];
    DCNewFeaturesViewController *dcNewVc = [DCNewFeaturesViewController new];
    
    BOOL animations = index % 2;
    
    __block DCFeaturesChangeVcType anType = (index == 0) ? DCFeaturesChangeVcEffect : (index == 1) ? DCFeaturesChangeVcGradient : (index == 2) ? DCFeaturesChangeVcCube : DCFeaturesChangeVcNormal;
    
    #pragma mark - 基础设置
    [dcNewVc setUpFeatureAttribute:^(NSArray *__autoreleasing *usImageArray, NSArray *__autoreleasing *ixImageArray, NSString *__autoreleasing *imEnjoyImg, UIColor *__autoreleasing *selColor, BOOL *isDefaultPass, BOOL *showSkip, BOOL *showPageCount) {
        
        if (index == 0) {
            
            *usImageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
            *ixImageArray = @[@"guide1_x",@"guide2_x",@"guide3_x",@"guide4_x"];
            *imEnjoyImg = @"hidden";
            
        }else if (index == 1 || index == 3){
            
            *usImageArray = @[@"helper414x736_0",@"helper414x736_1",@"helper414x736_2",@"helper414x736_3"];
            *imEnjoyImg = @"tiaoguo";
            
        }else if (index == 2){
            *usImageArray = @[@"function_guide_1",@"function_guide_2"];

        }
        
        *showPageCount = (index == 2) ? NO : YES;
        
        *showSkip = (index == 1) ? NO : YES;
        
        *isDefaultPass = !animations;
        
    } WithDismissBlock:^{ //点击跳过
        [DCFeaturesTool dc_restoreRootViewController:dcHomeVc WithAnimations:anType];
    }];
    #pragma mark - 设置跳过，立即体验的frame
    if (index == 2) {
        
        dcNewVc.statusBarStyle = UIStatusBarStyleLightContent;
        [dcNewVc setUpFeatureControl:^(CGRect *skipBtnRect, CGRect *experienceBtnRect) {
            
            CGFloat dcY = (isFiPhoneX) ? 80: 60;
            
            *skipBtnRect = CGRectMake([UIScreen mainScreen].bounds.size.width - 85,[UIScreen mainScreen].bounds.size.height - dcY, 65, 30);
        }];
        
    }else if (index == 1){

        [dcNewVc setUpFeatureControl:^(CGRect *skipBtnRect, CGRect *experienceBtnRect) {

            CGFloat dcY = (isFiPhoneX) ? 45 : 30;
            *experienceBtnRect = CGRectMake([UIScreen mainScreen].bounds.size.width - 70,dcY, 70, 40);
        }];
    }
    
    [DCFeaturesTool dc_restoreRootViewController:dcNewVc WithAnimations:anType];
}

@end
