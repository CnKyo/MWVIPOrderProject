//
//  MWModel.h
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/6/21.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWHeader.h"

@interface MWModel : NSObject

@end
@interface PeripheralInfo : NSObject

@property (nonatomic,strong) CBUUID *serviceUUID;
@property (nonatomic,strong) NSMutableArray *characteristics;

@end
