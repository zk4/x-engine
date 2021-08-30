//
//  iGeo_gaode.h
//  Geo_gaode
//

#ifndef iGeo_gaode_h
#define iGeo_gaode_h
@protocol iGeo_gaode <NSObject>
 
// 单次定位
-(void)geoSinglePositionResult:(void(^)(NSDictionary *reDic))geoResult;

-(void) initSDK:(NSString*) key;

@end
#endif /* iGeo_gaode_h */
