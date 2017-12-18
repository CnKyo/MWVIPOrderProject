//
//  MWPrintTaskViewController.m
//  MWVIPOrderProject
//
//  Created by mwi01 on 2017/7/18.
//  Copyright © 2017年 mwi01. All rights reserved.
//

#import "MWPrintTaskViewController.h"
#import "MWHeader.h"

#import "MWPrintTaskCell.h"
#import "SEPrinterManager.h"

@interface MWPrintTaskViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)   NSMutableArray              *deviceArray;  /**< 蓝牙设备个数 */

@end

@implementation MWPrintTaskViewController
{
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"打印任务列表";
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"MWPrintTaskCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
    
    SEPrinterManager *mManager = [SEPrinterManager sharedInstance];
    [mManager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
        MLLog(@"perpherals:%@",perpherals);
        _deviceArray = [NSMutableArray new];
        [_deviceArray addObjectsFromArray:perpherals];
    } failure:^(SEScanError error) {
        MLLog(@"error:%ld",(long)error);
    }];

}
- (void)initBlueToothe{
    if (_deviceArray.count<=0) {
        [SVProgressHUD showErrorWithStatus:@"请打开蓝牙设置后重试！"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在链接设备..."];
    
    for (CBPeripheral *peripheral in self.deviceArray) {
        if ([peripheral.name isEqualToString:@"Printer001"]) {
            [[SEPrinterManager sharedInstance] connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:@"连接失败"];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                    [self performSelector:@selector(printTask) withObject:self afterDelay:1.0];

                }
                [self performSelector:@selector(XPSVPDissmiss) withObject:self afterDelay:1.0];
            }];
        }
    }
 
    
}
- (void)XPSVPDissmiss{
    [SVProgressHUD dismiss];
    
}
- (void)printTask{
    
    //方式一：
    HLPrinter *printer = [self getPrinter];
    
    NSData *mainData = [printer getFinalData];
    [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
        MLLog(@"写入结：%d---返回消息:%@",completion,error);
    }];
    
}
#pragma mark----****----xprinter打印任务
- (HLPrinter *)getPrinter
{
    HLPrinter *printer = [[HLPrinter alloc] init];
    NSString *title = @"测试信息";
    //    NSString *str1 = @"测试电商服务中心(销售单)";
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    //    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    //    [printer appendBarCodeWithInfo:@"RN3456789012"];
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"时间:" value:@"2016-04-27 10:01:50" valueOffset:150];
    [printer appendTitle:@"订单:" value:@"4000020160427100150" valueOffset:150];
    [printer appendText:@"地址:重庆市渝北区光电园麒麟C座13-6" alignment:HLTextAlignmentLeft];
    
    [printer appendSeperatorLine];
    [printer appendLeftText:@"菜品" middleText:@"数量" rightText:@"单价" isTitle:YES];
    CGFloat total = 0.0;
    NSDictionary *dict1 = @{@"name":@"牛肉面",@"amount":@"1",@"price":@"22.0"};
    NSDictionary *dict2 = @{@"name":@"炸酱面",@"amount":@"1",@"price":@"20.0"};
    NSDictionary *dict3 = @{@"name":@"麻辣小面",@"amount":@"2",@"price":@"15.0"};
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
    
    [printer appendText:@"支付二维码" alignment:HLTextAlignmentCenter];
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
- (void)tableViewHeaderReloadData{
    
}
- (void)tableViewFooterReloadData{
    
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
    
    MWPrintTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.mName.text = @"把一本好小说毁了是什么体验，「悟空传」请抢答";
    cell.mBtnClicked = ^(UIButton *sender){
        MLLog(@"%@",[NSString stringWithFormat:@"第%ld个",indexPath.row]);
        if ([SEPrinterManager sharedInstance].isConnected) {
       
            [self printTask];
        }else{
            [self initBlueToothe];
        }
    };
    return cell;
    
}

@end
