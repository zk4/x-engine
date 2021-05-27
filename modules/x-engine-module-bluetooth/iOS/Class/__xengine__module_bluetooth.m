//
//  xengine__module_bluetooth.m
//  bluetooth
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_bluetooth.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <Unity.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <XEngineWebView.h>
#import "RecyleWebViewController.h"

@interface __xengine__module_bluetooth()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property(nonatomic,strong)CBCentralManager *manager; // 中心管理者(管理设备的扫描和连接)
@property(nonatomic,strong)NSMutableArray *peripherals;// 存储的设备
@property (nonatomic, assign)CBManagerState peripheralState;// 外设状态
@property (nonatomic,assign)BOOL linkSuccess;
@property (nonatomic,strong)CBPeripheral *peripheral;
@property (nonatomic,strong)CBService *service;
@property (nonatomic,strong)NSString * event;
@end

@implementation __xengine__module_bluetooth

//初始化蓝牙
- (void)_initBluetooth:(BuletoothEventDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    self.peripherals = [[NSMutableArray alloc]init];
    _linkSuccess = false;
    if (self.peripheralState == CBManagerStateUnauthorized){
        [self showAlert:@"请在iPhone的“设置-隐私”选项中允许App访问蓝牙"];
    }else if (self.peripheralState == CBManagerStatePoweredOff){
        [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"提示" message:@"请打开蓝牙" sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
        }];
    }
}

//扫描蓝牙设备
- (void)_scanBluetoothDevice:(BuletoothEventDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    if (self.peripheralState ==  CBManagerStatePoweredOn){
        [self.manager scanForPeripheralsWithServices:nil options:nil];
    }else if (self.peripheralState == CBManagerStateUnauthorized){
        [self showAlert:@"请在iPhone的“设置-隐私”选项中允许App访问蓝牙"];
    }else if (self.peripheralState == CBManagerStatePoweredOff){
        [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"提示" message:@"请打开蓝牙" sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
        }];
    }
}

//关闭扫描
- (void)_closeBluetoothDevice:(void (^)(BOOL))completionHandler {
    [self.manager stopScan];
}

