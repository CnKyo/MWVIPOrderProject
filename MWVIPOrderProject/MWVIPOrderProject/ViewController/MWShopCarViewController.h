//
//  MWShopCarViewController.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TscCommand.h"
#import "BLKWrite.h"
#import "EscCommand.h"
#import "CBController.h"
#import "DeviceInfo.h"

@interface MWShopCarViewController : CBController
{
    NSTimer *refreshDeviceListTimer;
    
    //Derek
    DeviceInfo *deviceInfo;
    MyPeripheral *controlPeripheral;
    NSMutableArray *connectedDeviceInfo;//stored for DeviceInfo object
    NSMutableArray *connectingList;//stored for MyPeripheral object
    

}
@property (assign) int connectionStatus;

@end
