/**
 * @copyright 广州诺谱盾信息科技有限公司
 * @author zhangzuohai@126.com
 * @since v3.1.2
 */
#ifndef NPDSophKey_h
#define NPDSophKey_h

#import "LopeKitDefine.h"

@class CBPeripheral;
@class CBCentralManager;

#pragma mark --Delegate defination

@protocol NPDSophKeyDelegate <NSObject>

@optional
//初始化结果
- (void)initResult:(BOOL)success errorCode:(NPDErrorCode)code;

/**
 * 扫描结果
 * success:YES,扫描成功，NO，扫描失败
 * code:扫描失败时，返回具体的错误码
 * infos:如果扫描失败，为nil，如果扫描成功，返回周边扫描到的设备
 **/
- (void)scanResult:(BOOL)success errorCode:(NPDErrorCode)code extInfo:(NSArray *)infos;

/**
 * 开门结果
 * success:YES,开门成功，NO，开门失败
 * code:开门失败时，返回具体的错误码
 * infor:附加信息
 **/
- (void)openDoorResult:(BOOL)success errorCode:(NPDErrorCode)code extInfo:(NSDictionary *)info;

/**
 *点亮梯控结果
 *success:YES,成功，NO，失败
 *code:错误码
 */
- (void)lightLiftResult:(BOOL)success errorCode:(NPDErrorCode)code;

@end

#pragma mark -- Interface defination

@interface NPDSophKey : NSObject

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)copy NS_UNAVAILABLE;

/**
 * 返回单例对象
 * @return 返回单例对象
 */
+ (instancetype)sharedSophKey;

/**
 * sdk初始化
 * @param pid 分配个业务方的商务标示，该标示与业务方的app包名/bundleId绑定
 * @param delegate 委托对象
 */
- (void)configureWithPid:(NSString *)pid delegate:(id <NPDSophKeyDelegate>)delegate;

/**
 * 发起外设扫描
 * @param seconds 扫描周期，推荐0.15，即150毫秒
 * @param serviceUUIDs 扫描的uuid范围
 * @param immediately 是否扫到第一个设备后立即停止扫描并回调
 */
- (void)startScanWithInterval:(NSTimeInterval)seconds serviceUUIDs:(NSArray *)serviceUUIDs immediately:(BOOL)immediately;

/**
 * 解析iKEY设备自定义广播数据
 * @param advertisementData 广播数据
 * @return 解析后的广播数据结构
 */
- (NSDictionary *)parseAdvertisementData:(NSDictionary *)advertisementData;

/**
 * 设置门禁对应的卡片黑名单
 * @param blacklist ，一个以deviceId为key, 卡片的物理地址列表位val的字典对象
 * 例如：
 * blacklist = @{
            @"2297": @[@1203616793, @78652341, @13675867645],
            @"2336": @[@1203616793]
    };
    其中，2297,2336是设备物理地址(无符号整数)的字符串形式，列表中的1203616793,78652341...是黑名单卡片的物理地址
 * @return YES or NO
 */
- (BOOL)setRFIDTagBlackList:(NSDictionary *)blacklist;

/**
 * 发起开门操作
 * @param key 设备密钥
 * @param fwVersion 设备版本 (扫描的广播解析会返回)
 * @param peripheral 外设对象
 */
- (void)openDoorWithKey:(NSString *)key fwVersion:(short)fwVersion peripheral:(CBPeripheral *)peripheral;

/**
 * 发起开门操作，当用户自定义自己的centralManager对象时，开门方法必须将centralManager作为参数传入
 * @param key 设备密钥
 * @param fwVersion 设备版本 (扫描的广播解析会返回)
 * @param peripheral 外设对象
 * @param centralManager 用户自定义的centralManager对象
 */
- (void)openDoorWithKey:(NSString *)key fwVersion:(short)fwVersion peripheral:(CBPeripheral *)peripheral centralManager:(CBCentralManager *)centralManager;

/**
 * 发起开门操作，当用户自定义自己的centralManager对象时，开门方法必须将centralManager作为参数传入
 * @param key 设备密钥
 * @param fwVersion 设备版本 (扫描的广播解析会返回)
 * @param peripheral 外设对象
 * @param centralManager 用户自定义的centralManager对象
 * @param deviceId 设备的物理地址
 */
- (void)openDoorWithKey:(NSString *)key fwVersion:(short)fwVersion peripheral:(CBPeripheral *)peripheral centralManager:(CBCentralManager *)centralManager deviceId:(NSUInteger)deviceId;

/**
 * 是否开启日志打印
 * @param enable YES
 */
+ (void)enableLog:(BOOL)enable;

/**
 * 点亮梯控
 * @param mac  梯控设备mac
 * @param ioIndex  梯控设备输出口编号
 */
-(void) lightLiftWithMac:(NSString*) mac ioIndex:(NSInteger)ioIndex;
@end

#endif
