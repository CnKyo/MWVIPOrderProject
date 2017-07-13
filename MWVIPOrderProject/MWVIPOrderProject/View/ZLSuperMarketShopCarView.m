//
//  ZLSuperMarketShopCarView.m
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import "ZLSuperMarketShopCarView.h"

@implementation ZLSuperMarketShopCarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZLSuperMarketShopCarView *)shareView{

    ZLSuperMarketShopCarView *view = [[[NSBundle mainBundle] loadNibNamed:@"ZLSuperMarketShopCarView" owner:self options:nil] objectAtIndex:0];
    
    view.mNum.layer.masksToBounds = YES;
    view.mNum.layer.cornerRadius = 10;
    return view;
}

- (IBAction)mShopCar:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketShopCarDidSelected)]) {
        [self.delegate ZLSuperMarketShopCarDidSelected];

    }

}

- (IBAction)mGoPay:(UIButton *)sender {

    
    if ([self.delegate respondsToSelector:@selector(ZLSuperMarketGoPayDidSelected)]) {
        [self.delegate ZLSuperMarketGoPayDidSelected];
    }
    
    
}



@end
