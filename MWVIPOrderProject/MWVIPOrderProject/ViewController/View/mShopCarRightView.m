//
//  mShopCarRightView.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "mShopCarRightView.h"

@implementation mShopCarRightView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (mShopCarRightView *)initView{
    mShopCarRightView *view = [[[NSBundle mainBundle] loadNibNamed:@"mShopCarRightView" owner:self options:nil] objectAtIndex:0];
    view.mWechatPay.layer.cornerRadius = 5;
    view.mCashPay.layer.cornerRadius = 5;
    view.mOutPay.layer.cornerRadius = 5;
    view.mScorePay.layer.cornerRadius = 5;
    
    view.mPhoneTx.delegate = view;
    
    
    view.mComitBtn.layer.cornerRadius = 5;

    return view;
}

- (IBAction)mBtnAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(mShopCarRightViewDelegateWithBtnClicked:)]) {
        [_delegate mShopCarRightViewDelegateWithBtnClicked:sender.tag];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text.length>0) {
        if ([self.delegate respondsToSelector:@selector(mShopCarRightViewDelegateWithPhoneTextEndEditing:)]) {
            [self.delegate mShopCarRightViewDelegateWithPhoneTextEndEditing:textField.text
             ];
        }
        
    }
    
}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    {
    res= TEXT_MAXLENGTH-[new length];
    
    }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}


@end
