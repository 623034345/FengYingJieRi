//
//  FYJDate.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/24.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//
#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseFestival @[@"除夕",@"春节",@"中秋",@"五一",@"国庆",@"儿童",@"圣诞",@"七夕",@"端午"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]
#define ChineseWeatherFestival @[@"立春",@"雨水",@"惊蛰",@"春分",@"清明",@"谷雨",@"立夏",@"小满",@"忙种",@"夏至",@"小暑",@"大暑",@"立秋",@"处暑",@"寒露",@"霜降",@"白露",@"秋分",@"立冬",@"小雪",@"大雪",@"冬至",@"小寒",@"大寒"]
#import <Foundation/Foundation.h>

@interface FYJDate : NSObject
@property (nonatomic, copy) NSString *day;
- (NSString *)chineseCalendarOfDate:(NSDate *)date;
@end
