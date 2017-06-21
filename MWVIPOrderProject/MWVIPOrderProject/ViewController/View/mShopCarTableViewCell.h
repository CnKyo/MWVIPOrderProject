//
//  mShopCarTableViewCell.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol mShopCarTableViewCellDelegate <NSObject>

@optional

/**
 加按钮代理方法

 @param mIndexPath 索引
 */
- (void)mShopCarTableViewCellDelegateWithPlusBtnClicked:(NSIndexPath *)mIndexPath;

/**
 减按钮代理方法

 @param mIndexPath 索引
 */
- (void)mShopCarTableViewCellDelegateWithMinusBtnClicked:(NSIndexPath *)mIndexPath;


@end

@interface mShopCarTableViewCell : UITableViewCell
///图片
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
///名称
@property (weak, nonatomic) IBOutlet UILabel *mName;
///价格
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
///加按钮
@property (weak, nonatomic) IBOutlet UIButton *mPlusBtn;
///减按钮
@property (weak, nonatomic) IBOutlet UIButton *mMinusBtn;
///数量
@property (weak, nonatomic) IBOutlet UILabel *mNum;
///索引
@property (strong,nonatomic) NSIndexPath *mIndexPath;

@property (weak,nonatomic) id<mShopCarTableViewCellDelegate>delegate;

@end
