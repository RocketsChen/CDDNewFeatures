# CDDNewFeatures
A simple new feature integration framework.

## Language
![Objective-C](https://img.shields.io/badge/language-Objective-C.svg)

## Requirements

* Xcode 8+

## Usage
* You can do that.

```
- (void)setUpRootViewController
{
    UIViewController *dcHomeVc = [[UINavigationController alloc] initWithRootViewController:[DCFeatureDemoViewController new]];
    
    if ([DCFeaturesTool dc_isShowNewFeatures]) {
        
        DCNewFeaturesViewController *dcNewVc = [DCNewFeaturesViewController new];
        [dcNewVc setUpFeatureAttribute:^(NSArray *__autoreleasing *usImageArray, NSArray *__autoreleasing *ixImageArray, NSString *__autoreleasing *imEnjoyImg, UIColor *__autoreleasing *selColor, BOOL *isDefaultPass, BOOL *showSkip, BOOL *showPageCount) {
            
            *usImageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
            *ixImageArray = @[@"guide1_x",@"guide2_x",@"guide3_x",@"guide4_x"];
            *imEnjoyImg = @"hidden";
            
            *showPageCount = YES;
            *showSkip = YES;
            *isDefaultPass = YES;
            
        } WithDismissBlock:^{
            [DCFeaturesTool dc_restoreRootViewController:dcHomeVc WithAnimations:DCFeaturesChangeVcGradient];
        }];
        
        //        dcNewVc.dismissBlock = ^{//Same as the DismissBlock
        //            [DCFeaturesTool dc_restoreRootViewController:dcHomeVc WithAnimations:DCFeaturesChangeVcGradient];
        //        };
        
        self.window.rootViewController = dcNewVc;
        
    }else{
        
        self.window.rootViewController = dcHomeVc;
    }
}
```

* Other Settings.

```
[dcNewVc setUpFeatureControl:^(CGRect *skipBtnRect, CGRect *experienceBtnRect) {

    CGFloat dcY = (isFiPhoneX) ? 80: 60;
    *experienceBtnRect = CGRectMake([UIScreen mainScreen].bounds.size.width - 70,dcY, 70, 40);
    *skipBtnRect = CGRectMake([UIScreen mainScreen].bounds.size.width - 85,[UIScreen mainScreen].bounds.size.height - dcY, 65, 30);
}];
```


##Installation 
#### Manually:
* Drag all source files(`CDDNewFeatures`) under folder Extension to your project.
* Import the header file in the AppDelegate.
* A method is called

#### CocoaPods:
* Waiting for the integration


#### Swift version:
* Waiting for development


## Agreement

* ` CDDNewFeatures ` licensed under the MIT license is used. Refer to [LICENSE] (https://opensource.org/licenses/MIT) for more information.

