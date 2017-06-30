//
//  GPrinterController.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/29.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "CBController.h"
#import "DeviceInfo.h"
#import "BLKWrite.h"
#import "MWHeader.h"
@interface GPrinterController : CBController
///开始扫描
+ (void)MWStartScanDevice;
///停止扫描
+ (void)MWStopScanDevice;
///链接设备
+ (void)MWConnectDevice:(MyPeripheral *)mDevice;
///断开设备
+ (void)MWDisconnectDevice:(MyPeripheral *)mDevice;


@property (assign,nonatomic) int connectionStatus;
//Derek
@property (strong,nonatomic) DeviceInfo *deviceInfo;
@property (strong,nonatomic) MyPeripheral *controlPeripheral;
@property (strong,nonatomic) NSMutableArray *connectedDeviceInfo;//stored for DeviceInfo object
@property (strong,nonatomic) NSMutableArray *connectingList;//stored for MyPeripheral object
@end
