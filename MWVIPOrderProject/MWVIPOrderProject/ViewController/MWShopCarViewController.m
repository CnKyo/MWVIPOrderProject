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
#define channelOnPeropheralView @"peripheralView"

@interface MWShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,mShopCarTableViewCellDelegate,mShopCarTableViewCellDelegate,mShopCarRightViewDelegate>

@property(strong,nonatomic)  UITableView *mLeftTableView;

@property(strong,nonatomic)  mShopCarRightView *mRightView;

@end

@implementation MWShopCarViewController
{
    NSMutableArray *peripheralDataArray;
    BabyBluetooth *baby;
}
- (void)initBlueToothe{

    [SVProgressHUD showInfoWithStatus:@"准备打开设备"];
    NSLog(@"viewDidLoad");
    peripheralDataArray = [[NSMutableArray alloc]init];
    
    //初始化BabyBluetooth 蓝牙库
    baby = [BabyBluetooth shareBabyBluetooth];
    //设置蓝牙委托
    [self babyDelegate];

}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    //停止之前的连接
    [baby cancelAllPeripheralsConnection];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    baby.scanForPeripherals().begin();
    //baby.scanForPeripherals().begin().stop(10);
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
    
//    [_mLeftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(self.view);
//        
//        make.width.offset(DEVICE_Width/2);
//    }];
    
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
    _mRightView.mPopView.hidden = NO;
    [self updateRightView];
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

//蓝牙网关初始化和委托方法设置
-(void)babyDelegate{
    
    __weak typeof(self) weakSelf = self;
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
        }
    }];
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
    
    
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
    }];
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        //最常用的场景是查找某一个前缀开头的设备
        //        if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //            return YES;
        //        }
        //        return NO;
        
        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length >0) {
            return YES;
        }
        return NO;
    }];
    
    
    [baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    [baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelScanBlock");
    }];
    
    
    /*设置babyOptions
     
     参数分别使用在下面这几个地方，若不使用参数则传nil
     - [centralManager scanForPeripheralsWithServices:scanForPeripheralsWithServices options:scanForPeripheralsWithOptions];
     - [centralManager connectPeripheral:peripheral options:connectPeripheralWithOptions];
     - [peripheral discoverServices:discoverWithServices];
     - [peripheral discoverCharacteristics:discoverWithCharacteristics forService:service];
     
     该方法支持channel版本:
     [baby setBabyOptionsAtChannel:<#(NSString *)#> scanForPeripheralsWithOptions:<#(NSDictionary *)#> connectPeripheralWithOptions:<#(NSDictionary *)#> scanForPeripheralsWithServices:<#(NSArray *)#> discoverWithServices:<#(NSArray *)#> discoverWithCharacteristics:<#(NSArray *)#>]
     */
    
    //示例:
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    //连接设备->
    [baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
    
    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [baby setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接成功",peripheral.name]];
    }];
    
    //设置设备连接失败的委托
    [baby setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接失败",peripheral.name]];
    }];
    
    //设置设备断开连接的委托
    [baby setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--断开连接",peripheral.name);
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--断开失败",peripheral.name]];
    }];

}

#pragma mark -UIViewController 方法
//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSArray *peripherals = [peripheralDataArray valueForKey:@"peripheral"];
    if(![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];
        [item setValue:advertisementData forKey:@"advertisementData"];
        [peripheralDataArray addObject:item];
        
    }
    NSDictionary *item = [peripheralDataArray objectAtIndex:0];
    CBPeripheral *mPeripheral = [item objectForKey:@"peripheral"];
    [self connectDevice:mPeripheral andBaby:baby];
}
- (void)connectDevice:(CBPeripheral *)peripheral andBaby:(BabyBluetooth *)mBle{
    [baby cancelScan];

    [SVProgressHUD showInfoWithStatus:@"开始连接设备"];
    baby.having(peripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();

}

@end
