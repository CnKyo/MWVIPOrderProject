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
@interface MWScoreConvertViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)  UICollectionView *mCollectionView;

@end

@implementation MWScoreConvertViewController

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

@end
