//
//  ViewController.m
//  27-CoreBluetooth使用
//
//  Created by 董立权 on 2017/7/20.
//  Copyright © 2017年 董立权. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

//中央管理者
@property(nonatomic,strong) CBCentralManager *centralManager;
//所有设备数组
@property(nonatomic,strong)NSMutableArray *peripherals;
@end

@implementation ViewController
-(NSMutableArray *)peripherals {
    if(!_peripherals){
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}
//懒加载
-(CBCentralManager *)centralManager {
    if(!_centralManager){
        //创建中央管理者
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    return _centralManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.使用中央管理者扫描设备 ->发现设备 -> 连接设备
    //1.1扫描设备 传入nil扫描所有设备
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    //2.设备根据UUID去发现服务
    //3.根据UUID去发现特征
    //4.根据特征去读写数据
}
#pragma mark - CBCentralManagerDelegate
//蓝牙状态更新时调用 必须要实现的required
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
}
//扫描到设备时调用
//peripheral:扫描到的设备
//advertisementData:广告数据
//RSSI:信号强度
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    //1.2添加设备并展示设备
    //判断数组中有没有相关设备
    if([self.peripherals containsObject:peripheral]){
         //添加设备到数组中
        [self.peripherals addObject:peripheral];
    }
    //在公司中,提供列表显示所有设备
   
}

//用户选择了某一个设备
-(void)selectPeripheral:(CBPeripheral *)peripheral {
    //1.3连接设备
    [self.centralManager connectPeripheral:peripheral options:nil];
}
//设备连接成功时调用
//peripheral:连接成功的设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    //根据设备去发现服务
    //传入nil表示发现所有服务
    [peripheral discoverServices:nil];
    //设置设备的代理
    peripheral.delegate = self;
}
//扫描到服务时调用
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //遍历所有的服务
    for (CBService *service in peripheral.services) {
        //根据UIID去获取特征的服务
        if([service.UUID.UUIDString isEqualToString:@"123"]){
            //获取到了UUID是123的服务
            //寻找对应的特征 传入nil表示寻找所有的特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}
//扫描到特征时调用
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error{
    //遍历所有的特征
    for (CBCharacteristic *characteristic in service.characteristics) {
        //获取指定的特征
        if([characteristic.UUID.UUIDString isEqualToString:@"456"]){
            //获取到了最下的单位:特征
            //发送数据和接受数据
            //NSData *data = UIImageJPEGRepresentation(image, 0.3);
            //发送数据
            /*
             CBCharacteristicWriteWithResponse = 0, 保证数据到达
             CBCharacteristicWriteWithoutResponse, 不保证数据到达
             */
            [peripheral writeValue:[NSData data] forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
            
            
            //读数据
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}
//读取到特征的数据后调用
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //获取读取到的数据
    NSData *data = characteristic.value;
//    [UIImage imageWithData:data];
}

@end
