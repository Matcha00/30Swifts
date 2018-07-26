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
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    
//    self.layer.masksToBounds = YES;
    self.layer.shadowPath   =    CGPathCreateWithRect(self.bounds, NULL);
    self.layer.shadowColor = [UIColor redColor].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 20;
    frame.origin.y += 20;
    frame.size.width -= 40;
    frame.size.height -= 20;
    [super setFrame:frame];
}

- (void)setPron:(CHPronModel *)pron
{
    _pron = pron;
    
    self.titleLabel.text = pron.title;
    
    self.ImageMessage.userInteractionEnabled = YES;
    
    [self.ImageMessage sd_setImageWithURL:[NSURL URLWithString:pron.imageUrl]];
}

@end
