//
//  Native_geo_gaode.m
//  geo_gaode
//


#import "Native_geo_gaode.h"
#import "XENativeContext.h"

#import <objc/runtime.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface Native_geo_gaode()
@property (nonatomic,strong) AMapLocationManager *locationManager;
@end

@implementation Native_geo_gaode
NATIVE_MODULE(Native_geo_gaode)

 - (NSString*) moduleId{
    return @"com.zkty.native.geo_gaode";
}

- (int) order{
    return 0;
}

- (void)afterAllNativeModuleInited{
} 


-(BOOL)initSDKByConfig:(NSDictionary*)config{
    
    if (![config isKindOfClass:[NSDictionary class]] || config.allKeys.count <= 0) {
        return NO;
    }
    NSString *keyString = config[@"keyString"];
    keyString = @"c68c60fb8801d81927bb6746a93a6fce";
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = keyString;
    
    return YES;
}

/**
 单次定位
 */
-(void)geoSinglePositionResult:(void(^)(NSDictionary *reDic))geoResult;{
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            if (error)
            {
                    geoResult(nil);
                    return;
            }
                        
            if (regeocode)
            {
                NSDictionary *reGeoDict = [self dicFromObject:regeocode];
                geoResult(reGeoDict);
            }
            else{
                geoResult(nil);
            }
        }];
}

//model转化为字典
- (NSDictionary *)dicFromObject:(NSObject *)object {
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
    
    return [dic copy];
}


-(AMapLocationManager*)locationManager{
    //首次定位精度百米以内，超时两秒
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为2s
        _locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        _locationManager.reGeocodeTimeout = 2;
    }
    return _locationManager;
}

//-(AMapLocationManager*)locationManager{
//    //首次定位精度十米以内，超时10秒
//    if (!_locationManager) {
//        // 带逆地理信息的一次定位（返回坐标和地址信息）
//        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//        //   定位超时时间，最低2s，此处设置为10s
//        _locationManager.locationTimeout =10;
//        //   逆地理请求超时时间，最低2s，此处设置为10s
//        _locationManager.reGeocodeTimeout = 10;
//    }
//    return _locationManager;
//}

@end
 
