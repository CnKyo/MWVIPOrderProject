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


#import "SEPrinterManager.h"

@interface MWShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,mShopCarTableViewCellDelegate,mShopCarTableViewCellDelegate,mShopCarRightViewDelegate>

@property(strong,nonatomic)  UITableView *mLeftTableView;

@property(strong,nonatomic)  mShopCarRightView *mRightView;


@property (strong, nonatomic)   NSMutableArray              *deviceArray;  /**< 蓝牙设备个数 */



@end

@implementation MWShopCarViewController
{
    NSMutableArray *peripheralDataArray;
    BabyBluetooth *baby;
    
    
    MWPrintType mPtype;
    
}
@synthesize connectionStatus;

- (void)initBlueToothe{

    [SVProgressHUD showWithStatus:@"正在链接设备..."];
    
    for (CBPeripheral *peripheral in self.deviceArray) {
        if ([peripheral.name isEqualToString:@"Printer001"]) {
            [[SEPrinterManager sharedInstance] connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:@"连接失败"];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                    
                }
                [self performSelector:@selector(XPSVPDissmiss) withObject:self afterDelay:1.0];
            }];
        }
    }
    

    
}
//3
-(void)viewDidAppear:(BOOL)animated{
    MLLog(@"viewDidAppear");
   
}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear");

//        if (controlPeripheral!=nil) {
//            controlPeripheral.connectStaus = MYPERIPHERAL_CONNECT_STATUS_IDLE;
//            [self disconnectDevice:controlPeripheral];
//    
//        }
//    
//    controlPeripheral = nil;
//    deviceInfo = nil;
    
    
    if (refreshDeviceListTimer) {
        [refreshDeviceListTimer invalidate];
        refreshDeviceListTimer = nil;
    }
    [SVProgressHUD dismiss];

    for (CBPeripheral *peripheral in self.deviceArray) {
        if ([peripheral.name isEqualToString:@"Printer001"]) {
            [[SEPrinterManager sharedInstance] cancelPeripheral:peripheral];
        }
    }

    
}
//1
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
    
    SEPrinterManager *mManager = [SEPrinterManager sharedInstance];
    [mManager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
        MLLog(@"perpherals:%@",perpherals);
        _deviceArray = [NSMutableArray new];
        [_deviceArray addObjectsFromArray:perpherals];
    } failure:^(SEScanError error) {
        MLLog(@"error:%ld",(long)error);
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
        [self initGPDevice];

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
            //方式一：
            HLPrinter *printer = [self getPrinter];
            
            NSData *mainData = [printer getFinalData];
            [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
                MLLog(@"写入结：%d---返回消息:%@",completion,error);
            }];

        }
        
        }
            break;
            
        default:
            break;
    }
}
#pragma mark----****----xprinter打印任务
- (HLPrinter *)getPrinter
{
    HLPrinter *printer = [[HLPrinter alloc] init];
    NSString *title = @"测试电商";
    //    NSString *str1 = @"测试电商服务中心(销售单)";
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    //    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    //    [printer appendBarCodeWithInfo:@"RN3456789012"];
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"时间:" value:@"2016-04-27 10:01:50" valueOffset:150];
    [printer appendTitle:@"订单:" value:@"4000020160427100150" valueOffset:150];
    [printer appendText:@"地址:深圳市南山区学府路东深大店" alignment:HLTextAlignmentLeft];
    
    [printer appendSeperatorLine];
    [printer appendLeftText:@"商品" middleText:@"数量" rightText:@"单价" isTitle:YES];
    CGFloat total = 0.0;
    NSDictionary *dict1 = @{@"name":@"铅笔测试一下哈哈",@"amount":@"5",@"price":@"2.0"};
    NSDictionary *dict2 = @{@"name":@"abcdefghijfdf",@"amount":@"1",@"price":@"1.0"};
    NSDictionary *dict3 = @{@"name":@"abcde笔记本啊啊",@"amount":@"3",@"price":@"3.0"};
    NSArray *goodsArray = @[dict1, dict2, dict3];
    for (NSDictionary *dict in goodsArray) {
        [printer appendLeftText:dict[@"name"] middleText:dict[@"amount"] rightText:dict[@"price"] isTitle:NO];
        total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
    }
    
    [printer appendSeperatorLine];
    NSString *totalStr = [NSString stringWithFormat:@"%.2f",total];
    [printer appendTitle:@"总计:" value:totalStr];
    [printer appendTitle:@"实收:" value:@"100.00"];
    NSString *leftStr = [NSString stringWithFormat:@"%.2f",100.00 - total];
    [printer appendTitle:@"找零:" value:leftStr];
    
    [printer appendSeperatorLine];
    
    [printer appendText:@"位图方式二维码" alignment:HLTextAlignmentCenter];
    [printer appendQRCodeWithInfo:@"www.baidu.com"];
    [printer appendSeperatorLine];
    [printer appendSeperatorLine];
    
    [printer appendFooter:nil];
    [printer appendSeperatorLine];
    [printer appendSeperatorLine];
    [printer appendSeperatorLine];
    
    //    [printer appendImage:[UIImage imageNamed:@"ico180"] alignment:HLTextAlignmentCenter maxWidth:300];
    
    // 你也可以利用UIWebView加载HTML小票的方式，这样可以在远程修改小票的样式和布局。
    // 注意点：需要等UIWebView加载完成后，再截取UIWebView的屏幕快照，然后利用添加图片的方法，加进printer
    // 截取屏幕快照，可以用UIWebView+UIImage中的catogery方法 - (UIImage *)imageForWebView
    
    return printer;
}

/**
 输入框代理方法
 
 @param mText 返回输入内容
 */
- (void)mShopCarRightViewDelegateWithPhoneTextEndEditing:(NSString *)mText{
    MLLog(@"输入的内容是：%@",mText);
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

- (void)initGPDevice{
    
    connectedDeviceInfo = [NSMutableArray new];
    connectingList = [NSMutableArray new];
    
    deviceInfo = [[DeviceInfo alloc]init];
    refreshDeviceListTimer = nil;
    [self setConnectionStatus:LE_STATUS_IDLE];
    controlPeripheral = [MyPeripheral new];
    
    [self startScan];
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
            [self performSelector:@selector(XPSVPDissmiss) withObject:nil afterDelay:3];

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

@end
