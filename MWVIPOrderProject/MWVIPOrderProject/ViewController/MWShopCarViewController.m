//
//  MWShopCarViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWShopCarViewController.h"
#import "MWHeader.h"
#import "mShopCarTableViewCell.h"
#import "mShopCarRightView.h"



#import "XYSDK.h"

#import "TscCommand.h"
#import "BLKWrite.h"
#import "EscCommand.h"

@interface MWShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,mShopCarTableViewCellDelegate,mShopCarTableViewCellDelegate,mShopCarRightViewDelegate,XYBLEManagerDelegate>

@property(strong,nonatomic)  UITableView *mLeftTableView;

@property(strong,nonatomic)  mShopCarRightView *mRightView;

@property(strong,nonatomic)  XYBLEManager *manager;

@end

@implementation MWShopCarViewController
{
    NSMutableArray *peripheralDataArray;
    BabyBluetooth *baby;
}
- (void)initBlueToothe{

    self.manager = [XYBLEManager sharedInstance];
    
    self.manager.delegate = self;
    [self.manager XYSetDataCodingType:NSUTF8StringEncoding];
    [self.manager XYhorizontalPosition];
//        [self.manager XYprintAndFeed]; 
    [self.manager XYPrintAndBackToNormalModel];
    MLLog(@"viewDidLoad");
    peripheralDataArray = [[NSMutableArray alloc]init];
    [self.manager XYstartScan];

}
-(void)viewDidAppear:(BOOL)animated{
    MLLog(@"viewDidAppear");
   
}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"今日销售2000份营业额¥30000元";
    _mLeftTableView = [UITableView new];
    _mLeftTableView.backgroundColor = [UIColor whiteColor];
    _mLeftTableView.delegate = self;
    _mLeftTableView.dataSource = self;
    [self.view addSubview:_mLeftTableView];
    UINib   *nib = [UINib nibWithNibName:@"mShopCarTableViewCell" bundle:nil];
    [_mLeftTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    _mRightView = [mShopCarRightView initView];
    _mRightView.delegate = self;
    _mRightView.mPopView.hidden = YES;
    [self.view addSubview:_mRightView];
    
    
    [_mLeftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.right.equalTo(_mRightView.mas_left);
        
        make.width.offset(DEVICE_Width/2);

    }];
    [_mRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.left.equalTo(_mLeftTableView.mas_right);
        make.width.offset(DEVICE_Width/2);
    }];
    [self initBlueToothe];

}
- (void)updateRightView{
    _mRightView.mWechatPay.hidden = _mRightView.mCashPay.hidden = _mRightView.mOutPay.hidden = _mRightView.mScorePay.hidden = YES;
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
    
    mShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.mName.text = [NSString stringWithFormat:@"第%ld个",indexPath.row];
    cell.delegate = self;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 加按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)mShopCarTableViewCellDelegateWithPlusBtnClicked:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了第%ld个",mIndexPath.row);
}

/**
 减按钮代理方法
 
 @param mIndexPath 索引
 */
- (void)mShopCarTableViewCellDelegateWithMinusBtnClicked:(NSIndexPath *)mIndexPath{
    MLLog(@"点击了第%ld个",mIndexPath.row);
}


/**
 按钮代理方法
 
 @param mTag 标记tag(0:微信支付，1:现金支付，2:外卖支付，3:积分支付)
 */
- (void)mShopCarRightViewDelegateWithBtnClicked:(NSInteger)mTag{
    MLLog(@"点击了第%ld个",mTag);
    NSMutableArray *mOrder = [NSMutableArray new];

    [mOrder addObject:[NSString stringWithFormat:@"\n"]];
    NSString *mShopName = @"\n重庆漫维文化科技有限公司";
    NSString *mAddress = @"\n重庆市九龙坡区杨家坪大洋百货2栋12-2";
    NSString *mCreateTime = @"\n2017-06-22  09:37";
    NSString *line = @"\n--------------------------------";
    [mOrder addObject:mShopName];
    [mOrder addObject:mAddress];
    [mOrder addObject:mCreateTime];
    [mOrder addObject:line];
    for (int i = 0; i<7; i++) {
        NSString *mEat = [NSString stringWithFormat:@"\n这是菜品---%d",i];
        [mOrder addObject:mEat];
    }
    [mOrder addObject:[NSString stringWithFormat:@"\n"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n共计:7份"]];

    [mOrder addObject:[NSString stringWithFormat:@"\n合计:200元"]];

    [mOrder addObject:[NSString stringWithFormat:@"\n送达地址:重庆市九龙坡区谢家湾正街18号"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n电话:154454654654"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n姓名:老师"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n"]];

    [self.manager setWritePeripheral:self.manager.writePeripheral];

    //声明一个gbk编码类型
    unsigned long  gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    for (NSString *mstr in mOrder) {
        MLLog(@"转换前----%@",mstr);
        NSData *mData = [mstr dataUsingEncoding:gbkEncoding];
        [self.manager XYWritePOSCommondWithData:mData callBack:^(CBCharacteristic *datcharacter) {
            MLLog(@"%@",datcharacter);
        }];
    }
    
//    [self.manager XYWriteTSCCommondWithData:data callBack:^(CBCharacteristic *datcharacter) {
//        MLLog(@"%@",datcharacter);
//
//    }];
    
    
    
//    _mRightView.mPopView.hidden = NO;
//    [self updateRightView];
    switch (mTag) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
        
        }
            break;
        case 2:
        {
        
        }
            break;
        case 3:
        {
        
        }
            break;
            
        default:
            break;
    }
}

/**
 输入框代理方法
 
 @param mText 返回输入内容
 */
- (void)mShopCarRightViewDelegateWithPhoneTextEndEditing:(NSString *)mText{
    MLLog(@"输入的内容是：%@",mText);
}

#pragma mark -蓝牙配置和操作
- (void)XYdidUpdatePeripheralList:(NSArray *)peripherals RSSIList:(NSArray *)rssiList{
    MLLog(@"peripherals:%@-------rssiList:%@",peripherals,rssiList);
    if (peripherals.count>0) {
        for (CBPeripheral *printer in peripherals) {
            if ([printer.name isEqualToString:@"Printer001"]) {
                self.manager.writePeripheral = printer;
                [self.manager XYconnectDevice:printer];

            }
        }
    }
    
    
}
- (void)XYdidConnectPeripheral:(CBPeripheral *)peripheral{
    MLLog(@"链接成功peripherals:%@",peripheral);
    [SVProgressHUD showSuccessWithStatus:@"打印机连接成功"];
    [self.manager XYstopScan];

}
- (void)XYdidFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    MLLog(@"链接失败peripherals:%@   失败的：%@",peripheral,error);
    [SVProgressHUD showSuccessWithStatus:@"打印机连接失败"];
    [self.manager XYstopScan];


}
- (void)XYdidDisconnectPeripheral:(CBPeripheral *)peripheral isAutoDisconnect:(BOOL)isAutoDisconnect{
    MLLog(@"链接已断开peripherals:%@   断开的：%d",peripheral,isAutoDisconnect);
    [SVProgressHUD showSuccessWithStatus:@"打印机已断开连接"];
    [self.manager XYstopScan];


}
- (void)XYdidWriteValueForCharacteristic:(CBCharacteristic *)character error:(NSError *)error{
    MLLog(@"写入数据:%@   错误的：%@",character,error);

}

@end
