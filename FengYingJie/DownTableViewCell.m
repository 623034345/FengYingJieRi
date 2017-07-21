//
//  DownTableViewCell.m
//  FengYingJie
//
//  Created by Macintosh HD on 2017/6/29.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import "DownTableViewCell.h"

@implementation DownTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellAccessoryNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
