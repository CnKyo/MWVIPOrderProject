//
//  MWPrintTaskCell.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/18.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWPrintTaskCell.h"

@implementation MWPrintTaskCell

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
    
    self.mPrintBtn.layer.cornerRadius = 4;
    self.mPrintBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.mPrintBtn.layer.borderWidth = 1.5;
    
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if (self.mBtnClicked) {
        self.mBtnClicked(sender);
    }
}


@end
