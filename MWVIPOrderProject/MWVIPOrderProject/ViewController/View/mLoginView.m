//
//  mLoginView.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "mLoginView.h"

@implementation mLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (mLoginView *)initView{
    mLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"mLoginView" owner:self options:nil] objectAtIndex:0];
    view.layer.cornerRadius = 5;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = 1;
    
    return view;
    
}
@end
