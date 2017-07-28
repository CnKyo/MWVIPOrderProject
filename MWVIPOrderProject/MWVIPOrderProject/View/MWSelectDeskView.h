//
//  MWSelectDeskView.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/28.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MWSelectDeskViewDelegate <NSObject>

@optional

/**
 按钮代理方法

 @param mTag 1:取消 2:确定
 */
- (void)MWSelectDeskViewBtnDidClicked:(NSInteger)mTag;

@end

@interface MWSelectDeskView : UIView

@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *mOkBtn;

@property (weak, nonatomic) IBOutlet UIView *mView;

@property (weak,nonatomic) id<MWSelectDeskViewDelegate>delegate;

+ (MWSelectDeskView *)initView;

@end
