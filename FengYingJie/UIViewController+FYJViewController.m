//
//  UIViewController+FYJViewController.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/23.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "UIViewController+FYJViewController.h"

@implementation UIViewController (FYJViewController)
+(void)load
{

}
-(void)getGeneral
{
    self.automaticallyAdjustsScrollViewInsets = YES;
}
//带提示框的弹窗
-(void)alertControllerQue:(UIAlertAction*)seleced prompt:(NSString *)prompt msg:(NSString *)msgStr
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action)
                             {
                                 
                             }];

    [alert addAction:cancle];
    [alert addAction:seleced];
    [self presentViewController:alert animated:YES completion:nil];
}

//带图片的返回按钮
- (void)addBackBtnWithImageNormal:(NSString *)normalStr
                          fuction:(SEL)function
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.bounds = CGRectMake(0, 0, 25, 25);
    [backBtn setImage:[UIImage imageNamed:normalStr]
             forState:UIControlStateNormal];
    
    [backBtn addTarget:self
                action:function
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}

//带图片的下一步按钮
- (void)addNextBtnWithImageNormal:(NSString *)normalStr
                          fuction:(SEL)function
{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.bounds = CGRectMake(0, 0, 20, 20);
    [saveBtn setBackgroundImage:[UIImage imageNamed:normalStr]
                       forState:UIControlStateNormal];
    [saveBtn addTarget:self
                action:function
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBtnItem;
}

//带文字的下一步按钮
- (void)addNextBtnWithTitle:(NSString *)titleStr
                    fuction:(SEL)function
{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = [UIColor clearColor];
    saveBtn.bounds = CGRectMake(0, 0, 100, 44);
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [saveBtn setTitle:titleStr
             forState:UIControlStateNormal];
    [saveBtn setTitle:titleStr
             forState:UIControlStateHighlighted];
    [saveBtn setTitleColor:[UIColor blueColor]
                  forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithRed:239 green:239 blue:239 alpha:1]
                  forState:UIControlStateHighlighted];
    [saveBtn addTarget:self
                action:function
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBtnItem;
}

//添加轻按手势
- (void)addTapRecognizer:(SEL)fuction
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:fuction];
    [self.view addGestureRecognizer:tap];
}

@end
