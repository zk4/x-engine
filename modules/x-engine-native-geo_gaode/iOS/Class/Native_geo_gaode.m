//
//  Native_geo_gaode.m
//  geo_gaode
//


#import "Native_geo_gaode.h"
#import "XENativeContext.h"
#import <x-engine-native-protocols/iToast.h>
#import <objc/runtime.h>


@interface Native_geo_gaode()
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) NSString* apikey;

@end

@implementation Native_geo_gaode
NATIVE_MODULE(Native_geo_gaode)

- (NSString*) moduleId{
    return @"com.zkty.native.geo_gaode";
}

- (int) order{
    return 0;
}
-(void) initSDK:(NSString*) key{
    if(!key){
        [XENP(iToast) toast:@" apikey 为空"];
        return;
    }
    self.apikey = key;
    
    _locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    _locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    _locationManager.reGeocodeTimeout = 2;
    
    _locationManager.delegate = self;
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    
    [AMapServices sharedServices].apiKey = key;
}
- (void)afterAllNativeModuleInited{

} 

/**
 单次定位
 */
-(void)geoSinglePositionResult:(void(^)(NSDictionary *reDic))geoResult{
    if(!self.apikey){
        [XENP(iToast) toast:@"未设 apikey，高德没有初始化，请使用[XENP(iGeo_gaode) initSDK:] 初始化"];
        return;
    }
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error || !regeocode)
        {
            geoResult(nil);
            return;
        }
        //取出第一个位置
        NSLog(@"%@",location.timestamp);
        
        //位置坐标
        CLLocationCoordinate2D coordinate=location.coordinate;
        
        NSLog(@"您的当前位置:经度：%f,纬度：%f,海拔：%f,航向：%f,速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
        
        NSMutableDictionary *reGeoDict = [self dicFromObject:regeocode];
   
        NSString* longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        [reGeoDict setObject:longitude forKey:@"longitude"];
        
        NSString* latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        [reGeoDict setObject:latitude forKey:@"latitude" ];
        
        geoResult(reGeoDict);
        
        
    }];
}

/**
 获取当前定位权限是否开启
 */
- (void)getPositionStateResult:(void (^)(BOOL isOpen))result {
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        // 无定位权限
        result(NO);
    }else{
        result(YES);
    }
}


//model转化为字典
- (NSMutableDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return dic;
}

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager*)locationManager
{
    [locationManager requestAlwaysAuthorization];
}




@end

