//
//  MWVIPFinderViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/18.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWVIPFinderViewController.h"
#import "MWHeader.h"
#import "MWVIPFinderCell.h"

#import "MWVIPFinderHeaderView.h"
@interface MWVIPFinderViewController ()<UITableViewDelegate,UITableViewDataSource,MWVIPFinderHeaderViewDelagate>

@end

@implementation MWVIPFinderViewController
{
    UITableView *mTableView;
    UIView *mBgkPopView;
    MWVIPFinderHeaderView *mPopView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会员列表";
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor colorWithRed:0.964705882352941 green:0.964705882352941 blue:0.964705882352941 alpha:1.00];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:mTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"MWVIPFinderCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
        
    }];

    [self initPopView];
    
    UIButton *mRightBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_Width-120,15,25,25)];
    mRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    CGRect mR = mRightBtn.frame;
    
    mR.size.width = 120;
    mRightBtn.frame = mR;
    [mRightBtn setTitle:@"查询我的信息" forState:UIControlStateNormal];
    [mRightBtn addTarget:self action:@selector(mRightAction)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *mRightBartem = [[UIBarButtonItem alloc]initWithCustomView:mRightBtn];
    self.navigationItem.rightBarButtonItem= mRightBartem;
}
#pragma mark---****----右边的按钮
- (void)mRightAction{
   
    [self showPopView];
}
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    MWVIPFinderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.mName.text = @"把一本好小说毁了是什么体验，「悟空传」请抢答";
    cell.mScore.text = @"100";

    return cell;
    
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
