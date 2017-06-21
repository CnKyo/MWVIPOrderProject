//
//  mShopCarTableViewCell.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "mShopCarTableViewCell.h"

@implementation mShopCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mPlusAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(mShopCarTableViewCellDelegateWithPlusBtnClicked:)]) {
        [_delegate mShopCarTableViewCellDelegateWithPlusBtnClicked:self.mIndexPath];
    }
    
}
- (IBAction)mMinusAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(mShopCarTableViewCellDelegateWithMinusBtnClicked:)]) {
        [_delegate mShopCarTableViewCellDelegateWithMinusBtnClicked:self.mIndexPath];
    }
}


@end
