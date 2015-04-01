//
//  HPNavigationController.m
//  HPEmotionKeyBoard
//
//  Created by shaun on 15/3/17.
//  Copyright (c) 2015年 itshaun. All rights reserved.
//

#import "HPNavigationController.h"

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@implementation HPNavigationController

#pragma mark 一个类只会调用一次
+ (void)initialize
{
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[HPNavigationController class], nil];
    navBar.backgroundColor = [UIColor redColor];
    // 2.设置导航栏的背景图片
    NSString *navBarBg = nil;
    if (iOS7) { // iOS7
        navBarBg = @"NavBar64";
        navBar.tintColor = [UIColor whiteColor];
    } else { // 非iOS7
        navBarBg = @"NavBar";
    }
    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    // 3.标题
#ifdef __IPHONE_7_0
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
#else
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
#endif
}

#pragma mark 控制状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
