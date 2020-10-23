
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import <xengine__module_BaseModule.h>
#import "JSONModel.h"

@protocol DeviceSheetDTO;
@protocol DeviceMoreDTO;

@interface DeviceSheetDTO: JSONModel
  	@property(nonatomic,strong) NSString* __event__;
@end
    

@interface DeviceMoreDTO: JSONModel
  	@property(nonatomic,copy) NSString* content;
@end
    


@protocol xengine__module_device_protocol
       @required 
        - (void) _getPhoneType:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getSystemVersion:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getUDID:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getBatteryLevel:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getPreferredLanguage:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getScreenWidth:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getScreenHeight:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getSafeAreaTop:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getSafeAreaBottom:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getSafeAreaLeft:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getSafeAreaRight:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getStatusHeight:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getNavigationHeight:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

      @required 
        - (void) _getTabBarHeight:(DeviceSheetDTO*) dto complete:(void (^)(DeviceMoreDTO* result,BOOL complete)) completionHandler;

@end
  


@interface xengine__module_device : xengine__module_BaseModule<xengine__module_device_protocol>
@end

