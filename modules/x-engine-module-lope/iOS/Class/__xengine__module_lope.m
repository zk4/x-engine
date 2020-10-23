//
//  xengine__module_lope.m
//  lope
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_lope.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>
#import <LopeKit/LopeKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <AVFoundation/AVFoundation.h>

#define PID          @"03jfuto709chalfwo84nf921qujt5p"
#define kReadUUID    @"2560"
#define kServiceUUID @"FF09"
#define kPeripheralName @"EEEE"
@interface __xengine__module_lope()<NPDSophKeyDelegate, CBCentralManagerDelegate>
@property (nonatomic,strong ) NSDictionary            *blacklist;
@property (nonatomic, strong) CBCentralManager        *centralManager;
@property (nonatomic, strong) NPDSophKey              *key;
@property (nonatomic, strong) NSArray                 *locks;
@property (nonatomic, strong) NSMutableArray          *scanLocks;
@property (nonatomic, strong) NSString                *lift;
@property (nonatomic, assign) BOOL                    busy;
@property (nonatomic, assign) BOOL                    isCustomCentralManager;
@property (nonatomic,strong ) AVAudioPlayer           *openDoorAudio;
@property (nonatomic,strong ) CBPeripheralManager     *peripheralManager;
@property (nonatomic,strong ) CBMutableService        *service;
@property (nonatomic,strong ) CBMutableCharacteristic *characteristic;
@property (nonatomic,assign ) BOOL                    bleEnable;
@property (nonatomic,strong ) NSDate                  *startTime;
@end

@implementation __xengine__module_lope

- (instancetype)init{
    self = [super init];
    // 门禁设备信息将导出给接入方, 包括MAC，秘钥等基本信息
    //@"mac":@"9C:1D:58:0D:01:E7", @"key": @"j58uM2iFxazkdPtsuf43Ew"
    self.locks =  @[@{@"mac":@"00:18:E4:0C:73:89", @"key": @"12345678"},
                    @{@"mac":@"00:18:E4:0C:6C:21", @"key": @"12345678"}];
    
    // 当需要下发卡片黑名单时，ikeyplus物理ID: @[卡片1ID, 卡片2ID..]，格式存储, 在开门时可写入.
    self.blacklist = @{
            @"2297": @[@1203616793],
            @"4965": @[],
            @"2285": @[]
    };
    
    // 梯控设备信息导出给接入方，包括Mac，楼层对应设备IO口等
    self.lift = @"B0:7E:11:F4:D9:94";
    
    [self createSdkAndConfigureWithPid:PID];
    [self setupUI];
    //[self.key setRFIDTagBlackList:blacklist];
    self.scanLocks = [NSMutableArray new];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
//    [self becomeFirstResponder];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    return self;
}

-(void) createSdkAndConfigureWithPid:(NSString*)pid {
    [NPDSophKey enableLog:YES];
    NPDSophKey *key = [NPDSophKey sharedSophKey];
    [key configureWithPid:pid delegate:self];
    self.key = key;
}

-(void) setupUI {
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"dooropen" ofType:@"mp3"];
    NSURL *audioUrl = [[NSURL alloc] initFileURLWithPath:audioPath];
    self.openDoorAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
    [self.openDoorAudio prepareToPlay];
}

- (void)_customOpenDoor:(void (^)(BOOL))completionHandler {
    if (!self.busy) {
        self.isCustomCentralManager = YES;
        self.startTime = [NSDate new];
        self.busy = YES;
        [self.scanLocks removeAllObjects];

        [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"2560"]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey: @YES}];
        [self performSelector:@selector(stopBleScan) withObject:nil afterDelay:1];
    } else {
        NSLog(@"正在执行,请稍后..");
    }

}

- (void)_openDoor:(void (^)(BOOL))completionHandler {
    if (!self.busy) {
        self.isCustomCentralManager = NO;
        self.startTime = [NSDate new];
        self.busy = YES;

        [self.key startScanWithInterval:1 serviceUUIDs:@[@"2560",@"FEE7"] immediately:NO];
    } else {
        NSLog(@"正在执行,请稍后..");
    }
}

#pragma mark - NPDSophKeyDelegate
- (void)initResult:(BOOL)success errorCode:(NPDErrorCode)code {
    if (success) {
        NSLog(@"Init success");
    } else {
        NSLog(@"Init failed, code:%@", @(code));
    }
}

- (void)openDoorResult:(BOOL)success errorCode:(NPDErrorCode)code extInfo:(NSDictionary *)info {
    NSLog(@"Open door result %@. extInfo:%@, code: %li", success ? @"success" : @"failed", info, (long)code);
    NSLog(@"consuming: %f", [[NSDate new] timeIntervalSinceDate:self.startTime]);
    self.busy = NO;
}

- (void)scanResult:(BOOL)success errorCode:(NPDErrorCode)code extInfo:(NSArray *)infos {
    if (success) {
        NSLog(@"Scan success.infos:%@", infos);
        if (infos && [infos count] > 0) {
            for (NSDictionary *item in infos) {
                if ([self testOpenIfOk:item]) {
                    return;
                }
            }
        }
    } else {
        NSLog(@"Scan failed code:%@", @(code));
    }
    self.busy = NO;
}

- (void)lightLiftResult:(BOOL)success errorCode:(NPDErrorCode)code {
    if (success) {
        NSLog(@"数据发送成功，请查看电梯楼层是否点亮");
    } else {
        NSLog(@"点亮电梯楼层失败，错误码: %li",(long)code);
    }
}

- (BOOL)testOpenIfOk:(NSDictionary *)device {
    if (device && [device[K_TYPE] isEqual:@1]) {
        for (NSDictionary *myDev in self.locks) {
            if ([myDev[@"mac"] isEqualToString:device[K_MAC]]) {
                [self playAudio];
                [self.key openDoorWithKey:myDev[@"key"] fwVersion:[device[K_FW_VERSION] shortValue]
                               peripheral:device[K_PERIPHERAL]
                           centralManager:self.isCustomCentralManager ? self.centralManager : nil deviceId:[device[K_DEVICE_ID] unsignedIntegerValue]];
                return YES;
            }
        }
    }
    return NO;
}

- (void) playAudio{
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [weakSelf.openDoorAudio play];
    });
}

- (void)stopBleScan {
    [self.centralManager stopScan];
    [self scanResult:YES errorCode:NPDOK extInfo:self.scanLocks];
}

- (void)_lightLift:(void (^)(BOOL))completionHandler {
    [self.key lightLiftWithMac:self.lift ioIndex:4];
}



#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
        NSLog(@"蓝牙已经打开");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"%@", peripheral);
    NSMutableDictionary *device = [[NSMutableDictionary alloc] initWithDictionary:[self.key parseAdvertisementData:advertisementData]];
    device[K_PERIPHERAL] = peripheral;
    if ([device[@"npd_type"] isEqual:@1]) {
        NSLog(@"iKEY设备 %@", device);
        [self.scanLocks addObject:device];
    }
}

#pragma mark - Protocol conformance
// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
//    [self openDoor];
    return;
}

// 摇一摇取消摇动
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"取消摇动");
    return;
}

// 摇一摇摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        NSLog(@"摇动结束");
    }
    return;
}
@end
 
