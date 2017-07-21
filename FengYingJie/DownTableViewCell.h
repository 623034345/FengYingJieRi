//
//  DownTableViewCell.h
//  FengYingJie
//
//  Created by Macintosh HD on 2017/6/29.
//  Copyright © 2017年 Macintosh HD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jindu;
@property (weak, nonatomic) IBOutlet UIProgressView *jindutiao;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIButton *deteleBtn;

@end
