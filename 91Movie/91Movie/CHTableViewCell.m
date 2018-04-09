//
//  CHTableViewCell.m
//  91Movie
//
//  Created by 陈欢 on 2018/3/25.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "CHTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "CHPronModel.h"
@interface CHTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *ImageMessage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation CHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPron:(CHPronModel *)pron
{
    _pron = pron;
    
    self.titleLabel.text = pron.title;
    
    self.ImageMessage.userInteractionEnabled = YES;
    
    [self.ImageMessage sd_setImageWithURL:[NSURL URLWithString:pron.imageUrl]];
}

@end
