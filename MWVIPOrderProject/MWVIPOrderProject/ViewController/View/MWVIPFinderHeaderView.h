//
//  MWVIPFinderHeaderView.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/24.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWHeader.h"
@protocol MWVIPFinderHeaderViewDelagate <NSObject>

@optional

/**
 输入框代理方法

 @param mText 返回输入的内容
 */
- (void)MWVIPFinderHeaderViewWithPhoneTextDidEndEditing:(NSString *)mText;

/**
 按钮点击代理方法

 @param mTag 返回点击的tag
 */
- (void)MWVIPFinderHeaderViewWithBtnclicked:(NSInteger)mTag;

@end

@interface MWVIPFinderHeaderView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mBarCodeImg;

@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;

@property (weak, nonatomic) IBOutlet UIButton *mFindBtn;

@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn;

@property (weak,nonatomic) id<MWVIPFinderHeaderViewDelagate>delegate;

+ (MWVIPFinderHeaderView *)initView;

@end
