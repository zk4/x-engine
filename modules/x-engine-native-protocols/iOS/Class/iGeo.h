//
//  iGeo.h
//  Geo
//

#ifndef iGeo_h
#define iGeo_h
@protocol iGeo <NSObject>

// 单次定位
-(void)geoSinglePositionResult:(void(^)(NSDictionary *reDic))geoResult;

-(void) initSDK:(NSString*) key;


@end
#endif /* iGeo_h */
