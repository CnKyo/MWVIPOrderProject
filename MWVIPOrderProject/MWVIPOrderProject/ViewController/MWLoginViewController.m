//
//  MWLoginViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWLoginViewController.h"
#import "MWHeader.h"
#import "mLoginView.h"
@interface MWLoginViewController ()

@property (strong,nonatomic) UIImageView *mBgkImg;



@end

@implementation MWLoginViewController

{
    mLoginView *mView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mBgkImg = [UIImageView new];
    _mBgkImg.backgroundColor = M_CO;
    [self.view addSubview:_mBgkImg];
    
    mView = [mLoginView initView];
    [self.view addSubview:mView];
    
    [_mBgkImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(400, 400));
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

@end
