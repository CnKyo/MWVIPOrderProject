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
#import "MWPrintTaskViewController.h"
#import "MWVIPFinderViewController.h"
#import "MWScoreConvertViewController.h"
#import "MWSelectDeskView.h"

#import "SQMenuShowView.h"
#import "RadioCollectionViewCell.h"
#import "singleModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZLSuperMarketShopCarDelegate,RightCollectionSelectedProductNumDelegate,MWSelectDeskViewDelegate>

@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property(strong,nonatomic)  UICollectionView *mCollectionView;
@property(strong,nonatomic)  UITableView *mLeftTableView;

@property (strong, nonatomic)  SQMenuShowView *showView;
@property (assign, nonatomic)  BOOL  isShow;

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ViewController
{
    ZLSuperMarketShopCarView *mShopCarView;
    
    MWSelectDeskView *mDeskView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"今日销售2000份营业额¥30000元";
    
    
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
    mShopCarView.delegate = self;
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
    
    UIButton *mLeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(80,15,100,20)];
    
    [mLeftBtn setTitle:@"选择座号" forState:UIControlStateNormal];
    [mLeftBtn addTarget:self action:@selector(mLeftAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mBackItem = [[UIBarButtonItem alloc]initWithCustomView:mLeftBtn];
    self.navigationItem.leftBarButtonItem= mBackItem;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更多操作"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(show)];
    
    
    __weak typeof(self) weakSelf = self;
    [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        weakSelf.isShow = NO;
        ///1:"收银统计",2:"任务列表",3:"会员查询",4:"积分兑换",5:"分享有礼",6:"换班/登录"
        if (index == 0) {
            MWStaticsViewController *vc = [MWStaticsViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            MLLog(@"点击第%ld个item",index+1);
            
        }else if(index == 1){
            
            MWPrintTaskViewController *vc = [MWPrintTaskViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            MLLog(@"点击第%ld个item",index+1);
            
        }else if(index == 2){
            
            MWVIPFinderViewController *vc = [MWVIPFinderViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            MLLog(@"点击第%ld个item",index+1);
            
        }else if(index == 3){
            
            MWScoreConvertViewController *vc = [MWScoreConvertViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            MLLog(@"3");
        }else if(index == 4){
            MWLoginViewController *vc = [MWLoginViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            MLLog(@"4");
        }else{
            MLLog(@"6");
            MWLoginViewController *vc = [MWLoginViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];

 
    [self initDeskView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isShow = NO;
    [self.showView dismissView];
}

- (SQMenuShowView *)showView{
    
    if (_showView) {
        return _showView;
    }
    
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-100-10,64+5,100,0}
                                               items:@[@"收银统计",@"任务列表",@"会员查询",@"积分兑换",@"分享有礼",@"换班/登录"]
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10}];
    _showView.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView];
    return _showView;
}


- (void)show{
    _isShow = !_isShow;
    
    if (_isShow) {
        [self.showView showView];
        
    }else{
        [self.showView dismissView];
    }
    
}

#pragma mark---****----左边的按钮
- (void)mLeftAction{
    MLLog(@"选择座位 ");
    [self showDeskView];
}

#pragma mark---****----初始化选桌座号view
- (void)initDeskView{
    mDeskView = [MWSelectDeskView initView];
    mDeskView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, 300);
    
    mDeskView.delegate = self;
    [self.view addSubview:mDeskView];
    
    [self downLoad];
    [self createUI];

}
- (void)showDeskView{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect mRRR = mDeskView.frame;
        mRRR.origin.y = DEVICE_Height-300;
        mDeskView.frame = mRRR;
    }];
}
- (void)dissmissDeskView{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect mRRR = mDeskView.frame;
        mRRR.origin.y = 300;
        mDeskView.frame = mRRR;
    }];
}
/**
 按钮代理方法
 
 @param mTag 1:取消 2:确定
 */
