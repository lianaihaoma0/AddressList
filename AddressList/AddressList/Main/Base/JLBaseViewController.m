//
//  JLBaseViewController.m
//  testDemo
//
//  Created by JeLon_Cai on 2015/8/16.
//  Copyright © 2015年 JeLon_Cai. All rights reserved.
//

#import "JLBaseViewController.h"

@interface JLBaseViewController ()

@end

@implementation JLBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setIsSetNavigationBackButton:(BOOL)isSetNavigationBackButton
{
    _isSetNavigationBackButton = isSetNavigationBackButton;
    
    if (isSetNavigationBackButton == YES)
    {
        UIImage *btnImage = [UIImage imageNamed:@"navigationButtonReturn"];
        
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:btnImage style:UIBarButtonItemStylePlain target:self action:@selector(onBackBtnClick:)];
        self.navigationItem.leftBarButtonItem = backBtn;
    }
}

- (void)onBackBtnClick:(id)sender
{
    if ([self respondsToSelector:@selector(onGoBack)])
    {
        [self onGoBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setSlidingBack:(BOOL)slidingBack
{
    _slidingBack = slidingBack;
    
    if (slidingBack == YES)
    {
        // 获取系统自带滑动手势的targer对象
        id target = self.navigationController.interactivePopGestureRecognizer.delegate;
        
        // 创建全屏滑动手势,调用系统自带滑动手势的targer的action方法
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
        // 设置手势代理，拦截手势触发
        //pan.delegate = self;
        // 给导航控制器的view添加全屏滑动手势
        [self.view addGestureRecognizer:pan];
        // 禁止使用系统自带的滑动手势
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1)
    {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
