//
//  Native_geo_gaode.m
//  geo_gaode
//


#import "Native_geo_gaode.h"
#import "XENativeContext.h"

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
        NSLog(@"定位结果");
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            
            NSLog(@"location:%@", location);
            
            if (regeocode)
            {
                NSLog(@"reGeocode:%@", regeocode);
            }
        }];
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
 
