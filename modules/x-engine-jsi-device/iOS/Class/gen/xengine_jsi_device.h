
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol phoneDto;
@protocol DeviceDTO;
@protocol _pickContact_com_zkty_jsi_device_0_DTO;
@class phoneDto;
@class DeviceDTO;
@class _pickContact_com_zkty_jsi_device_0_DTO;

@interface phoneDto: JSONModel
  	@property(nonatomic,copy) NSString* phoneNum;
   	@property(nonatomic,copy) NSString* phoneMsg;
@end


@interface DeviceDTO: JSONModel
  	@property(nonatomic,copy) NSString* type;
   	@property(nonatomic,copy) NSString* systemVersion;
   	@property(nonatomic,copy) NSString* language;
   	@property(nonatomic,copy) NSString* UUID;
   	@property(nonatomic,copy) NSString* photoType;
@end


@interface _pickContact_com_zkty_jsi_device_0_DTO: JSONModel
  	@property(nonatomic,copy) NSString* name;
   	@property(nonatomic,copy) NSString* phone;
@end



@protocol xengine_jsi_device_protocol
   @required 
    - (NSString*) _getStatusBarHeight;

   @required 
    - (NSString*) _getNavigationHeight;

   @required 
    - (NSString*) _getScreenHeight;

   @required 
    - (NSString*) _getTabbarHeight;

   @required 
    - (NSString*) _callPhone:(phoneDto*)dto;

   @required 
    - (NSString*) _sendMessage:(phoneDto*)dto;

   @required 
     - (void) _getDeviceInfo:(void (^)(DeviceDTO* result,BOOL complete)) completionHandler;

   @required 
     - (void) _pickContact:(void (^)(_pickContact_com_zkty_jsi_device_0_DTO* result,BOOL complete)) completionHandler;

@end



@interface xengine_jsi_device : JSIModule<xengine_jsi_device_protocol>
@end

