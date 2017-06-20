//
//  ViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/16.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController
{
    UITableView *mLeftTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"今日销售2000份营业额¥30000元";
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
