//
//  JSI_geo.m
//  geo
//


#import "JSI_geo.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iGeo_gaode.h"

@interface JSI_geo()
@property(nonatomic,strong) id<iGeo_gaode> gaodegeo;
@end

@implementation JSI_geo
JSI_MODULE(JSI_geo)

- (void)afterAllJSIModuleInited {
    self.gaodegeo= XENP(iGeo_gaode);
}

   
 

- (void)_simpleMethod:(void (^)(BOOL))completionHandler {
    NSLog(@"hello,_simpleMethod");
}

- (void)_simpleMethod {
    NSLog(@"hello,_simpleMethod");
    
}

- (NSString *)_simpleArgMethod:(NSString *)dto {
    return @"from native sync";
}


- (void)_simpleArgMethod:(NSString *)dto complete:(void (^)(NSString *, BOOL))completionHandler {
    completionHandler(@"from native async",TRUE);
}
 

- (NSInteger)_simpleArgNumberMethod:(NSInteger)dto {
    return dto;
}

- (void)_simpleArgNumberMethod:(NSInteger)dto complete:(void (^)(NSInteger, BOOL))completionHandler {
    completionHandler(dto,TRUE);
}

- (void)_locate:(void (^)(LocationDTO *, BOOL))completionHandler {
    NSLog(@"定位进来了");
    ///TODO: 参数暂时在内部写死
    [self.gaodegeo initSDKByConfig:@{@"keyString":@"c68c60fb8801d81927bb6746a93a6fce"}];
    [self.gaodegeo geoSinglePositionResult:^(NSDictionary *reDic) {
        LocationDTO *dto = [[LocationDTO alloc] init];
//        @property(nonatomic,copy) NSString* longitude;
//         @property(nonatomic,copy) NSString* latitude;
//         @property(nonatomic,copy) NSString* address;
//         @property(nonatomic,copy) NSString* country;
//         @property(nonatomic,copy) NSString* province;
//         @property(nonatomic,copy) NSString* city;
//         @property(nonatomic,copy) NSString* district;
//         @property(nonatomic,copy) NSString* street;
        dto.longitude = reDic[@"longitude"];
        dto.latitude = reDic[@"latitude"];
        dto.address = reDic[@"address"];
        dto.country = reDic[@"country"];
        dto.province = reDic[@"province"];
        dto.city = reDic[@"city"];
        dto.district = reDic[@"district"];
        dto.street = reDic[@"street"];
        completionHandler(dto,YES);
    }];
}

@end
