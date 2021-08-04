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
 
    
- (void)_locate:(void (^)(LocationDTO *, BOOL))completionHandler {
 
    [self.gaodegeo geoSinglePositionResult:^(NSDictionary *reDic) {
        LocationDTO *dto = [[LocationDTO alloc] init];
 
        dto.longitude = reDic[@"longitude"];
        dto.latitude = reDic[@"latitude"];
        dto.address = reDic[@"formattedAddress"];
        dto.country = reDic[@"country"];
        dto.province = reDic[@"province"];
        dto.city = reDic[@"city"];
        dto.district = reDic[@"district"];
        dto.street = reDic[@"street"];
        completionHandler(dto,YES);
    }];
}

@end
