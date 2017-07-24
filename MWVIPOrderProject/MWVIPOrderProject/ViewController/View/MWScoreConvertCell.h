//
//  MWScoreConvertCell.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/24.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWScoreConvertCell : UICollectionViewCell
///名称
@property (strong, nonatomic)  UILabel *mName;
///价格
@property (strong, nonatomic)  UILabel *mPrice;
///背景图
@property(strong,nonatomic) UIImageView *mBgk;
///销量
@property (strong, nonatomic)  UILabel *mSalesNum;

@end
