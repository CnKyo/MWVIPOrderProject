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
@interface MWVIPFinderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MWVIPFinderViewController
{
    UITableView *mTableView;
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

    return cell;
    
}
@end
