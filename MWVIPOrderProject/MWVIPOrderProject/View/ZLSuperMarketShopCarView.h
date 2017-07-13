//
//  ZLSuperMarketShopCarView.h
//  ZeroLifeClient
//
//  Created by Mac on 2016/11/4.
//  Copyright © 2016年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置代理
 */
@protocol ZLSuperMarketShopCarDelegate <NSObject>

@optional

/**
 购物车代理方法
 */
- (void)ZLSuperMarketShopCarDidSelected;

/**
 去结算代理方法
 */
- (void)ZLSuperMarketGoPayDidSelected;

@end

@interface ZLSuperMarketShopCarView : UIView

/**
 去结算按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mGopayBtn;

/**
 总价
 */
@property (weak, nonatomic) IBOutlet UILabel *mTotlePrice;

/**
 购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mShopCarBtn;

/**
 数量
 */
@property (weak, nonatomic) IBOutlet UILabel *mNum;

/**
 设置代理
 */
@property (strong, nonatomic) id <ZLSuperMarketShopCarDelegate>delegate;

+ (ZLSuperMarketShopCarView *)shareView;

@end
