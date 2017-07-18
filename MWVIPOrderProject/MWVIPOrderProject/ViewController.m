//
//  ViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/16.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "ViewController.h"
#import "MWHeader.h"
#import "mLeftTableViewCell.h"
#import "mRightCollectionViewCell.h"

#import "MWShopCarViewController.h"

#import "MWLoginViewController.h"
#import "ZLSuperMarketShopCarView.h"
#import "MWStaticsViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZLSuperMarketShopCarDelegate>

@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property(strong,nonatomic)  UICollectionView *mCollectionView;
@property(strong,nonatomic)  UITableView *mLeftTableView;

@end

@implementation ViewController
{
    ZLSuperMarketShopCarView *mShopCarView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"今日销售2000份营业额¥30000元";
    
    
    UIButton *mLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(80,15,70,20)];
    
    [mLeftBtn setTitle:@"换班" forState:UIControlStateNormal];
    [mLeftBtn addTarget:self action:@selector(mLeftAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mBackItem = [[UIBarButtonItem alloc]initWithCustomView:mLeftBtn];
    self.navigationItem.leftBarButtonItem= mBackItem;
    

    UIButton *mRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_Width-60,15,25,25)];
    mRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    CGRect mR = mRightBtn.frame;
   
    mR.size.width = 100;
    mRightBtn.frame = mR;
    [mRightBtn setTitle:@"收银统计" forState:UIControlStateNormal];
    [mRightBtn addTarget:self action:@selector(mRightAction:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mRightBartem = [[UIBarButtonItem alloc]initWithCustomView:mRightBtn];
    self.navigationItem.rightBarButtonItem= mRightBartem;
    
    
    _mLeftTableView = [UITableView new];
    _mLeftTableView.backgroundColor = M_CO;
    _mLeftTableView.delegate = self;
    _mLeftTableView.dataSource = self;
    [self.view addSubview:_mLeftTableView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        self.mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((DEVICE_Width/3), 64, DEVICE_Width-(DEVICE_Width/3), DEVICE_Height-64-60) collectionViewLayout:flowLayout];
//    self.mCollectionView = [UICollectionView new];
//    [self.mCollectionView setCollectionViewLayout:flowLayout];
    //    self.mCollectionView = [[UICollectionView alloc] init];
    //    self.mCollectionView.collectionViewLayout = flowLayout;
    [self.mCollectionView registerClass:[mRightCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.mCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mCollectionView];
    
    self.mCollectionView.dataSource = self;
    self.mCollectionView.delegate = self;

    
    mShopCarView = [ZLSuperMarketShopCarView shareView];
//    mShopCarView.mNum.hidden = YES;
    mShopCarView.mNum.text = @"99";
    [self.view addSubview:mShopCarView];
    
    UINib   *nib = [UINib nibWithNibName:@"mLeftTableViewCell" bundle:nil];
    [_mLeftTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [_mLeftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.bottom.equalTo(mShopCarView.mas_top).offset(0);
        make.width.offset(DEVICE_Width/3);
    }];
    
//    [self.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.top.bottom.equalTo(self.view);
//        
//        make.left.equalTo(_mLeftTableView.mas_right);
//    }];
    
    [mShopCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mLeftTableView.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view).offset(0);
        make.height.offset(60);
    }];
    
}
#pragma mark---****----左边的按钮
- (void)mLeftAction{

}
#pragma mark---****----右边的按钮
- (void)mRightAction:(UIButton *)sender{
    MWStaticsViewController *vc = [MWStaticsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    mLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.mName.text = [NSString stringWithFormat:@"第%ld个",indexPath.row];
    cell.backgroundColor = M_CO;
    cell.mName.textColor = [UIColor whiteColor];

    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了%ld行",indexPath.row);
    //之前选中的，取消选择
    mLeftTableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
    celled.backgroundColor = M_CO;
    celled.mName.textColor = [UIColor whiteColor];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    mLeftTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.mName.textColor = M_CO;
    
    MWShopCarViewController *vc = [MWShopCarViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 26;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    mRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.mBgk.backgroundColor = M_CO;
    cell.mName.text = @"365天黄金会员（0.1折）";
    cell.mPrice.text = @"25.0元";
    cell.mSalesNum.text = @"1000小了";
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionReusableView *reusable = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
//        
//0
//    }
//    return reusable;
//}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
//    NSString *message = [[NSString alloc] initWithFormat:@"你点击了第%ld个section，第%ld个cell",(long)indexPath.section,(long)indexPath.row];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //点击确定后执行的操作；
//    }]];
//    [self presentViewController:alert animated:true completion:^{
//        //显示提示框后执行的事件；
//    }];
    
    MWLoginViewController *vc = [MWLoginViewController new];
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 80) / 3+10, (SCREEN_WIDTH - 80) / 3 + 65);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(300, 20);
//}
/**
 购物车代理方法
 */
- (void)ZLSuperMarketShopCarDidSelected{
    MLLog(@"购物车代理方法");
}

/**
 去结算代理方法
 */
- (void)ZLSuperMarketGoPayDidSelected{
    MLLog(@" 去结算代理方法");

}
@end
