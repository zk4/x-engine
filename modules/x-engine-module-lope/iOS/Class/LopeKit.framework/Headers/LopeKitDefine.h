/**
 * @copyright 广州诺谱盾信息科技有限公司
 * @author zhangzuohai@126.com
 * @since v3.1.1
 */
#ifndef LopeKitDefine_h
#define LopeKitDefine_h

#define SDK_VERSION         @"3.1.2"

typedef NS_ENUM (NSInteger, NPDErrorCode) {
    NPDOK               = 0,//OK
    NPDInitSuccess      = 1000,//初始化成功
    NPDUnInit,                          //未执行初始化操作
    NPDBadPid,                          //pid无效
    NPDNoNetwork,                       //无法连接网络
    NPDScanFailed,                      //扫描失败
    NPDConnectFailed,                   //无法连接设备
    NPDBluetoothNotOpen,                //蓝牙未打开
    NPDScanTimeOut,                     //扫描超时
    NPDScanNotFoundDevice,              //未发现蓝牙设备
    NPDOpenDoorFailed,                  //开门失败
    NPDOpenDoorKeyError,                //密钥错误
    NPDOpenDoorNoAuthority,             //无授权
    NPDOpenDoorGetInfoFailed,           //获取门禁信息失败
    NPDOpenDoorTimeout,                 //超时
    NPDOpenDoorKeyFormattingIllegal,    //密钥格式不合法
    NPDLiftDataError,                   //发送给梯控的数据不合法
    NPDNoAuthority      = 3000001,//无权限
    NPDSessionTimeout   = 3000002,//session 过期
    NPDInvalidOid       = 3000012,//无效的OID
    NPDPidNotMatchAppID = 3000013,//pid与appid不匹配
    NPDInvalidPid       = 3000014,//无效的pid
    NPDServiceError     = 5000000,//服务器异常
};

typedef NS_ENUM (NSInteger, NPDAccessType) {
    NPDAccessTypeIKey = 0,  //iKey记录
    NPDAccessTypeCard,      //刷卡记录
    NPDAccessTypeBracelet,  //手环记录
};

typedef NS_ENUM (NSInteger, NPDDeviceType) {
    NPDDeviceTypeIKey = 0x01,  //iKey
    NPDDeviceTypeIKeyPlus = 0x02,      //iKey Plus
};

typedef NS_ENUM (NSInteger, NPDGuardType) {
    NPDGuardTypePublic = 0,  //公共门禁
    NPDGuardTypeEntrance,      //入户锁
};
/**
 * IKEY设备广播标示
 */
static short iKEY_P14 = 0x0000;
static short iKEY_P20 = 0x4c4f;
/**
 * ikey固件协议版本
 */
static short iKEY_FW_VERSION_14 = 0x14;
static short iKEY_FW_VERSION_20 = 0x20;
#endif /* LopeKitDefine_h */
