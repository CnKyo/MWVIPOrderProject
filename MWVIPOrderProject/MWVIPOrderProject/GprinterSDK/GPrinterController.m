//
//  GPrinterController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/29.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "GPrinterController.h"

@interface GPrinterController ()

@end

@implementation GPrinterController
@synthesize connectionStatus,deviceInfo,controlPeripheral,connectedDeviceInfo,connectingList;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    connectedDeviceInfo = [NSMutableArray new];
    connectingList = [NSMutableArray new];
    
    deviceInfo = [[DeviceInfo alloc]init];

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


///开始扫描
+ (void)MWStartScanDevice{
    
}
///停止扫描
+ (void)MWStopScanDevice{

}
///链接设备
+ (void)MWConnectDevice:(MyPeripheral *)mDevice{

}
///断开设备
+ (void)MWDisconnectDevice:(MyPeripheral *)mDevice{

}
@end
