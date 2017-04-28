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
    
    //    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //
    ////        [alert addTapRecognizer:seleced];
    //        [alert addAction:seleced];
    //
    //
    //    }];
    [alert addAction:cancle];
    [alert addAction:seleced];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
