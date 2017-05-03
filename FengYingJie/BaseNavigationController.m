//
//  BaseNavigationController.m
//  duobaozhen
//
//  Created by Macintosh HD on 2017/1/19.
//  Copyright © 2017年 xiaoxuan. All rights reserved.
//

#import "BaseNavigationController.h"
#import "LCPanGestureRecognizer.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [[UINavigationBar appearance] setBackgroundImage:[self createImageWithColor:UICOLOR_HEX(0x00FFFF)] forBarMetrics:UIBarMetricsDefault];


}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    
    if (self.viewControllers.count == 1)
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  重写Push方法(隐藏底部的tabbar)
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count) { //避免一开始就隐藏了
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
