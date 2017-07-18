//
//  MWPrintTaskCell.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/18.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^mPrintBtnClickBlock)(UIButton *sender);

@interface MWPrintTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mPrice;

@property (weak, nonatomic) IBOutlet UILabel *mStatus;

@property (weak, nonatomic) IBOutlet UILabel *mTime;

@property (weak, nonatomic) IBOutlet UIButton *mPrintBtn;

@property (copy,nonatomic) mPrintBtnClickBlock mBtnClicked;

@end
