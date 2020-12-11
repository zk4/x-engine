//
//  xengine__module_geo.m
//  geo
//
//  Created by zk on 2020/9/7.
//  Copyright © 2020 edz. All rights reserved.


#import "__xengine__module_geo.h"
#import <XEngineContext.h>
#import <micros.h>
#import <UIViewController+.h>
#import <JSONToDictionary.h>
#import <RecyleWebViewController.h>
#import <XEngineWebView.h>
#import <Unity.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <x-engine-module-engine/XEngineJSBUtil.h>

@interface __xengine__module_geo()<BMKLocationAuthDelegate,BMKLocationManagerDelegate>


@property (nonatomic,strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) GeoLocationResDTO *locationModel;

@end

@implementation __xengine__module_geo

- (void)_locate:(GeoEventDTO *)dto complete:(void (^)(BOOL))completionHandler {
//    adto=dto;
    completionHandler(TRUE);
    [self getLocation:dto];
}

-(void)getLocation:(GeoEventDTO *)geodto
{
    NSString *path = [NSBundle mainBundle].bundlePath;
    NSLog(@"路径==%@",path);
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"hwj5qKKmwqLipBYjhgX1GtXbp4QdcXIo" authDelegate:self];
    
    
    __weak typeof(self) weakself = self;
    weakself.locationModel = [[GeoLocationResDTO alloc] init];
    NSLog(@"传入参数==%@",geodto.type);
    if ([geodto.type isEqualToString:@"WGS84"]){
        weakself.locationManager.coordinateType = BMKLocationCoordinateTypeWGS84;
    }
    else if ([geodto.type isEqualToString:@"GCJ02"]){
        weakself.locationManager.coordinateType = BMKLocationCoordinateTypeGCJ02;
    }
    else if ([geodto.type isEqualToString:@"BMK09MC"]){
        weakself.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09MC;
    }
    else{
        weakself.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    }
    [weakself.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        
        
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {//得到定位信息，添加annotation
            if (location.location) {
                weakself.locationModel.longitude = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
                weakself.locationModel.latitude = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
            }
            if (location.rgcData) {
//                weakself.locationModel.locationString = [NSString stringWithFormat:@"%@,%@,%@",location.rgcData.country,location.rgcData.province,location.rgcData.city];
                weakself.locationModel.country = location.rgcData.country;
                weakself.locationModel.province = location.rgcData.province;
                weakself.locationModel.city = location.rgcData.city;
                weakself.locationModel.district = location.rgcData.district;
                weakself.locationModel.town = location.rgcData.town;
                weakself.locationModel.street = location.rgcData.street;
            }
        }
        if (weakself.locationModel == nil)
        {
//            self->hanlder(0,YES);
//            self->hanlder=nil;
        }
        else
        {
            
            NSLog(@"结果777%@==%@==%@",weakself.locationModel.longitude,weakself.locationModel.latitude,weakself.locationModel.street);
            {
                // 方法 1. 先转为 jsonstring
                NSString* jsonstring= [XEngineJSBUtil objToJsonString:weakself.locationModel];
                
                [weakself callJS:geodto.__event__ args:jsonstring retCB:^(id  _Nullable value) {
                    //处理__event__ 的返回值
                    NSLog(@"%@",value);
                }];
            }
        }
    }];
}

#pragma mark =======getter========

-(BMKLocationManager*)locationManager
{
    if (!_locationManager)
    {
        //初始化实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置delegate
        _locationManager.delegate = self;
        //设置返回位置的坐标系类型
//        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设置距离过滤参数
//        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //设置是否允许后台定位
        //_locationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

@end

