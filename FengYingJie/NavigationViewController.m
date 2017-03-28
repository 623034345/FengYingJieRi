//
//  NavigationViewController.m
//  ARSegmentPager
//
//  Created by August on 15/5/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()<UINavigationBarDelegate,UINavigationControllerDelegate>

@end

@implementation NavigationViewController
-(instancetype)init
{
    if (self = [super init])
    {
    }
      return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
//    [self.navigationBar setTintColor:[UIColor whiteColor]];

    //设置颜色
//    [[UINavigationBar appearance] setBackgroundImage:[self createImageWithColor:UICOLOR_HEX(0x000000)] forBarMetrics:UIBarMetricsDefault];
    //设置图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"backgrund"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setTranslucent:YES];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    

    if (self.viewControllers.count == 1)//关闭主界面的右滑返回
     {
       return NO;
     }
    else
    {
       return YES;
    }
}
-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