- (void)MWSelectDeskViewBtnDidClicked:(NSInteger)mTag{
    switch (mTag) {
        case 1:
        {
        [self dissmissDeskView];
        }
            break;
        case 2:
        {
        [self dissmissDeskView];
        }
            break;
            
        default:
            break;
    }
}
- (void)downLoad
{
    NSString* plistfile1 = [[NSBundle mainBundle]pathForResource:@"dataList" ofType:@".plist"];
    NSMutableArray * array = [[NSMutableArray alloc]initWithContentsOfFile:plistfile1];
    //打印出字典里的数据
    for (NSDictionary * dict in array) {
        singleModel * model = [[singleModel alloc]init];
        model.title = dict[@"title"];
        model.selected = NO;
        [self.dataSource addObject:model];
    }
    
}

- (void)createUI
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(DEVICE_Width/3.0-20, 36);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 2;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, mDeskView.mView.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [mDeskView.mView addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RadioCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CellIde"];
    [self.collectionView reloadData];
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
    

}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == self.collectionView) {
        return self.dataSource.count;

    }else{
        return 26;
    }
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.collectionView) {
        RadioCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIde" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[RadioCollectionViewCell alloc] init];
        }
        singleModel * model = self.dataSource[indexPath.row];
        if (model.selected) {
            cell.contentView.layer.cornerRadius = 4;
            cell.contentView.layer.borderColor = [UIColor colorWithRed:0.0784313725490196 green:0.133333333333333 blue:0.47843137254902 alpha:1.00].CGColor;
            cell.contentView.layer.borderWidth = 1;
            cell.mNum.textColor = [UIColor colorWithRed:0.211764705882353 green:0.231372549019608 blue:0.329411764705882 alpha:1.00];
            
        }else{
            cell.contentView.layer.cornerRadius = 4;
            cell.contentView.layer.borderColor = [UIColor colorWithRed:0.949019607843137 green:0.949019607843137 blue:0.949019607843137 alpha:1.00].CGColor;
            cell.contentView.layer.borderWidth = 1;
            cell.mNum.textColor = [UIColor colorWithRed:0.698039215686274 green:0.698039215686274 blue:0.698039215686274 alpha:1.00];
            
        }
        cell.mImg.hidden = model.selected?NO:YES;
        
        [cell.mNum setText:[NSString stringWithFormat:@"  %@号桌",model.title]];
        return cell;

    }else{
        mRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.mBgk.backgroundColor = M_CO;
        cell.mName.text = @"365天黄金会员（0.1折）";
        cell.mPrice.text = @"25.0元";
        cell.mSalesNum.text = @"1000小了";
        cell.delegate = self;
        return cell;
    }
    
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
    
    if (collectionView == self.collectionView) {
        for (singleModel * signerModel in self.dataSource) {
            signerModel.selected = NO;
        }
        singleModel * model = self.dataSource[indexPath.row];
        model.selected = YES;
        [self.collectionView reloadData];

    }
    
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

#pragma mark - UICollectionViewDelegateFlowLayout调整大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionView) {
        return CGSizeMake(SCREEN_WIDTH/3.0-20, 36);
    }else{
        return CGSizeMake((SCREEN_WIDTH - 80) / 3+10, (SCREEN_WIDTH - 80) / 3 + 100);

    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView == self.collectionView) {
        return UIEdgeInsetsMake(0, 20, 0, 20);

    }else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(300, 20);
//}
/**
 购物车代理方法
 */
- (void)ZLSuperMarketShopCarDidSelected{
    MLLog(@"购物车代理方法");
    MWShopCarViewController *vc = [MWShopCarViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 去结算代理方法
 */
- (void)ZLSuperMarketGoPayDidSelected{
    MLLog(@" 去结算代理方法");
    MWShopCarViewController *vc = [MWShopCarViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)RightCollectionSelectedProductNum:(NSInteger)mNum{
    MLLog(@"num是：%ld",mNum);
}

@end
