//
//  BaseViewController.h
//  FengYingJie
//
//  Created by Macintosh HD on 2018/6/6.
//  Copyright © 2018年 Macintosh HD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic ,strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) UITableView *table;
@end
