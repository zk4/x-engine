
// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


#import "xengine_jsi_globalstorage.h"


@implementation _set_com_zkty_jsi_globalstorage_0_DTO
    + (BOOL)propertyIsOptional:(NSString *)propertyName {
   	return NO;
    }
@end





  @implementation xengine_jsi_globalstorage
    - (instancetype)init
    {
        self = [super init];
        return self;
    }

    - (NSString *)moduleId{
        return @"com.zkty.jsi.globalstorage";
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
      
      _set_com_zkty_jsi_globalstorage_0_DTO* dto = [self convert:dict clazz:_set_com_zkty_jsi_globalstorage_0_DTO.class];
      
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return nil;
        }


  [self _set:dto];
         return nil;
}
  
  - (id) del:(NSDictionary*) dict {
      
      NSString* dto = [self convert:dict clazz:NSString.class];
      
        if(!dto) {
          [self showErrorAlert: @"dto 转换为空"];
          return nil;
        }


  [self _del:dto];
         return nil;
}
  @end
