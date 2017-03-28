//
//  UICalender.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/28.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCalender.h"
@interface UICalender : UIView

- (instancetype)initWithCurrentDate:(NSDate *)date;
@end
#define Weekdays @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]

static NSDateFormatter *dateForMattor;
@interface UICalender ()<UIScrollViewDelegate,DataCalenderItemDelegate>
@property(strong,nonatomic) NSDate *date;
@property(strong,nonatomic) UIButton *titleButton;
@property(strong,nonatomic) UIScrollView *scrollView;
@property(strong,nonatomic) DataCalender *leftCalenderItem;
@property(strong,nonatomic) DataCalender *centerCalendarItem;
@property(strong,nonatomic) DataCalender *rightCalenderItem;
@property(strong,nonatomic) UIView *backgroundView;
@property(strong,nonatomic) UIView *dateCheckedView;
@property(strong,nonatomic) UIDatePicker *datePicker;


@end
