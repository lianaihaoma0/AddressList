//
//  JLBaseViewController.h
//  testDemo
//
//  Created by JeLon_Cai on 2015/8/16.
//  Copyright © 2015年 JeLon_Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLBaseViewController : UIViewController

/** 是否需要添加滑动返回(默认否) */
@property (nonatomic, assign) BOOL slidingBack;

/** 是否需要自定义返回按钮(默认否) */
@property (nonatomic, assign) BOOL isSetNavigationBackButton;

- (void)onGoBack;

@end
