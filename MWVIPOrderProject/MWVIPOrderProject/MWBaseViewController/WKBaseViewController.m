//
//  WKBaseViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKBaseViewController ()

@end

@implementation WKBaseViewController
{

}
//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(247, 247, 247);
    self.tableArr = [NSMutableArray array];
    self.mPage = 1;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)addTableView{
    if (self.tableView==nil ) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:self.tableView];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.backgroundColor = COLOR(247, 247, 247);
//        self.tableView.emptyDataSetSource = self;
//        self.tableView.emptyDataSetDelegate = self;
        self.tableView.tableFooterView = [UIView new];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);

            make.height.equalTo(self.view.mas_height);
        }];
    }
}
#pragma mark ----****----设置左边的按钮
/**
 设置左边的按钮
 
 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addLeftBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage{
    UIButton *mBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(80,0,13,20)];
    
    if (!mHidden) {
        return;
    }else{
        
        if (mBackTitle.length > 0 ) {
            
            [mBackBtn setTitle:mBackTitle forState:UIControlStateNormal];
        }else if (mImage != nil){
            [mBackBtn setImage:mImage forState:UIControlStateNormal];
            
        }else{
            [mBackBtn setTitle:mBackTitle forState:UIControlStateNormal];
            [mBackBtn setImage:[UIImage imageNamed:@"ZLBackBtn_Image"] forState:UIControlStateNormal];
            
        }
        [mBackBtn addTarget:self action:@selector(mBackAction)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mBackItem = [[UIBarButtonItem alloc]initWithCustomView:mBackBtn];
        self.navigationItem.leftBarButtonItem= mBackItem;
    }
    
}

#pragma mark ----****----设置右边的按钮
/**
 设置右边的按钮
 
 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addRightBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage{
    UIButton *mRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_Width-60,15,25,25)];
    mRightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    mRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    CGRect mR = mRightBtn.frame;
    if (!mHidden) {
        return;
    }else{
        if (mBackTitle.length > 0 ) {
            mR.size.width = 70;
            mRightBtn.frame = mR;
            [mRightBtn setTitle:mBackTitle forState:UIControlStateNormal];
        }else if (mImage != nil){
            [mRightBtn setImage:mImage forState:UIControlStateNormal];
            
        }
        [mRightBtn addTarget:self action:@selector(rightBtnAction)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *mRightBartem = [[UIBarButtonItem alloc]initWithCustomView:mRightBtn];
        self.navigationItem.rightBarButtonItem= mRightBartem;
    }
}
- (void)mBackAction{
    [self popViewController];
}
/**
 右边按钮的点击事件
 */
- (void)rightBtnAction{
    MLLog(@"右边");
}
- (void)setRightBtnImage:(NSString *)mImage{
    UIButton *mRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_Width-60,15,25,25)];
    mRightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    mRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [mRightBtn setImage:[UIImage imageNamed:mImage] forState:UIControlStateNormal];
    
    
    [mRightBtn addTarget:self action:@selector(rightBtnAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mRightBartem = [[UIBarButtonItem alloc]initWithCustomView:mRightBtn];
    self.navigationItem.rightBarButtonItem= mRightBartem;
    
}
- (void)setRightBtnTitle:(NSString *)mTitle{
    
    CGFloat titleW = [Util labelTextWithWidth:mTitle];
    UIButton *mRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_Width-titleW-10,15,titleW+10,25)];
    mRightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    mRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [mRightBtn setTitle:mTitle forState:UIControlStateNormal];
    [mRightBtn addTarget:self action:@selector(rightBtnAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mRightBartem = [[UIBarButtonItem alloc]initWithCustomView:mRightBtn];
    self.navigationItem.rightBarButtonItem= mRightBartem;
    

}

#pragma mark----****----页面跳转操作
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popViewController_2
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 2 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}
-(void)popViewController_3
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 2 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}
- (void)popViewController:(int)whatYouWant{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    
    if (whatYouWant == 1) {
        [self popViewController];
    }else if (whatYouWant == 2){
        [self popViewController_2];
    }else if (whatYouWant == 3){
        [self popViewController_3];
    }else if (whatYouWant == 4){
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
}

/**
 跳转到某个controller
 
 @param vc vc
 */
-(void)pushViewController:(UIViewController *)vc{
    if( [vc isKindOfClass:[WKBaseViewController class] ] )
    {
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
        
        [self.navigationController pushViewController:vc animated:YES];
    
    vc.hidesBottomBarWhenPushed = YES;
    
}

/**
 模态跳转下一级界面
 
 @param vc vc
 */
- (void)presentModalViewController:(UIViewController *)vc{
    if( [vc isKindOfClass:[WKBaseViewController class] ] )
    {
        
        
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
        
        [self presentViewController:vc animated:YES completion:nil];
}
/**
 *  模态跳转返回上一级
 */
- (void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  模态跳转返回上二级
 */
- (void)dismissViewController_2{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  模态跳转返回上三级
 */
- (void)dismissViewController_3{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  模态跳转返回上n级
 */
- (void)dismissViewController:(int)whatYouWant{
    self.presentingViewController.view.alpha = 0;
    [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark----****----刷新操作
/**
 列表刷新
 */
- (void)addTableViewHeaderRefreshing{
//    self.mTableViewRefreshStatus = UITableViewHeaderRefreshing;

    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [weakSelf tableViewHeaderReloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];

    [self.tableView.mj_header beginRefreshing];
}
/**
 列表底部刷新
 */
- (void)addTableViewFootererRefreshing{
//    self.mTableViewRefreshStatus = UITableViewFooterRefreshing;
    MLLog(@"当前刷新的状态是：%ld",(long)self.tableView.mj_footer.state);
    __weak typeof(self) weakSelf = self;

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        [weakSelf tableViewFooterReloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
/**
 列表加载数据
 */
- (void)tableViewHeaderReloadData{
//    self.mTableViewRefreshStatus = UITableViewHeaderRefreshing;
}
/**
 列表加载数据
 */
- (void)tableViewFooterReloadData{
//    self.mTableViewRefreshStatus = UITableViewFooterRefreshing;

}
#pragma mark----****----自定义弹出框
/**
 自定义弹出框
 
 @param mType 弹出框类型
 @param mTitle 标题
 @param mContent 内容
 @param mOkTitle 确定按钮
 @param mCancelTitle 取消按钮
 */
- (void)showCustomViewType:(WKCustomPopViewType)mType andTitle:(NSString *)mTitle andContentTx:(NSString *)mContent andOkBtntitle:(NSString *)mOkTitle andCancelBtntitle:(NSString *)mCancelTitle{
    
}
#pragma mark----****----hud框
- (void)showSucess:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"hud_sucess"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = text;
    
    [hud hideAnimated:YES afterDelay:2.f];

}
- (void)showError:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"hud_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = text;
    
    [hud hideAnimated:YES afterDelay:2.f];
}
- (void)showAlert:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"hud_alert"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = text;
    
    [hud hideAnimated:YES afterDelay:2.f];
}
- (void)showWithLoading:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    // Set the label text.
    hud.label.text = text;
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });

}

@end
