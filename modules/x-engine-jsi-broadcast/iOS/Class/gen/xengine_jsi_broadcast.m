
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_broadcast.h"


@implementation NamedDTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    
  
@implementation _0_com_zkty_jsi_broadcast_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end
    




  @implementation xengine_jsi_broadcast
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.jsi.broadcast";
    }
    
  
  - (id) triggerBroadcast:(NSDictionary*) dict {
      _0_com_zkty_jsi_broadcast_DTO* dto = [self convert:dict clazz:_0_com_zkty_jsi_broadcast_DTO.class];
      [self _triggerBroadcast:dto];
                 return nil;
        }
  @end