//
//  VideoCell.m
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "VideoCell.h"
#import "UIImageView+WebCache.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)startPlayVideo:(UIButton *)sender{
    if (self.startPlayVideoBlcok) {
        self.startPlayVideoBlcok(self.backgroundIV,self.model);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setModel:(WMPlayerModel *)model{
    _model = model;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.titleLabel.text = model.title;
//    self.descriptionLabel.text = model.descriptionDe;
//    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
//    self.countLabel.text = [NSString stringWithFormat:@"%ld.%ld万",model.playCount/10000,model.playCount/1000-model.playCount/10000];
//    self.timeDurationLabel.text = [model.ptime substringWithRange:NSMakeRange(12, 4)];

}
@end
