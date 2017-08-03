//
//  WKBaseViewController.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IQKeyboardManager.h>
#import <MJRefresh.h>
#import <UIView+LayoutMethods.h>
#import "MWHeader.h"
@interface WKBaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) UIImageView *navBarHairlineImageView;
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

#pragma mark----****----View基本界面
/**
 列表数据源
 */
@property(nonatomic,strong) NSMutableArray      *tableArr;
/**
 列表
 */
@property(nonatomic,strong) UITableView         *tableView;

/**
 分页
 */
@property(nonatomic,assign) int mPage;
/**
 初始化tableview
 */
-(void)addTableView;
/**
 设置左边的按钮
 
 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addLeftBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage;


/**
 设置右边的按钮
 
 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addRightBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage;


- (void)setRightBtnTitle:(NSString *)mTitle;

- (void)setRightBtnImage:(NSString *)mImage;
/**
 右边按钮的点击事件
 */
- (void)rightBtnAction;
#pragma mark----****----刷新操作
/**
 列表头部刷新
 */
- (void)addTableViewHeaderRefreshing;
/**
 列表底部刷新
 */
- (void)addTableViewFootererRefreshing;
/**
 列表加载数据
 */
- (void)tableViewHeaderReloadData;
/**
 列表加载数据
 */
- (void)tableViewFooterReloadData;

#pragma mark----****----页面跳转操作
/**
 跳转到某个controller
 
 @param vc vc
 */
-(void)pushViewController:(UIViewController *)vc;
/**
 返回上个controller
 */
-(void)popViewController;
/**
 返回上上个controller
 */
-(void)popViewController_2;
/**
 *  返回上上上个controller
 */
- (void)popViewController_3;
/**
 *  想返回哪几个上级controller
 *
 *  @param whatYouWant 上级页面个数
 */
- (void)popViewController:(int)whatYouWant;



/**
 *  模态跳转方法
 *
 *  @param vc 跳转的viewcontroller
 */
- (void)presentModalViewController:(UIViewController *)vc;
/**
 *  模态跳转返回上一级
 */
- (void)dismissViewController;
/**
 *  模态跳转返回上二级
 */
- (void)dismissViewController_2;
/**
 *  模态跳转返回上三级
 */
- (void)dismissViewController_3;
/**
 *  模态跳转返回上n级
 */
- (void)dismissViewController:(int)whatYouWant;

#pragma mark----****----自定义弹出框
/**
 自定义弹出框

 @param mType 弹出框类型
 @param mTitle 标题
 @param mContent 内容
 @param mOkTitle 确定按钮
 @param mCancelTitle 取消按钮
 */
- (void)showCustomViewType:(WKCustomPopViewType)mType andTitle:(NSString *)mTitle andContentTx:(NSString *)mContent andOkBtntitle:(NSString *)mOkTitle andCancelBtntitle:(NSString *)mCancelTitle;

#pragma mark----****----hud框
- (void)showSucess:(NSString *)text;
- (void)showError:(NSString *)text;
- (void)showAlert:(NSString *)text;
- (void)showWithLoading:(NSString *)text;
@end
