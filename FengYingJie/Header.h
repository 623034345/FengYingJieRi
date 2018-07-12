//
//  Header.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/23.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#ifndef Header_h
#define Header_h


#import "UIViewController+FYJViewController.h"
//键盘监听
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "SDAutoLayout.h"
#import <AVOSCloud/AVOSCloud.h>
#import "FYJAvCloud.h"
#import "Masonry.h"
//#import "YYKit.h"
//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define UICOLOR_HEX(hexColor) \
[UIColor colorWithRed: (((hexColor >> 16) & 0xFF)) / 255.0f green: (((hexColor >> 8) & 0xFF)) / 255.0f blue: ((hexColor & 0xFF)) / 255.0f alpha:1.0f]

#define iPhoneX (HEIGHT == 812)
#endif /* Header_h */