//连接蓝牙设备
- (void)_linkBluetoothDevice:(BuletoothDeviceDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler{
    self.event = dto.__event__;
    CBPeripheral* peripheral = [self getPeripheralByparam:dto.deviceID];
    if (peripheral != NULL)  [_manager connectPeripheral:peripheral options:nil];
}

//断开连接蓝牙设备
- (void)_cancelLinkBluetoothDevice:(BuletoothDeviceDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    CBPeripheral* peripheral = [self getPeripheralByparam:dto.deviceID];
    if (peripheral != NULL) [_manager cancelPeripheralConnection:peripheral];
}

//获取蓝牙设备服务
- (void)_discoverServices:(BuletoothDeviceDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    if (self.linkSuccess) {
        CBPeripheral* peripheral = [self getPeripheralByparam:dto.deviceID];
        if (peripheral != NULL) [peripheral discoverServices:nil];
    }else{
        NSLog(@"未连接蓝牙设备");
    }
}

//获取对应蓝牙设备服务的特征
- (void)_discoverCharacteristics:(BtCharacteristicsDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    CBPeripheral* peripheral = [self getPeripheralByparam:dto.deviceID];
    if (peripheral.services == NULL) {
        NSLog(@"未获取蓝牙设备服务");
        return;
    }
    for (CBService *service in peripheral.services) {
        if ([dto.serviceId isEqualToString:service.UUID.UUIDString]) {
            _service = service;
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

//向对应特征值写入数据
- (void)_writeValueForCharacteristic:(BtCharacteristicIdDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler {
    self.event = dto.__event__;
    if (self.service == NULL) {
        NSLog(@"未获取对应服务特征");
    }else{
        for (CBCharacteristic *characteristic in self.service.characteristics) {
            if ([dto.characteristicId isEqualToString:characteristic.UUID.UUIDString]) {
                NSData *data = [@"hello word" dataUsingEncoding:NSUTF8StringEncoding];
                [self.peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            }
        }
    }
}

- (void)_readCharacteristic:(BtCharacteristicIdDTO *)dto complete:(void (^)(BuletoothContentDTO *, BOOL))completionHandler{
    if (self.service == NULL) {
        NSLog(@"未获取对应服务特征");
    }else{
        for (CBCharacteristic *characteristic in self.service.characteristics) {
            if ([dto.characteristicId isEqualToString:characteristic.UUID.UUIDString]) {
                [self.peripheral readValueForCharacteristic:characteristic];
            }
        }
    }
}



#pragma mark bluetoothDelegate

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
    case CBManagerStateUnknown:
            [self sendToWebView:@"CBManagerStateUnknown"];
            self.peripheralState = central.state;
        break;
    case CBManagerStateResetting:
            [self sendToWebView:@"CBManagerStateResetting"];
            self.peripheralState = central.state;
        break;
    case CBManagerStateUnsupported:
            [self sendToWebView:@"CBManagerStateUnsupported"];
            self.peripheralState = central.state;
        break;
    case CBManagerStateUnauthorized:
            [self sendToWebView:@"CBManagerStateUnauthorized"];
            self.peripheralState = central.state;
        break;
    case CBManagerStatePoweredOff:
            [self sendToWebView:@"CBManagerStatePoweredOff"];
            self.peripheralState = central.state;
        break;
    case CBManagerStatePoweredOn:
            [self sendToWebView:@"CBManagerStatePoweredOn"];
            self.peripheralState = central.state;
        break;
        default:
        break;
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (![_peripherals containsObject:peripheral] && [self getNoEmptyString:peripheral.name]) {
        NSDictionary * dict = @{
                   @"deviceID":peripheral.identifier.UUIDString,
                   @"deviceName":peripheral.name
        };
        NSLog(@"%@",dict);

        [_peripherals addObject:peripheral];
        [self sendToWebView:[JSONToDictionary toString:dict]];
    }
}

/**
 连接失败
 @param central 中心管理者
 @param peripheral 连接失败的设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    if (error){
        NSLog(@"error Discovered ConnectPeripheral for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    [self showLinkAlert:@"连接失败" withLink:false];
}

/**
 连接断开
 @param central 中心管理者
 @param peripheral 连接断开的设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    if (error){
           NSLog(@"error Discovered ConnectPeripheral for %@ with error: %@", peripheral.name, [error localizedDescription]);
           return;
    }
    [self showLinkAlert:@"连接断开" withLink:false];
}

/**
 连接成功
 
 @param central 中心管理者
 @param peripheral 连接成功的设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    peripheral.delegate = self;
    [self.manager stopScan];
    self.peripheral = peripheral;
    [self showLinkAlert:@"连接成功" withLink:true];
    
}

/**
 扫描到服务
 @param peripheral 服务对应的设备
 @param error 扫描错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (error){
        NSLog(@"error Discovered DiscoverServices for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    NSMutableArray * array = [NSMutableArray new];
    for (CBService *service in peripheral.services){
        [array addObject:service.UUID.UUIDString];
    }
    NSDictionary * dict = @{
        @"serviceId":array
    };
    [self sendToWebView:[JSONToDictionary toString: dict]];
}

/** 发现特征回调 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    if (error){
        NSLog(@"error Discovered DiscoverCharacteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }

    NSMutableArray * array = [NSMutableArray new];
    for (CBCharacteristic *characteristic in service.characteristics) {
        [array addObject:characteristic.UUID.UUIDString];
    }
    NSDictionary * dict = @{
        @"characteristicId":array
    };
    [self sendToWebView:[JSONToDictionary toString: dict]];

}

/** 写入数据回调 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error){
        NSLog(@"error Discovered WriteValueForCharacteristic for %@ with error: %@", characteristic.UUID, [error localizedDescription]);
        return;
    }
    [self sendToWebView:@"写入成功"];
}

/** 接收到数据回调 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error){
        NSLog(@"error Discovered UpdateValueForCharacteristic for %@ with error: %@", characteristic.UUID, [error localizedDescription]);
        return;
    }
    NSData *data = characteristic.value;
    NSString * dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self sendToWebView:dataStr];
}

- (void)showAlert:(NSString *)errorString{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorString preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }]];
    [topVC presentViewController:alert animated:true completion:nil];
}

-(BOOL)getNoEmptyString:(NSString *)sting{
    if (sting != nil & sting != NULL & ![sting isEqualToString:@"(null)"] & ![sting isEqualToString:@"null"] &![sting isEqualToString:@""] & ![sting isKindOfClass:[NSNull class]]){
        return YES;
    }
    return NO;
}

-(void)showLinkAlert:(NSString *)message withLink:(BOOL)link{
    __weak typeof(self) weakself = self;
    [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"提示" message:message sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
        weakself.linkSuccess = link;
    }];
}

-(void)sendToWebView:(NSString *)string{
    UIViewController *topVC = [Unity sharedInstance].getCurrentVC;
    if ([topVC isKindOfClass:RecyleWebViewController.class]) {
        RecyleWebViewController *webVC = (RecyleWebViewController *)topVC;
        BuletoothContentDTO* d = [BuletoothContentDTO new];
        d.content=string;
        [webVC.webview callHandler:self.event arguments:@[d.content] completionHandler:^(id  _Nullable value) {}];
    }
}

-(CBPeripheral *)getPeripheralByparam:(NSString*)param{
    CBPeripheral*  peripheral;
    if (_peripherals.count == 0) {
        [[Unity sharedInstance].getCurrentVC showAlertWithTitle:@"提示" message:@"未扫描到蓝牙设备" sureTitle:@"确定" sureHandler:^(UIAlertAction * _Nonnull action) {
        }];
    }else{
        for (int i =0; i<_peripherals.count; i++) {
            CBPeripheral * otherPeripheral = _peripherals[i];
            NSString * deviceID = otherPeripheral.identifier.UUIDString;
            if ([deviceID isEqualToString:param]) {
                peripheral = otherPeripheral;
            }
        }
    }
    if(peripheral == NULL){
        [self sendToWebView:@"未找到该设备"];
    }
    
    return peripheral;
}
@end
 
