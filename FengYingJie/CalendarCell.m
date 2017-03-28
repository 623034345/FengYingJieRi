//
//  CalendarCell.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/3/24.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell{
    UILabel *_dayLabel;
    UILabel *_chineseDayLabel;
    NSString *day;
}
- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 20,20)];
        _dayLabel.textAlignment =NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:15];
        _dayLabel.center =CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 - 3);
        [self addSubview:_dayLabel];
        
    }
    return _dayLabel;
}

- (UILabel *)chineseDayLabel {
    if (!_chineseDayLabel) {
        _chineseDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 20,10)];
        _chineseDayLabel.textAlignment =NSTextAlignmentCenter;
        _chineseDayLabel.font = [UIFont boldSystemFontOfSize:9];
        
        CGPoint point =_dayLabel.center;
        point.y +=15;
        _chineseDayLabel.center = point;
        [self addSubview:_chineseDayLabel];
        
    }
    return _chineseDayLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
