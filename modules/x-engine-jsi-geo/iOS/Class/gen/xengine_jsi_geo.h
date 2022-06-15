
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "JSIModule.h"
#import "JSONModel.h"

@protocol LocationDTO;
@protocol LocationStatusDTO;
@class LocationDTO;
@class LocationStatusDTO;

@interface LocationDTO: JSONModel
  	@property(nonatomic,copy) NSString* longitude;
   	@property(nonatomic,copy) NSString* latitude;
   	@property(nonatomic,copy) NSString* address;
   	@property(nonatomic,copy) NSString* country;
   	@property(nonatomic,copy) NSString* province;
   	@property(nonatomic,copy) NSString* city;
   	@property(nonatomic,copy) NSString* district;
   	@property(nonatomic,copy) NSString* street;
@end


@interface LocationStatusDTO: JSONModel
  	@property(nonatomic,assign) NSInteger code;
   	@property(nonatomic,copy) NSString* msg;
@end



@protocol xengine_jsi_geo_protocol
   @required 
     - (void) _locate:(void (^)(LocationDTO* result,BOOL complete)) completionHandler;

   @required 
     - (void) _locatable:(void (^)(LocationStatusDTO* result,BOOL complete)) completionHandler;

@end



@interface xengine_jsi_geo : JSIModule<xengine_jsi_geo_protocol>
@end

