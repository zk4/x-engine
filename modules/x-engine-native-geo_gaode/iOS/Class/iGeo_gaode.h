//
//  iGeo_gaode.h
//  Geo_gaode
//

#ifndef iGeo_gaode_h
#define iGeo_gaode_h
@protocol iGeo_gaode <NSObject>
/**
 初始化sdk，传入key
 */
-(BOOL)initSDKByConfig:(NSDictionary*)config;
/**
 单次定位
 */
-(void)geoSinglePositionResult:(void(^)(NSDictionary *reDic))geoResult;

@end
#endif /* iGeo_gaode_h */
