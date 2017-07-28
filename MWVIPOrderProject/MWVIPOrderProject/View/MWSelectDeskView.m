//
//  MWSelectDeskView.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/28.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWSelectDeskView.h"

@implementation MWSelectDeskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (MWSelectDeskView *)initView{
    MWSelectDeskView *view = [[[NSBundle mainBundle] loadNibNamed:@"MWSelectDeskView" owner:self options:nil] objectAtIndex:0];
    
    view.mCancelBtn.layer.cornerRadius = 4;
    view.mCancelBtn.layer.borderColor = [UIColor colorWithRed:0.117647058823529 green:0.537254901960784 blue:0.992156862745098 alpha:1.00].CGColor;
    view.mCancelBtn.layer.borderWidth = 1;
    
    
    view.mOkBtn.layer.cornerRadius = 4;
    view.mOkBtn.layer.borderColor = [UIColor redColor].CGColor;
    view.mOkBtn.layer.borderWidth = 1;
    
    return view;
    
}
- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(MWSelectDeskViewBtnDidClicked:)]) {
        [self.delegate MWSelectDeskViewBtnDidClicked:sender.tag];
    }
    
}




@end
