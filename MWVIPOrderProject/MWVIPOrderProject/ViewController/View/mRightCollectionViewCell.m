//
//  mRightCollectionViewCell.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/20.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "mRightCollectionViewCell.h"

@implementation mRightCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        self.mBgk = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, (DEVICE_Width - 80) / 3, (DEVICE_Width - 80) / 3)];
        [self.mBgk setUserInteractionEnabled:true];
        self.mBgk.backgroundColor = [UIColor redColor];
        [self addSubview:self.mBgk];
        
        self.mName = [[UILabel alloc] initWithFrame:CGRectMake(5,  (DEVICE_Width - 80) / 3, (DEVICE_Width - 80) / 3, 45)];
        self.mName.numberOfLines = 2;
        [self.mName setUserInteractionEnabled:true];
        
        self.mName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.mName];
        
//        self.mSalesNum = [[UILabel alloc] initWithFrame:CGRectMake(5, 45+(DEVICE_Width - 80) / 3, (DEVICE_Width - 80) / 3, 20)];
        self.mSalesNum = [UILabel new];
        self.mSalesNum.textAlignment = NSTextAlignmentLeft;
        self.mSalesNum.backgroundColor = [UIColor greenColor];
        [self addSubview:self.mSalesNum];
        
//        self.mPrice = [[UILabel alloc] initWithFrame:CGRectMake(5, 45+(DEVICE_Width - 80) / 3, (DEVICE_Width - 80) / 3, 20)];
        self.mPrice = [UILabel new];

        self.mPrice.backgroundColor = [UIColor redColor];
        self.mPrice.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.mPrice];
        
        
        [self.mSalesNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.top.equalTo(self.mName.mas_bottom);
            make.right.equalTo(self.mPrice.mas_left);
            

        }];
        [self.mPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
            make.top.equalTo(self.mName.mas_bottom);
            make.left.equalTo(self.mSalesNum.mas_right);
            
        }];
        
        
    }
    return self;
}

@end
