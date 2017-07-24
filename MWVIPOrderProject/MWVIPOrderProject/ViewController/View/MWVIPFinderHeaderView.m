//
//  MWVIPFinderHeaderView.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/24.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWVIPFinderHeaderView.h"

@implementation MWVIPFinderHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (MWVIPFinderHeaderView *)initView{

    MWVIPFinderHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"MWVIPFinderHeaderView" owner:self options:nil] objectAtIndex:0];
    
    view.mFindBtn.layer.cornerRadius = view.mCancelBtn.layer.cornerRadius = 4;
    view.mPhoneTx.delegate = view;
    return view;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length >0) {
        if ([_delegate respondsToSelector:@selector(MWVIPFinderHeaderViewWithPhoneTextDidEndEditing:)]) {
            [_delegate MWVIPFinderHeaderViewWithPhoneTextDidEndEditing:textField.text];
        }
        
    }
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(MWVIPFinderHeaderViewWithBtnclicked:)]) {
        [_delegate MWVIPFinderHeaderViewWithBtnclicked:sender.tag];
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
