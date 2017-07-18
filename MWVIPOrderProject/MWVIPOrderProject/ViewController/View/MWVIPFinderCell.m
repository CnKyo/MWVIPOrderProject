//
//  MWVIPFinderCell.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/18.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWVIPFinderCell.h"

@implementation MWVIPFinderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.mScoreType.layer.cornerRadius = 3;
    self.mScoreType.layer.borderColor = [UIColor redColor].CGColor;
    self.mScoreType.layer.borderWidth = 1;
}
@end
