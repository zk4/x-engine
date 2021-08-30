//
//  Native_geo_gaode.h
//  geo_gaode
//

#import <Foundation/Foundation.h>
#import "XENativeModule.h"
#import "iGeo_gaode.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface Native_geo_gaode : XENativeModule <iGeo_gaode,AMapLocationManagerDelegate>
 
@end

NS_ASSUME_NONNULL_END
