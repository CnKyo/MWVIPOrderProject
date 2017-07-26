//
//  MWScoreConvertViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/24.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWScoreConvertViewController.h"
#import "MWHeader.h"
#import "MWScoreConvertCell.h"

#import "MWVIPFinderHeaderView.h"

@interface MWScoreConvertViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MWVIPFinderHeaderViewDelagate>
@property(strong,nonatomic)  UICollectionView *mCollectionView;

@end

@implementation MWScoreConvertViewController
{
    UIView *mBgkPopView;
    MWVIPFinderHeaderView *mPopView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"积分兑换";
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height) collectionViewLayout:flowLayout];
    //    self.mCollectionView = [UICollectionView new];
    //    [self.mCollectionView setCollectionViewLayout:flowLayout];
    //    self.mCollectionView = [[UICollectionView alloc] init];
    //    self.mCollectionView.collectionViewLayout = flowLayout;
    [self.mCollectionView registerClass:[MWScoreConvertCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.mCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mCollectionView];
    
    self.mCollectionView.dataSource = self;
    self.mCollectionView.delegate = self;

    [self initPopView];

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
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 26;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MWScoreConvertCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
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
    MLLog(@"点击了第%ld",indexPath.row);
    [self showPopView];

    
}

#pragma mark - UICollectionViewDelegateFlowLayout调整大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 80) / 3+10, (SCREEN_WIDTH - 80) / 3 + 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(300, 20);
//}
- (void)initPopView{
    mBgkPopView = [UIView new];
    mBgkPopView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    mBgkPopView.frame = CGRectMake(0, 64, DEVICE_Width, DEVICE_Height-64);
    mBgkPopView.alpha = 0;
    [self.view addSubview:mBgkPopView];
    
    mPopView = [MWVIPFinderHeaderView initView];
    mPopView.frame = CGRectMake(DEVICE_Width/2-200, DEVICE_Height/2-300, 400, 500);
    mPopView.layer.cornerRadius = 4;
    mPopView.alpha = 0;
    mPopView.delegate = self;
    [mBgkPopView addSubview:mPopView];
}
- (void)showPopView{
    [UIView animateWithDuration:0.5 animations:^{
        mBgkPopView.alpha = 1;
        mPopView.alpha = 1;
    }];
}
- (void)dismissPopView{
    [UIView animateWithDuration:0.5 animations:^{
        mBgkPopView.alpha = 0;
        mPopView.alpha = 0;
    }];
}

/**
 输入框代理方法
 
 @param mText 返回输入的内容
 */
- (void)MWVIPFinderHeaderViewWithPhoneTextDidEndEditing:(NSString *)mText{
    
}

/**
 按钮点击代理方法
 
 @param mTag 返回点击的tag
 */
- (void)MWVIPFinderHeaderViewWithBtnclicked:(NSInteger)mTag{
    switch (mTag) {
        case 1:
        {
        MLLog(@"确定");
        [SVProgressHUD showSuccessWithStatus:@"兑换成功！"];
        [self dismissPopView];
        }
            break;
        case 2:
        {
        MLLog(@"取消");
        [self dismissPopView];
        }
            break;
            
        default:
            break;
    }
}

@end
