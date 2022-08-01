//
//  iGeo.h
//  Geo
//

#ifndef iGeo_h
#define iGeo_h

typedef enum : NSUInteger {
    GMJLocationTypeDenied=-1,//未授权，无法定位
    GMJLocationTypeAllow=0,//已授权，可获取定位
    GMJLocationTypeNone=1,//未请求过权限(允许一次和首次安装会返回这个枚举)
} GMJLocationType;
@protocol iGeo <NSObject>

// 单次定位
-(void)geoSinglePositionResult:(void(^)(NSDictionary *reDic))geoResult;

-(void)getPositionStateResult:(void(^)(GMJLocationType locationType))result;

-(void) initSDK:(NSString*) key;


@end
#endif /* iGeo_h */
