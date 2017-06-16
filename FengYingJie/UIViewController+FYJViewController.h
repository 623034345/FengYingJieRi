//
//  UIViewController+FYJViewController.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/23.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FYJViewController)
-(void)getGeneral;
-(void)alertControllerQue:(UIAlertAction*)seleced prompt:(NSString *)prompt msg:(NSString *)msgStr;
//带图片的返回按钮
- (void)addBackBtnWithImageNormal:(NSString *)normalStr
                          fuction:(SEL)function;

//带图片的下一步按钮
- (void)addNextBtnWithImageNormal:(NSString *)normalStr
                          fuction:(SEL)function;
//带文字的下一步按钮
- (void)addNextBtnWithTitle:(NSString *)titleStr
                    fuction:(SEL)function;
@end
