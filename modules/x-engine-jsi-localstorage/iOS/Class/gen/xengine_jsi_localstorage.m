
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_localstorage.h"


@implementation _set0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end





  @implementation xengine_jsi_localstorage
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.jsi.localstorage";
    }
    
  
  - (NSString*) get:(NSDictionary*) dict {
      
      NSString* dto = [self convert:dict clazz:NSString.class];
      
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return nil;
        }


  return [self _get:dto];
}
  
  - (id) set:(NSDictionary*) dict {
      
      _set0_DTO* dto = [self convert:dict clazz:_set0_DTO.class];
      
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return nil;
        }


  [self _set:dto];
         return nil;
}
  @end
