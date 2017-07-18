//
//  MWVIPFinderCell.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/18.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWVIPFinderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mTypeImg;

@property (weak, nonatomic) IBOutlet UIImageView *mSexImg;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mScore;

@property (weak, nonatomic) IBOutlet UILabel *mPhone;

@property (weak, nonatomic) IBOutlet UILabel *mScoreType;

@end
