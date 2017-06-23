//
//  mShopCarRightView.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol mShopCarRightViewDelegate <NSObject>

@optional

/**
 按钮代理方法

 @param mTag 标记tag(0:微信支付，1:现金支付，2:外卖支付，3:积分支付)
 */
- (void)mShopCarRightViewDelegateWithBtnClicked:(NSInteger)mTag;

/**
 输入框代理方法

 @param mText 返回输入内容
 */
- (void)mShopCarRightViewDelegateWithPhoneTextEndEditing:(NSString *)mText;

@end

@interface mShopCarRightView : UIView<UITextFieldDelegate>
///总价
@property (weak, nonatomic) IBOutlet UILabel *mTotlePrice;
///微信支付
@property (weak, nonatomic) IBOutlet UIButton *mWechatPay;
///现金支付
@property (weak, nonatomic) IBOutlet UIButton *mCashPay;
///外卖支付
@property (weak, nonatomic) IBOutlet UIButton *mOutPay;
///积分支付
@property (weak, nonatomic) IBOutlet UIButton *mScorePay;

@property (weak, nonatomic) IBOutlet UIButton *mComitBtn;
@property (weak,nonatomic) id<mShopCarRightViewDelegate>delegate;
///弹出view
@property (weak, nonatomic) IBOutlet UIView *mPopView;
///二维码
@property (weak, nonatomic) IBOutlet UIImageView *mBarCodeImg;
///电话号码
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;


+ (mShopCarRightView *)initView;
@end
