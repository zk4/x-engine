
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine__module_geo.h"
#import <micros.h>


@implementation GeoReqDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	if ([propertyName isEqualToString:@"type"]) { return YES; }	return NO;
    }
@end
    
  
@implementation GeoEventDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	if ([propertyName isEqualToString:@"__event__"]) { return YES; }	return NO;
    }
@end
    
  
@implementation GeoResDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    
  
@implementation GeoReverseReqDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {	if ([propertyName isEqualToString:@"type"]) { return YES; }
   	if ([propertyName isEqualToString:@"longitude"]) { return YES; }
   	if ([propertyName isEqualToString:@"latitude"]) { return YES; }	return NO;
    }
@end
    
  
@implementation GeoLocationResDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   
   	return NO;
    }
@end
    




  @implementation xengine__module_geo
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.module.geo";
    }
    
    - (void) coordinate:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          GeoReqDTO* dto = [self convert:dict clazz:GeoReqDTO.class];
          [self _coordinate:dto complete:^(GeoResDTO* result,  BOOL complete) {
            completionHandler(result,complete);
          }];
        
      }
    - (void) locate:(NSDictionary*) dict complete:(XEngineCallBack)completionHandler {

          GeoEventDTO* dto = [self convert:dict clazz:GeoEventDTO.class];
          [self _locate:dto complete:^(BOOL complete) {
             completionHandler(nil ,complete);
          }];
      }
  @end
