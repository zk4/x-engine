//
//  JSI_geo.m
//  geo
//


#import "JSI_geo.h"
#import "JSIContext.h"
#import "XENativeContext.h"
#import "iGeo.h"
#import "iStore.h"
#import "JSONModel.h"

#define JSI_GEO_LAST_LOCATION @"JSI_GEO_LAST_LOCATION"

@interface JSI_geo()
@property(nonatomic,strong) id<iGeo> geo;
@property(nonatomic,strong) id<iStore> store;
@end

@implementation JSI_geo
JSI_MODULE(JSI_geo)

- (void)afterAllJSIModuleInited {
    self.geo= XENP(iGeo);
    self.store= XENP(iStore);
}
 
    
- (void)_locate:(void (^)(LocationDTO *, BOOL))completionHandler {
    NSDictionary* d = [self.store get:JSI_GEO_LAST_LOCATION];
    NSError* err;
    if(d){
        LocationDTO* last = [[LocationDTO alloc] initWithDictionary:d error:&err];
        if(!err){
            completionHandler(last,NO);
        }
    }

    [self.geo geoSinglePositionResult:^(NSDictionary *reDic) {
        if (reDic == nil) {
            completionHandler(NULL,YES);
        }else{
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
            [self.store set:JSI_GEO_LAST_LOCATION val:dto.toDictionary];
        }
    }];
}

- (void)_locatable:(void (^)(LocationStatusDTO *, BOOL))completionHandler {
    [self.geo getPositionStateResult:^(BOOL isOpen) {
        LocationStatusDTO *dto = [[LocationStatusDTO alloc]init];
        dto.msg = isOpen?@"0：已授权，可获取定位":@"-1：未授权，无法定位";
        dto.code = isOpen?0:-1;
    }];
}


@end
