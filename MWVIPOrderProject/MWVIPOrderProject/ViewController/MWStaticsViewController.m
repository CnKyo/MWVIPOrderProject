//
//  MWStaticsViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/17.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWStaticsViewController.h"
#import "MWHeader.h"
#import "MWStaticsTableViewCell.h"
#import "MWStaticsHeaderCell.h"
#import "MWStaticsSectionCell.h"
@interface MWStaticsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSMutableArray *tempMArray; // 用于判断手风琴的某个层级是否展开
@end

@implementation MWStaticsViewController
{
    UITableView *mTableView;
}
-(NSMutableArray *)mArray{
    
    if (!_mArray) {
        
        _mArray = [[NSMutableArray alloc]init];
    }
    return _mArray;
}
- (NSMutableArray *)tempMArray{
    
    if (!_tempMArray) {
        
        _tempMArray = [[NSMutableArray alloc]init];
    }
    return _tempMArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"收银统计";
    
    for (int i = 1; i < 13; i++) {
        
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        [mDic setObject:[NSString stringWithFormat:@"%d月份",i] forKey:@"name"];
        NSMutableArray *mArr = [[NSMutableArray alloc]init];
        for (int j = 0; j < 3; j++) {
            
            [mArr addObject:[NSString stringWithFormat:@"我是第%d个里面的元素%d",i,j]];
        }
        [mDic setObject:mArr forKey:@"mArr"];
        [self.mArray addObject:mDic];
        [self.tempMArray addObject:@"0"];
    }

    
    mTableView = [UITableView new];
    mTableView.backgroundColor = [UIColor whiteColor];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    [self.view addSubview:mTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"MWStaticsTableViewCell" bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [mTableView registerNib:[UINib nibWithNibName:@"MWStaticsHeaderCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
    [mTableView registerNib:[UINib nibWithNibName:@"MWStaticsSectionCell" bundle:nil] forCellReuseIdentifier:@"sectionCell"];

    
    MWStaticsHeaderCell *cell = [mTableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    [mTableView dequeueReusableCellWithIdentifier:@"CustomCell"];

    mTableView.tableHeaderView = cell;

    
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
    
    return self.mArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.tempMArray[section] isEqualToString:@"0"]) {
        
        return 0;
    }else{
        // 如果是展开的则给这个分区加一个cell用来放此分区的标题cell
        NSArray *array = self.mArray[section][@"mArr"];
        return array.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    MWStaticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array=self.mArray[indexPath.section][@"mArr"];

    cell.mName.text = [NSString stringWithFormat:@"第%@个",array[indexPath.row]];
    
    return cell;
    
}
// 组的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MWStaticsSectionCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"sectionCell"];
    headerCell.mMonth.text = self.mArray[section][@"name"];

    headerCell.tag = section + 1000;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [headerCell addGestureRecognizer:tap];
    return headerCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}
#pragma mark --- 轻拍手势的点击方法 ---
- (void)tapAction:(UITapGestureRecognizer *)sender{
    
    MWStaticsSectionCell *cell = (MWStaticsSectionCell *)sender.view;
    [self.tempMArray[cell.tag - 1000] isEqualToString:@"0"]?[self.tempMArray replaceObjectAtIndex:cell.tag - 1000 withObject:@"1"]:[self.tempMArray replaceObjectAtIndex:cell.tag - 1000 withObject:@"0"];
    [mTableView reloadData];
    MLLog(@"我是轻拍手势的cell===%@",cell);
}

@end
