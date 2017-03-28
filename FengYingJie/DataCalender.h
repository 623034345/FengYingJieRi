//
//  DataCalender.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/28.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DeviceWidth [UIScreen mainScreen].bounds.size.width

@protocol DataCalenderItemDelegate;

@interface DataCalender : UIView
@property (strong ,nonatomic) NSDate *date;
@property (weak ,nonatomic) id<DataCalenderItemDelegate> delegate;
@property (strong ,nonatomic) NSString *day;
@property (strong ,nonatomic) NSString *chineseWeatherDay;
@property (strong, nonatomic) NSDate *selectedDate;
- (NSDate *) nextMonthDate;
- (NSDate *) previousMonthDate;
- (instancetype)init;

@end

@protocol DataCalenderItemDelegate <NSObject>

- (void)calendarItem:(DataCalender *)item didSelectedDate:(NSDate *)date;

@end
