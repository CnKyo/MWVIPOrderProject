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

#import "AppDelegate.h"
#import "SEPrinterManager.h"
#import "ConnectViewController.h"

#import "XYWIFIManager.h"
#import "PosCommand.h"
#import "XPTscCommand.h"
#import "ImageTranster.h"
#import "XYSDK.h"

@interface MWShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,mShopCarTableViewCellDelegate,mShopCarTableViewCellDelegate,mShopCarRightViewDelegate,CBControllerDelegate,XYWIFIManagerDelegate>

@property(strong,nonatomic)  UITableView *mLeftTableView;

@property(strong,nonatomic)  mShopCarRightView *mRightView;

/** wifi */
@property (nonatomic, strong) XYWIFIManager *wifiManager;

@property (strong, nonatomic)   NSMutableArray              *deviceArray;  /**< 蓝牙设备个数 */



@end

@implementation MWShopCarViewController
{
    NSMutableArray *peripheralDataArray;
    
    MWPrintType mPtype;
    
    CBController *mGPConnect;
    
    MyPeripheral *mGPDevice;
}
- (XYWIFIManager *)wifiManager
{
    if (!_wifiManager)
        {
        _wifiManager = [XYWIFIManager shareWifiManager];
        _wifiManager.delegate = self;
        
        }
    return _wifiManager;
}

- (void)initWifi{
    // 先断开原来的连接
    [self.wifiManager XYDisConnect];
    

    
    // 连接到 wifi
    [self.wifiManager XYConnectWithHost:@"192.168.1.123"
                                   port:(UInt16)[@"9100" integerValue]
                             completion:^(BOOL isConnect) {
                                 if (isConnect)
                                     {
                                     MLLog(@"链接。。。。。。。。。。。");
                                     }
                                 else
                                     {
                                     MLLog(@"未链接。。。。。。。。。。。");
                                     }
                             }];

}
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
    MLLog(@"viewWillDisappear");

  
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



    mGPConnect = [CBController new];
    mGPConnect.delegate = self;
//    [self.view addSubview:mGPConnect.view];
    
    mGPDevice = [MyPeripheral new];
    
    [self wifiManager];

}
- (void)updateRightView:(BOOL)mHidden{
    _mRightView.mWechatPay.hidden = _mRightView.mCashPay.hidden = _mRightView.mOutPay.hidden = _mRightView.mScorePay.hidden = mHidden;
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

- (void)hiddenView{
    _mRightView.mPopView.hidden = NO;
    [self updateRightView:YES];
    [self performSelector:@selector(XPSVPDissmiss) withObject:self afterDelay:1.0];

}
- (void)displayPopView{
    _mRightView.mPopView.hidden = YES;
    [self updateRightView:NO];
    [self performSelector:@selector(XPSVPDissmiss) withObject:self afterDelay:1.0];

}
/**
 按钮代理方法
 
 @param mTag 标记tag(0:微信支付，1:现金支付，2:外卖支付，3:积分支付)
 */
- (void)mShopCarRightViewDelegateWithBtnClicked:(NSInteger)mTag{
    MLLog(@"点击了第%ld个",mTag);
    
 
    switch (mTag) {
        case 0:
        {
        mPtype = MWPrintTypeWithWechatPay;
        [self initBlueToothe];
        [self hiddenView];
 
        }
            break;
        case 1:
        {
        mPtype = MWPrintTypeWithCashPay;
        [self initBlueToothe];
        [self hiddenView];
        }
            break;
        case 2:
        {
        mPtype = MWPrintTypeWithOutPay;
        [self initWifi];
//        [self initGPrinterBlueToothe];
//        if([[BLKWrite Instance] isConnecting]){
//            [SVProgressHUD showSuccessWithStatus:@"蓝牙设备已链接！"];
//            [self hiddenView];
//
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:@"蓝牙设备已断开！"];
//            [[BLKWrite Instance] setBWiFiMode:NO];
//            AppDelegate *dele = [UIApplication sharedApplication].delegate;
//            [self.navigationController pushViewController:dele.mConnBLE animated:YES];
//        }


        }
            break;
        case 3:
        {
        mPtype = MWPrintTypeWithScorePay;
        [self initBlueToothe];
        [self hiddenView];
        }
            break;
        case 4:
        {
        if (mPtype == MWPrintTypeWithOutPay) {
//            [self GPrinterTask];
            [self XPQ200Printer];
    
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
//    [printer appendSeperatorLine];
//    [printer appendSeperatorLine];
//    [printer appendText:@" " alignment:HLTextAlignmentCenter];
//    [printer appendText:@" " alignment:HLTextAlignmentCenter];

    [printer appendFooter:nil];
//    [printer appendSeperatorLine];
//    [printer appendSeperatorLine];
//    [printer appendSeperatorLine];

    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    [printer appendText:@" " alignment:HLTextAlignmentCenter];
//    [printer appendText:@" " alignment:HLTextAlignmentCenter];
//    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    
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

- (void)XPQ200Printer{
    
    [self getPrinter];
    ///0 or 48 代表标准；1 or 49 代表压缩字体
    [_wifiManager XYSelectFontWith:0];
    [_wifiManager XYSelectHRIFontToUse:0];

    
    NSMutableData* dataM=[NSMutableData dataWithData:[PosCommand initializePrinter]];

    NSData* data=[@"梅菜扣肉\n\n红烧兔肉\n\n土豆丝\n\n炒空心菜\n\n干锅鸡\n\n红烧鱼\n\n梅菜扣肉\n\n红烧兔肉\n\n土豆丝\n\n炒空心菜\n\n干锅鸡\n\n红烧鱼\n\n梅菜扣肉\n\n红烧兔肉\n\n土豆丝\n\n炒空心菜\n\n干锅鸡\n\n红烧鱼\n\n梅菜扣肉\n\n红烧兔肉\n\n土豆丝\n\n炒空心菜\n\n干锅鸡\n\n红烧鱼\n" dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];

    ///选择字符大小->15号字体
    [dataM appendData:[PosCommand selectCharacterSize:00001111]];
//    [dataM appendData:[PosCommand setDefultLineSpace:33]];

    [dataM appendData:data];

    [self.wifiManager XYWriteCommandWithData:dataM];
    [_wifiManager XYSelectCutPaperModelAndCutPaperWith:66 n:255 selectedModel:1];

}
#pragma mark----****----Wifi接入代理
// 成功连接主机
- (void)XYWIFIManager:(XYWIFIManager *)manager didConnectedToHost:(NSString *)host port:(UInt16)port{
    MLLog(@"wifi链接成功");
    [self hiddenView];

}
// 断开连接
- (void)XYWIFIManager:(XYWIFIManager *)manager willDisconnectWithError:(NSError *)error{
    MLLog(@"wifi链接断开");
}
// 写入数据成功
- (void)XYWIFIManager:(XYWIFIManager *)manager didWriteDataWithTag:(long)tag{
MLLog(@"wifi写入数据成功");
}
// 收到回传
- (void)XYWIFIManager:(XYWIFIManager *)manager didReadData:(NSData *)data tag:(long)tag{
    MLLog(@"wifi收到回传");

}
// 断开连接
- (void)XYWIFIManagerDidDisconnected:(XYWIFIManager *)manager{
    MLLog(@"wifi链接断开");

}

@end
