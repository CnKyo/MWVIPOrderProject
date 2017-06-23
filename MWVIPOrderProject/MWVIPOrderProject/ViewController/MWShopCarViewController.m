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



@interface MWShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,mShopCarTableViewCellDelegate,mShopCarTableViewCellDelegate,mShopCarRightViewDelegate,XYBLEManagerDelegate>

@property(strong,nonatomic)  UITableView *mLeftTableView;

@property(strong,nonatomic)  mShopCarRightView *mRightView;

@property(strong,nonatomic)  XYBLEManager *manager;

@end

@implementation MWShopCarViewController
{
    NSMutableArray *peripheralDataArray;
    BabyBluetooth *baby;
    
    
    MWPrintType mPtype;
}
@synthesize connectionStatus;

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
    [SVProgressHUD showWithStatus:@"扫描设备中..."];

}
//3
-(void)viewDidAppear:(BOOL)animated{
    MLLog(@"viewDidAppear");
   
}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear");
}
//1
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"今日销售2000份营业额¥30000元";
    
    
    connectedDeviceInfo = [NSMutableArray new];
    connectingList = [NSMutableArray new];
    
    deviceInfo = [[DeviceInfo alloc]init];
    refreshDeviceListTimer = nil;
    [self setConnectionStatus:LE_STATUS_IDLE];
    controlPeripheral = [MyPeripheral new];
    
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
        mPtype = MWPrintTypeWithWechatPay;
        [self initBlueToothe];

 
        }
            break;
        case 1:
        {
        mPtype = MWPrintTypeWithCashPay;
        [self initBlueToothe];
        }
            break;
        case 2:
        {
        mPtype = MWPrintTypeWithOutPay;
        [self startScan];

        }
            break;
        case 3:
        {
        mPtype = MWPrintTypeWithScorePay;
        [self initBlueToothe];
        }
            break;
        case 4:
        {
        if (mPtype == MWPrintTypeWithOutPay) {
            if (controlPeripheral.connectStaus == MYPERIPHERAL_CONNECT_STATUS_CONNECTED) {
                [self GPrinterTask];
            }else {
                [self startScan];
            }
        }else{
            [self XPrinterTask];
        }
        
        }
            break;
            
        default:
            break;
    }
}
- (void)XPrinterTask{

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
    [mOrder addObject:[NSString stringWithFormat:@"\n共计:       7份"]];
    
    [mOrder addObject:[NSString stringWithFormat:@"\n合计:       200元"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n本次积分:       20.0"]];
    [mOrder addObject:[NSString stringWithFormat:@"\n实收:       195元"]];
    
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
    [self performSelector:@selector(XPSVPDissmiss) withObject:nil afterDelay:1];
}
- (void)XYdidFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    MLLog(@"链接失败peripherals:%@   失败的：%@",peripheral,error);
    [SVProgressHUD showSuccessWithStatus:@"打印机连接失败"];
    [self.manager XYstopScan];
    [self performSelector:@selector(XPSVPDissmiss) withObject:nil afterDelay:1];

}
- (void)XYdidDisconnectPeripheral:(CBPeripheral *)peripheral isAutoDisconnect:(BOOL)isAutoDisconnect{
    MLLog(@"链接已断开peripherals:%@   断开的：%d",peripheral,isAutoDisconnect);
    [SVProgressHUD showSuccessWithStatus:@"打印机已断开连接"];
    [self.manager XYstopScan];
    [self performSelector:@selector(XPSVPDissmiss) withObject:nil afterDelay:1];

}
- (void)XYdidWriteValueForCharacteristic:(CBCharacteristic *)character error:(NSError *)error{
    MLLog(@"写入数据:%@   错误的：%@",character,error);
    [self performSelector:@selector(XPSVPDissmiss) withObject:nil afterDelay:1];

}
- (void)XPSVPDissmiss{
    [SVProgressHUD dismiss];

}
#pragma mark----****----GPrinter代理方法
- (void) switchToMainFeaturePage {
    NSLog(@"[ConnectViewController] switchToMainFeaturePage");
    
    //    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    if ([[[appDelegate navigationController] viewControllers] containsObject:[deviceInfo mainViewController]] == FALSE) {
    //        [[appDelegate navigationController] pushViewController:[deviceInfo mainViewController] animated:YES];
    //    }
    
}

- (int) connectionStatus {
    return connectionStatus;
}
//2
- (void) setConnectionStatus:(int)status {
    if (status == LE_STATUS_IDLE) {
        
    }
    else {
        
    }
    connectionStatus = status;
    
    switch (status) {
        case LE_STATUS_IDLE:

            break;
        case LE_STATUS_SCANNING:
            [SVProgressHUD showWithStatus:@"扫描设备中..."];
            break;
        default:
            break;
    }
}


//4
- (void)startScan {
    [super startScan];
    if ([connectingList count] > 0) {
        for (int i=0; i< [connectingList count]; i++) {
            MyPeripheral *connectingPeripheral = [connectingList objectAtIndex:i];
            
            if (connectingPeripheral.connectStaus == MYPERIPHERAL_CONNECT_STATUS_CONNECTING) {
                //NSLog(@"startScan add connecting List: %@",connectingPeripheral.advName);
                [devicesList addObject:connectingPeripheral];
            }
            else {
                [connectingList removeObjectAtIndex:i];
                //NSLog(@"startScan remove connecting List: %@",connectingPeripheral.advName);
            }
        }
    }
    [self setConnectionStatus:LE_STATUS_SCANNING];
}

- (void)stopScan {
    [super stopScan];
    if (refreshDeviceListTimer) {
        [refreshDeviceListTimer invalidate];
        refreshDeviceListTimer = nil;
    }
}
//5
- (void)updateDiscoverPeripherals {
    [super updateDiscoverPeripherals];
    [self connectPeripheral];
}
///链接外部设备
- (void)connectPeripheral{

    for (int i = 0; i<devicesList.count; i++) {
        MyPeripheral *mDevice = devicesList[i];
        if ([mDevice.peripheral.name isEqualToString:@"Gprinter"] || [mDevice.advName isEqualToString:@"Gprinter"]) {
            [self connectDevice:mDevice];
            [SVProgressHUD showSuccessWithStatus:@"设备已链接"];
            controlPeripheral = mDevice;
            [SVProgressHUD dismiss];

        }
    }
}

///执行打印任务
- (void)GPrinterTask{
    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:NO];
    /*
     一定会发送的设置项
     */
    //Size
    ///宽高
    [tscCmd addSize:100 :50];
    
    //GAP间隙长度  间隙偏移
    
    [tscCmd addGapWithM:2   withN:0];
    
    //REFERENCE纵坐标y。横坐标x
    [tscCmd addReference:0
                        :0];
    
    //SPEED打印速度
    [tscCmd addSpeed:4];
    
    //DENSITY打印浓度
    [tscCmd addDensity:8];
    
    //DIRECTION方向
    [tscCmd addDirection:0];
    
    //fixed command发送一些TSC的固定命令，在cls命令之前发送
    [tscCmd addComonCommand];
    //清除打印缓冲区
    [tscCmd addCls];
    
    /**
     * 方法说明:在标签上绘制文字
     * @param x 横坐标
     * @param y 纵坐标
     * @param font  字体类型
     * @param rotation  旋转角度
     * @param Xscal  横向放大
     * @param Yscal  纵向放大
     * @param text   文字字符串
     * @return void
     */
    [tscCmd addTextwithX:180
                   withY:160
                withFont:@"TSS24.BF2"
            withRotation:0
               withXscal:1
               withYscal:1
                withText:@"重庆漫维文化传播有限公司"];
    
    [tscCmd addTextwithX:180
                   withY:190
                withFont:@"TSS24.BF2"
            withRotation:0
               withXscal:1
               withYscal:1
                withText:@"电话：151515151515"];
    
    [tscCmd addTextwithX:180
                   withY:220
                withFont:@"TSS24.BF2"
            withRotation:0
               withXscal:1
               withYscal:1
                withText:@"杨家坪大洋百货正升百脑汇2栋12-2"];
    ///二维码
    /**
     * 方法说明:在标签上绘制QRCode二维码
     * @param x 横坐标
     * @param y 纵坐标
     * @param ecclever 选择QRCODE纠错等级,L为7%,M为15%,Q为25%,H为30%
     * @param cellwidth  二维码宽度1~10，默认为4
     * @param mode  默认为A，A为Auto,M为Manual
     * @param rotation  旋转角度，QRCode二维旋转角度，顺时钟方向，0不旋转，90顺时钟方向旋转90度，180顺时钟方向旋转180度，270顺时钟方向旋转270度
     * @param content   条码内容
     * @return void
     * QRCODE X,Y ,ECC LEVER ,cell width,mode,rotation, "data string"
     * QRCODE 20,24,L,4,A,0,"佳博集团网站www.Gprinter.com.cn"
     */
    [tscCmd addQRCode:350
                     :50
                     :@"L"
                     :4
                     :@"A"
                     :0
                     :@"佳博集团网站www.Gprinter.com.cn"];
    //print将字符串转成十六进制码
    [tscCmd addPrint:1 :1];

}
- (void)updateMyPeripheralForNewConnected:(MyPeripheral *)myPeripheral {
    
    [[BLKWrite Instance] setPeripheral:myPeripheral];
    
    NSLog(@"[ConnectViewController] updateMyPeripheralForNewConnected");
    DeviceInfo *tmpDeviceInfo = [[DeviceInfo alloc]init];
    
    tmpDeviceInfo.myPeripheral = myPeripheral;
    tmpDeviceInfo.myPeripheral.connectStaus = myPeripheral.connectStaus;
    
    /*Connected List Filter*/
    bool b = FALSE;
    for (int idx =0; idx< [connectedDeviceInfo count]; idx++) {
        DeviceInfo *tmpDeviceInfo = [connectedDeviceInfo objectAtIndex:idx];
        if (tmpDeviceInfo.myPeripheral == myPeripheral) {
            b = TRUE;
            break;
        }
    }
    if (!b) {
        [connectedDeviceInfo addObject:tmpDeviceInfo];
    }
    else{
        NSLog(@"Connected List Filter!");
    }
    
    for (int idx =0; idx< [connectingList count]; idx++) {
        MyPeripheral *tmpPeripheral = [connectingList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            //NSLog(@"connectingList removeObject:%@",tmpPeripheral.advName);
            [connectingList removeObjectAtIndex:idx];
            break;
        }
    }
    
    for (int idx =0; idx< [devicesList count]; idx++) {
        MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            //NSLog(@"devicesList removeObject:%@",tmpPeripheral.advName);
            [devicesList removeObjectAtIndex:idx];
            break;
        }
    }
    
    
}
- (void)dealloc{
    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd addCls];
    if (controlPeripheral!=nil) {
        [self disconnectDevice:controlPeripheral];

    }
    [SVProgressHUD dismiss];
}
@end
