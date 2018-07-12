//
//  VideoCell.h
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMPlayerModel.h"

typedef void(^StartPlayVideoBlcok)(UIImageView *backgroundIV,WMPlayerModel *videoModel);

@interface VideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UILabel *timeDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic, retain)WMPlayerModel *model;


@property (nonatomic, copy)StartPlayVideoBlcok startPlayVideoBlcok;



@end
