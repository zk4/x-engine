//
//  Native_geo_gaode.m
//  geo_gaode
//


#import "Native_geo_gaode.h"
#import "XENativeContext.h"
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
    
    _locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
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
-(void)geoSinglePositionResult:(void(^)(NSDictionary *reDic))geoResult;{
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

